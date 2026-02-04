package note

import (
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"strings"
	"time"
)

// All the fields are now public because fo the Marshal function in Save
// The struct also has tags which can be considered by different packages, in this case json
type Note struct {
	Title string `json:"title"`
	Content string `json:"content"`
	CreatedAt time.Time `json:"created_at"`
}

func New(title, content string) (Note, error) {
	if(title == "" || content == "") {
		return Note{}, errors.New("Invalid Input")
	}
	
	return Note{
		Title: title,
		Content: content,
		CreatedAt: time.Now(),
	}, nil
}

// Methods to do things with the note. We don't need pointers since they don't modify the note
func (note Note) Display() {
	fmt.Printf("Your note titled %v has the following content:\n\n%v\n\n", note.Title, note.Content)
}

func (note Note) Save() (error) {
	// getting a pretty name for the file by making it lower case and removing spaces
	fileName := strings.ReplaceAll(note.Title, " ", "_")
	fileName = strings.ToLower(fileName) + ".json"
	
	// Setting the note to json
	json, err := json.Marshal(note)
	if (err != nil) {
		return err
	}
	
	return os.WriteFile(fileName, json, 0644)
}