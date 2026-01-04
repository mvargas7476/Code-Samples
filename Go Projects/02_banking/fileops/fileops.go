package fileops

import (
	"errors"
	"fmt"
	"os"
	"strconv"
)

// In go, starting the functions with Upper case makes them exportable for other files
func WriteFloatToFile(value float64, fileName string) {
	valueText := fmt.Sprint(value)
	os.WriteFile(fileName, []byte(valueText), 0644) // This asks for file name, the byte size of the balanceText, and file permissions
}

// In go, starting the functions with Upper case makes them exportable for other files
func GetFloatFromFile(fileName string) (float64, error) {
	// ReadFile returns two values the bytes and the error. the "_" tells go that we are not doing anything with the error in this case
	data, err := os.ReadFile(fileName)
	if err != nil {
		return 1000, errors.New("Failed to find file")
	}
	valueText := string(data)
	value, err := strconv.ParseFloat(valueText, 64) // The ParseFloat wants a 32 or 64 to know which float you are converting the string from 
	if err != nil {
		return 1000, errors.New("Failed to parse stored value")
	}
	return value, nil
}