package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"example.com/note/note"
)


func main() {
	// Getting the user input
	title, content := getNoteData()
	// Creating the User Note
	userNote, err := note.New(title, content)
	
	if (err != nil) {
		fmt.Println("Title and content are required")
		return
	}
	
	// Displaying the note
	userNote.Display()
	err = userNote.Save()
	
	if (err != nil) {
		fmt.Println("Saving the note failed")
		return
	}
	
	fmt.Println("Saving the note succeeded")
}

func getNoteData() (string, string) {
	title := getUserInput("Note title: ")
	content := getUserInput("Note content: ")
	
	return title, content	
}

func getUserInput(prompt string) (string) {
	fmt.Print(prompt)
	
	// Creating a reader to read the CLI text inputed since notes can have spaces
	reader := bufio.NewReader(os.Stdin)
	// Telling reader which character (single quotes) will stop us from reading stdin
	text, err := reader.ReadString('\n')
	
	if (err != nil) {
		return ""
	}
	
	// We remove the extra encodings at the end of a string. Specifically the \n and \r\n line breaks 
	text = strings.TrimSuffix(text, "\n")
	text = strings.TrimSuffix(text, "\r")
	
	return text
}