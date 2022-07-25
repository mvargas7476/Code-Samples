// This name is whatever you want. main is convention
package main

// fmt = format
import "fmt"

// Must have main func
func main1() {
	fmt.Println("Hello, World!")

	// Variables are strict so in go you pass type to the variable
	var whatToSay string
	var i int

	whatToSay = "Goodbye, cruel world"
	fmt.Println(whatToSay)

	i = 2
	fmt.Println("i is set to", i)

	// := stores the return into what was said and sets the type to the return value
	whatwasSaid, theOtherThing := saySomething()
	fmt.Println("The function returned", whatwasSaid, theOtherThing)
}

// function structure: func name return
func saySomething() (string, string) {
	return "something", "useful"
}
