/*
the name of the test file is {name}_test.go
run tests using `go test` for a single test and `go test -v` for all
*/
package main

import (
	"testing"
)

// Creating a struct of tests
var tests = []struct {
	name string
	dividend float32
	divisor float32
	expect float32
	isErr bool
}{
	{"valid-data", 100.0, 10.0, 10.0, false},
	{"valid-data", 100.0, 0.0, 0.0, true},
}

// Creating a function that will loop through the struct and report what it gets
func TestDivision(t *testing.T) {
	for _, tt := range tests {
		got, err := divide(tt.dividend, tt.divisor)
		if (tt.isErr) {
			if err == nil {
				t.Error("Expected an error but did not get one")
			}
		} else {
			if err != nil {
				t.Error("Did not expect and error but got one", err.Error())
			}
		}

		if got != tt.expect {
			t.Errorf("expected %f but got %f", tt.expect, got)
		}
	}
}

/*
func TestDivide(t *testing.T) {
	_, err := divide(10.0, 1.0)
	if err != nil {
		t.Error("Got an error when we should not have")
	}
}

func TestBadDivide(t *testing.T) {
_, err := divide(10.0, 0)
	if err == nil {
		t.Error("Did not get an error when we should have")
	}
}
*/