// name of the folder
package helpers

import (
	"math/rand"
	"time"
)

// Creting this to showcase package use
type SomeType struct {
	TypeName string
	TypeNumber int
}

func RandomNumber(n int) int {
	// Intn needs a different see to be actually random so I add the seed before running things
	rand.Seed(time.Now().UnixNano())
	value := rand.Intn(n)
	return value
}