package main

import (
	"log"

	"github.com/mvargas/myniceprogram/helpers"
)

func CalcValue (intChan chan int) {
	randomNumber := helpers.RandomNumber(1000)
	// push the number back into the changel of integers
	intChan <- randomNumber
}

func main() {
	// Pulling this from the helpers package
	var myVar helpers.SomeType
	myVar.TypeName = "SomeName"
	log.Println(myVar.TypeName)

	// making a channel of integers
	intChan := make(chan int)
	// closing the channel when it is done running
	defer close(intChan)

	// This is part of things being concurrent
	// Making a go routine
	go CalcValue(intChan)

	// get the value and type from the intChan and store it in num
	num := <- intChan
	log.Println(num)
}