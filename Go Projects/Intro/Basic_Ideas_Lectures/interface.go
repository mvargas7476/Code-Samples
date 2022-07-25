package main

import "fmt"

// Anything that will implement this interface will need to use both of these functions
type Animal interface {
	Says() string
	NumberOfLegs() int
}

type Dog struct {
	Name string
	Breed string
}

type Gorilla struct {
	Name string
	Color string
	NumberOfTeeth int
}

func main4() {
	dog := Dog {
		Name: "Samson",
		Breed: "German Shepherd",
	}

	gorilla := Gorilla {
		Name: "Gori",
		Color: "Black",
		NumberOfTeeth: 16,
	}

	PrintInfo(&dog)
	PrintInfo(&gorilla)
}

func PrintInfo(a Animal) {
	fmt.Println("This animal says", a.Says(), "and has", a.NumberOfLegs(), "legs")
}

// setting up the variables for dog and gorilla to use the interface
func (d *Dog) Says() string {
	return "woof"
}

func (d *Dog) NumberOfLegs() int {
	return 4
}

func (d *Gorilla) Says() string {
	return "ugh"
}

func (d *Gorilla) NumberOfLegs() int {
	return 2
}