package main

import (
	"fmt"

	"example.com/price-calc/filemanager"
	"example.com/price-calc/prices"
)

func main() {
	taxRates := []float64{0, 0.07, 0.1, 0.15}
	// Creating channels one will process the file stuff concurrently, the other listens for errors
	doneChans := make([]chan bool, len(taxRates))
	errorChans := make([]chan error, len(taxRates))
	
	for index, taxRate := range taxRates {
		doneChans[index] = make(chan bool)
		errorChans[index] = make(chan error)
		fm := filemanager.New("prices.txt", fmt.Sprintf("result_%.0f.json", taxRate * 100))
		// cmdm := cmdmanager.New()
		priceJob := prices.NewTaxIncludedPriceJob(fm, taxRate)
		// priceJob := prices.NewTaxIncludedPriceJob(cmdm, taxRate)
		go priceJob.Process(doneChans[index], errorChans[index])
		// err := priceJob.Process()
		// if err != nil {
		// 	fmt.Println("Error running the job")
		// }
	}
	
	// Making a select of channels so that we can either we succeed or get an error
	for index := range taxRates {
		select {
		case err := <-errorChans[index]:
			if (err != nil) {
				fmt.Println(err)
			}
		case <-doneChans[index]:
			fmt.Println("Done!")
		}
	}
}