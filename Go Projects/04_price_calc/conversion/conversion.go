package conversion

import (
	"errors"
	"strconv"
)

func StringsToFLoats(strings []string) ([]float64, error) {
	var floats []float64
	// Changing the read lines from the file to floats
	for _, stringVal := range strings {
		floatVal, err := strconv.ParseFloat(stringVal, 64)
		
		if err != nil {
			return nil, errors.New("Failed to conver string to float")
		}
		
		floats = append(floats, floatVal)
	}
	
	return floats, nil
}