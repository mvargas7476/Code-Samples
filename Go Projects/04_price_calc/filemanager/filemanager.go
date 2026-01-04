package filemanager

import (
	"bufio"
	"encoding/json"
	"errors"
	"os"
	"time"
)

type FileManager struct {
	InputFilePath string
	OutputFilePath string
}

// We don't manipulate the struct so we don't make it a pointer
func (fm FileManager) ReadLines() ([]string, error) {
	file, err := os.Open(fm.InputFilePath)
	if err != nil {
		return nil, errors.New("Error while opening the file")
	}
	
	// Here Go will call close once ReadLines is over
	defer file.Close()
	
	// reading the file
	scanner := bufio.NewScanner(file)
	
	var lines []string
	// Scan returns bool
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	
	// Scanner can return an error so if that happened, we check here
	err = scanner.Err()
	if err != nil {
		return nil, errors.New("Error reading the file")
	}
	
	return lines, nil
}

// Writing everything to file
func (fm FileManager) WriteResult(data any) error {
	file, err := os.Create(fm.OutputFilePath)
	if err != nil {
		return errors.New("Error creating the file")
	}
	
	// Here Go will call close once WriteResult is over
	defer file.Close()
	
	time.Sleep(3 * time.Second)
	
	encoder := json.NewEncoder(file)
	err = encoder.Encode(data)
	if err != nil {
		return errors.New("Failed to convert data to JSON")
	}
	
	return nil
}

// Creating a new FileManager Struct
func New(inputPath, outputPath string) FileManager {
	return FileManager{
		InputFilePath: inputPath,
		OutputFilePath: outputPath,
	}
}