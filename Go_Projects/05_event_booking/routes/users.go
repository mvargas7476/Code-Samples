package routes

import (
	"net/http"

	"example.com/event-booking/models"
	"example.com/event-booking/utils"
	"github.com/gin-gonic/gin"
)

func signup(context *gin.Context) {
	var user models.User
	// This works similar to Scan but with HTTP request but should have Event struct shape
	err := context.ShouldBindJSON(&user)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could Not parse request data."})
		return
	}
	
	err = user.Save()
	if err != nil {
		context.JSON(http.StatusInternalServerError, gin.H{"message": "Could not save user"})
		return
	}
	context.JSON(http.StatusCreated, gin.H{"message": "User created!", "user": user})
}

func login(context *gin.Context) {
	var user models.User
	
	err := context.ShouldBindJSON(&user)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could Not parse request data."})
		return
	}
	
	err = user.ValidateCredentials()
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could Not authenticate user."})
		return
	}
	
	token, err := utils.GenerateToken(user.Email, user.ID)
	if err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"message": "Could Not authenticate user."})
		return
	}
	
	context.JSON(http.StatusOK, gin.H{"message": "User successfully logged in.", "token": token})
}