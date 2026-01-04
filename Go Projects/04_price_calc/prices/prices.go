package prices

import (
	"fmt"

	"example.com/price-calc/conversion"
	"example.com/price-calc/iomanager"
)

type TaxIncludePriceJob struct {
	IOManager 			iomanager.IOManager		 	`json:"-"` // This tells json package to ignore the key value
	TaxRate 			float64 					`json:"tax_rate"`
	InputPrices 		[]float64					`json:"input_prices"`
	// Remember [key]value
	TaxIncludedPrices 	map[string]string 			`json:"tax_included_prices"`
}

// Constructor
func NewTaxIncludedPriceJob(iom iomanager.IOManager, taxRate float64) *TaxIncludePriceJob {
	return &TaxIncludePriceJob{
		IOManager: iom,
		InputPrices: []float64{10, 20, 30},
		TaxRate: taxRate,
	}
}

// Here we save everything as price: price with taxes
func(job *TaxIncludePriceJob) Process(doneChan chan bool, errorChan chan error) {
	err := job.LoadData()
	
	if err != nil {
		// return err
		errorChan <- err
		return
	}
	
	result := make(map[string]string)
	for _, price := range job.InputPrices {
		taxIndludedPrice := price * (1 + job.TaxRate)
		result[fmt.Sprintf("%.2f", price)] = fmt.Sprintf("%.2f", taxIndludedPrice)
	}
	
	job.TaxIncludedPrices = result
	job.IOManager.WriteResult(job)
	
	doneChan <- true
	
	// return nil
}

// Loading the data into your job
func (job *TaxIncludePriceJob) LoadData() error {
	lines, err := job.IOManager.ReadLines()
	
	if err != nil {
		return err
	}
	
	prices, err := conversion.StringsToFLoats(lines)
	if err != nil {
		return err
	}

	job.InputPrices = prices
	return nil
}

