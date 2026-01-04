package routes

import (
	"net/http"
	"strconv"

	"example.com/event-booking/models"
	"github.com/gin-gonic/gin"
)

// Function when GET request is made to events
func getEvents(context *gin.Context) {
	events, err := models.GetAllEvents()
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not fetch events. Try again later"})
		return
	}
	context.JSON(http.StatusOK, events)
}

func getSingleEvent(context *gin.Context) {
	eventID, err := strconv.ParseInt(context.Param("eventID"), 10, 64)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could not parse event id"})
		return
	}
	events, err := models.GetEventById(eventID)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not fetch event. Try again later"})
		return
	}
	context.JSON(http.StatusOK, events)
}

// Doing a POST
func createEvent(context *gin.Context) {
	var event models.Event
	// This works similar to Scan but with HTTP request but should have Event struct shape
	err := context.ShouldBindJSON(&event)
	
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could Not parse request data."})
		return
	}
	
	userId := context.GetInt64("userId")
	event.UserID = userId
	err = event.Save()
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not create event. Try again later"})
		return
	}
	context.JSON(http.StatusCreated, gin.H{"message": "Event created!", "event": event})
}

// Function to update an exiting event
func updateEvent(context *gin.Context) {
	eventID, err := strconv.ParseInt(context.Param("eventID"), 10, 64)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could not parse event id"})
		return
	}
	
	event, err := models.GetEventById(eventID)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not fetch event. Try again later"})
		return
	}
	
	userId := context.GetInt64("userId")
	if event.ID != userId {
		context.JSON(http.StatusUnauthorized, gin.H{"message": "Not Authorized to update event"})
		return
	}
	
	//making sure only the user who created the event can update it
	var updatedEvent models.Event
	err = context.ShouldBindJSON(&updatedEvent)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could Not parse request data."})
		return
	}
	updatedEvent.ID = eventID
	err = updatedEvent.Update()
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could Not Update Event."})
		return
	}
	context.JSON(http.StatusOK, gin.H{"message": "Event updated successfully"})
}

// Deleting single Event
func deleteEvent(context *gin.Context) {
	eventID, err := strconv.ParseInt(context.Param("eventID"), 10, 64)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could not parse event id"})
		return
	}
	
	event, err := models.GetEventById(eventID)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not fetch event. Try again later"})
		return
	}
	
	// Making sure only the user who created the event can delete it
	userId := context.GetInt64("userId")
	if event.ID != userId {
		context.JSON(http.StatusUnauthorized, gin.H{"message": "Not Authorized to delete event"})
		return
	}
	
	err = event.Delete()
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not delete event. Try again later"})
		return
	}
	context.JSON(http.StatusOK, gin.H{"message": "Event deleted successfully"})
}
