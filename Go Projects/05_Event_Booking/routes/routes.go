package routes

import (
	"example.com/event-booking/middlewares"
	"github.com/gin-gonic/gin"
)

func RegisterRoutest(server *gin.Engine) {
	// Events
	server.GET("/events", getEvents) 
	server.GET("/events/:eventID", getSingleEvent) // handles everything for evetns/1 to events/2
	
	// Here we make a group of requests that will ALWAYS run the authenticated before doing what they need to do
	authenticated := server.Group("/")
	authenticated.Use(middlewares.Authenticate)
	authenticated.POST("/events", createEvent) 
	authenticated.PUT("/events/:eventID", updateEvent) 
	authenticated.DELETE("/events/:eventID", deleteEvent) 
	authenticated.POST("/events/:eventID/register", registerForEvent) 
	authenticated.DELETE("/events/:eventID/register", cancelRegistration) 
	
	// Users
	server.POST("/signup", signup) 
	server.POST("/login", login) 
}