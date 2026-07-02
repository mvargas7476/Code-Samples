package models

import (
	"time"

	"example.com/event-booking/db"
)

// This is the basic definition for an Event
type Event struct {
	ID int64
	Name string `binding:"required"`
	Description string `binding:"required"`
	Location string `binding:"required"`
	DateTime time.Time `binding:"required"`
	UserID int64
}

// Saving the event
func (e *Event) Save() error {
	// Creating the Query
	insertEventSql := `INSERT INTO events(name, description, location, dateTime, userID)
		VALUES (?, ?, ?, ?, ?)
	`
	
	// Preparing the Query
	insertEvent, err := db.DB.Prepare(insertEventSql)
	// Checking for errors
	if err != nil {
		return err
	}
	// Closing the statement once the query ends
	defer insertEvent.Close()
	
	// Executing the insert
	result, err := insertEvent.Exec(e.Name, e.Description, e.Location, e.DateTime, e.UserID)
	if err != nil {
		return err
	}
	// getting the ID of the last inserted table
	id, err := result.LastInsertId()
	e.ID = id
	return err
}

func GetEventById(id int64) (*Event, error) {
	getEventByIdSql := `SELECT id, name, description, location, dateTime, userID FROM events WHERE id = ?`
	row := db.DB.QueryRow(getEventByIdSql, id)

	var event Event
	err := row.Scan(&event.ID, &event.Name, &event.Description, &event.Location, &event.DateTime, &event.UserID)
	if err != nil {
		return nil, err
	}
	return &event, nil
}

// Returning all events
func GetAllEvents() ([]Event, error) {
	// Creating a query
	getEventsSql := `SELECT id, name, description, location, dateTime, userID FROM events`
	getEvents, err := db.DB.Prepare(getEventsSql)
	
	// Checking for errors
	if err != nil {
		return nil, err
	}
	// Closing the statement once the query ends
	defer getEvents.Close()
	rows, err := getEvents.Query()
	if err != nil {
		return nil, err
	}
	
	var events []Event
	
	for rows.Next() {
		var event Event
		err := rows.Scan(&event.ID, &event.Name, &event.Description, &event.Location, &event.DateTime, &event.UserID)
		if err != nil {
			return nil, err
		}
		events = append(events, event)
	}
	
	return events, nil
}

func (e Event) Update() error {
	updateEventSql := `
		UPDATE events
		SET name = ?, description = ?, location = ?, dateTime = ?
		WHERE id = ?
	`
	updateEvent, err := db.DB.Prepare(updateEventSql)
	
	if err != nil {
		return err
	}
	
	defer updateEvent.Close()
	
	_, err = updateEvent.Exec(e.Name, e.Description, e.Location, e.DateTime, e.ID)
	if err != nil {
		return err
	}
	return nil
}

func (e Event) Delete() error {
	deleteEventSql := "DELETE FROM events WHERE id = ?"
	deleteEvent, err := db.DB.Prepare(deleteEventSql)
	if err != nil {
		return err
	}
	
	defer deleteEvent.Close()
	_, err = deleteEvent.Exec(e.ID)
	return err
}

func (e Event) Register(userId int64) error {
	insertRegistrationSql := "INSERT INTO registrations(eventID, userID) VALUES (?, ?)"
	insertRegistration, err := db.DB.Prepare(insertRegistrationSql)
	if err != nil {
		return err
	}
	
	defer insertRegistration.Close()
	_, err = insertRegistration.Exec(e.ID, userId)
	
	return err	
}

func (e Event) CancelRegistration(userId int64) error {
	deleteSql  := "DELETE FROM registrations WHERE eventID = ? and userID = ?"
	delete, err := db.DB.Prepare(deleteSql)
	if err != nil {
		return err
	}
	
	defer delete.Close()
	_, err = delete.Exec(e.ID, userId)
	
	return err
}