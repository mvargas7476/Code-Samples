package main

import (
	"errors"
	"fmt"
	"os"
)

func main() {
	// Collecting user input
	revenue, err1 := getUserInput("Revenue: ")
	expenses, err2 := getUserInput("Expenses: ")
	taxRate, err3 := getUserInput("Tax Rate: ")
	
	if err1 != nil || err2 != nil ||err3 != nil {
		fmt.Println("A negative value was added in the Revenue, Expenses, or Tax Rate")
	}

	// Doing calculations to get ebt, profit, and ratio
    ebt, profit, ratio := calculateFinancialInfo(revenue, expenses, taxRate)
    
	// Outputting values into the terminal in different ways
	// Notice that the 2f formats the variable to 2 decimal places. %v would be used for the regular value
	fmt.Printf("Earning Before Taxes(EBT): %.2f\n", ebt)
	fmt.Printf("Profit: %.2f\n", profit)
	fmt.Printf("Ratio: %.3f\n", ratio)
	storeResults(ebt, profit, ratio)
}

// In go we always define which type of data type we will return
func getUserInput(infoText string) (float64, error) {
    var userInput float64
    fmt.Print(infoText)
	fmt.Scan(&userInput)
	if (userInput <= 0) {
		return 0, errors.New("Value must be positive")
	}
    return userInput, nil
}

func calculateFinancialInfo(revenue, expenses, taxRate float64) (float64, float64, float64) {
    ebt := revenue - expenses
	profit := ebt * (1 - taxRate / 100)
	ratio := ebt / profit
    
    return ebt, profit, ratio  
}

func storeResults(ebt, profit, ratio float64) {
	results := fmt.Sprintf("EBT: %.2f\nProfit: %.2f\nRatio: %.3f", ebt, profit, ratio)
	os.WriteFile("results.txt", []byte(results), 0644)
}