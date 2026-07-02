package routes

import (
	"net/http"
	"strconv"

	"example.com/event-booking/models"
	"github.com/gin-gonic/gin"
)

func registerForEvent(context *gin.Context) {
	userId := context.GetInt64("userId")
	eventID, err := strconv.ParseInt(context.Param("eventID"), 10, 64)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could not parse event id"})
		return
	}
	
	event, err := models.GetEventById(eventID)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not fetch event"})
		return
	}
	
	err = event.Register(userId)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not register for the event"})
		return
	}
	context.JSON(http.StatusCreated, gin.H{"message": "Registered"})
}


func cancelRegistration(context *gin.Context) {
	userId := context.GetInt64("userId")
	eventID, err := strconv.ParseInt(context.Param("eventID"), 10, 64)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could not parse event id"})
		return
	}
	
	var event models.Event
	event.ID = eventID
	err = event.CancelRegistration(userId)
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to cancel registration"})
		return
	}
	context.JSON(http.StatusOK, gin.H{"message": "Cancelled"})
}