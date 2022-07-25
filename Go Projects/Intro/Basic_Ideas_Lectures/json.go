package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type Person struct {
	FirstName string `json:"first_name`
	LastName string `json:"last_name`
	HasSideKick bool `json:"has_side_kick"`
}

func main() {
	myJson := `
	[
		{
			"first_name": "Clark",
			"first_name": "Kent",
			"has_side_kick": false
		},
		{	
			"first_name": "Bruce",
			"first_name": "Wayne"
			"has_side_kick": true
		}
	]`
	
	// making a slice (array) or Person to get the person out
	var unmarshalled []Person

	err := json.Unmarshal([]byte(myJson), &unmarshalled)
	if err != nil {
		log.Println("Error unmarshalling json", err)
	}

	// This prints the JSON as a struct since I made it this way
	log.Printf("unmarshalled: %v", unmarshalled)

	// write json from struct
	var mySlice []Person
	// Creating two structs
	var m1 Person
	m1.FirstName = "Wally"
	m1.LastName = "West"
	m1.HasSideKick = true
	
	var m2 Person
	m2.FirstName = "Richard"
	m2.LastName = "Grayson"
	m2.HasSideKick = false
	
	// Adding the structs to the slice
	mySlice = append(mySlice, m1)
	mySlice = append(mySlice, m2)

	// Marshallindent is just for dev. You would not do this in productions
	// Writing newJson from the structs. Checking for errors just in case
	newJson, err := json.MarshalIndent(mySlice, "", "    ")
	if err != nil {
		log.Println("error marshalling", err)
	}

	// Printing the newly created json object
	fmt.Println(string(newJson))
}