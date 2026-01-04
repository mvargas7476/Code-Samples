package main

import (
	"example.com/event-booking/db"
	"example.com/event-booking/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	db.InitDB()
	server := gin.Default()
	
	routes.RegisterRoutest(server)
	
	server.Run(":8080") // This is the port we will be running on.
}

