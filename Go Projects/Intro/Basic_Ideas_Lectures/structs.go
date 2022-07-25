package main

import (
	"log"
	"time"
)

// struct is an object and is a type
// using Uppercase for the name makes it available OUTSIDE of the package
// This is because Go is NOT an object oriented program
type User struct {
	FirstName   string
	LastName    string
	PhoneNumber string
	Age         int
	BirthDate   time.Time
}

func (m *User) printFirstName() string {
	return m.FirstName
}

func main3() {
	user := User{
		FirstName:   "Merlin",
		LastName:    "The Cat",
		PhoneNumber: "1 555-555-1212",
	}

	// Since DOB is not initialized then it sets it to beginning of time
	log.Println(user.FirstName, user.LastName, user.BirthDate)
	log.Println("using the function", user.printFirstName())
}
