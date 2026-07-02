package db

import (
	"database/sql"

	_ "github.com/mattn/go-sqlite3"
)

var DB *sql.DB // This is a pointer to sql.DB which is a scrutct from the sql package
 
func InitDB() {
    var err error
    DB, err = sql.Open("sqlite3", "api.db") // This is getting the Driver and the path that leads to a DB. a localfile
 
    if err != nil {
		// In the Gin this doesn't crash the server but it gives you a very obvious crash
        panic("Could not connect to database.")
    }
 
    DB.SetMaxOpenConns(10)
    DB.SetMaxIdleConns(5)
 
    createTables()
}

func createTables() {
	createUsersTable := `CREATE TABLE IF NOT EXISTS users (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		email TEXT NOT NULL UNIQUE,
		password TEXT NOT NULL
	)`
	
	_, err := DB.Exec(createUsersTable)
	if err != nil {
		panic("Could not create events table")
	}
	
	createEventsTable := `CREATE TABLE IF NOT EXISTS events (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		description TEXT NOT NULL,
		location TEXT NOT NULL,
		dateTime DATETIME NOT NULL,
		userID INTEGER, 
		FOREIGN KEY(userID) references users(id)
	)`
	
	_, err = DB.Exec(createEventsTable)
	if err != nil {
		panic("Could not create events table")
	}
	
	createRegistrationsTable := `CREATE TABLE IF NOT EXISTS registrations (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		eventID INTEGER NOT NULL,
		userID INTEGER NOT NULL,
		FOREIGN KEY(userID) REFERENCES users(id),
		FOREIGN KEY(eventID) REFERENCES events(id)
	)`
	
	_, err = DB.Exec(createRegistrationsTable)
	if err != nil {
		panic("Could not create Registrations table")
	}
}