package middlewares

import (
	"net/http"

	"example.com/event-booking/utils"
	"github.com/gin-gonic/gin"
)

func Authenticate(context *gin.Context) {
	token := context.Request.Header.Get("Authorization")
	if token == "" {
		// Cancels the current request
		context.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "Not authorized"})
		return
	}
	
	userId, err := utils.VerifyToken(token)
	if err != nil {
		// Cancels the current request
		context.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"message": "Not authorized"})
		return
	}
	
	context.Set("userId", userId)
	// Let's the request continue
	context.Next()
}