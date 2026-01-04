package main

import (
	"fmt"

	"example.com/banking/fileops"
)

const accountBalanceFile = "balance.txt"

func main() {
	accountBalance, err := fileops.GetFloatFromFile(accountBalanceFile)
	if(err != nil) {
		fmt.Println("ERROR")
		fmt.Println(err)
		fmt.Println("-------------------")
		// This ends execution similar to the exit() in on some other issues
		panic(err)
	}
	fmt.Println("Welcome to my CLI Bank")
	fmt.Printf("Your current balance is: %.2f\n\n", accountBalance)
	
	for {
		presentOptions()
		
		var choice int
		fmt.Print("Your Choice: ")
		fmt.Scan(&choice)
		
		switch choice {
		case 1:
			fmt.Printf("Checking Balance: %.2f\n\n", accountBalance)
			continue
		case 2:
			fmt.Print("Your deposit: ")
			var depositAmount float64
			fmt.Scan(&depositAmount)
			if(depositAmount < 0) {
				fmt.Println("You have to deposit a number greater than 0")
				continue
			}
			accountBalance += depositAmount
			fileops.WriteFloatToFile(accountBalance, accountBalanceFile)
		case 3:
			fmt.Print("Your withdrawal: ")
			var withdrawalAmount float64
			fmt.Scan(&withdrawalAmount)
			if(withdrawalAmount < 0) {
				fmt.Println("You have to withdraw a number greater than 0")
				continue
			}
			if(withdrawalAmount > accountBalance) {
				fmt.Println("You cannot withdraw more money than what is available in your account")
				continue
			}
			accountBalance -= withdrawalAmount
			fileops.WriteFloatToFile(accountBalance, accountBalanceFile)
		default:
			fmt.Println("Thanks for using our bank, Goodbye!")
			return
		}
		// Always display the balance
		fmt.Printf("Balance updated. New Balance: %.2f\n\n", accountBalance)
	}
}