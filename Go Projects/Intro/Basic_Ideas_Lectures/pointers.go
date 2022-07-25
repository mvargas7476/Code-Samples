package main

import "log"

func main2() {
	var myString string
	myString = "Green"

	log.Println("myString is set to", myString)
	// We need the & because we are changing the pointer so for reference
	changeUsingPointers(&myString)
	log.Println("after func callmyString is set to", myString)
}

// This works with a pointer
func changeUsingPointers(s *string) {
	newValue := "Red"
	// Go to memory address in s and change that to red
	*s = newValue
}
