package utils

import (
	"errors"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

const secretKey = "supersecretkeytouse"

func GenerateToken(email string, userId int64) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"email": email,
		"userId": userId,
		"exp": time.Now().Add(time.Hour * 2).Unix(), // This is an expiration time
	})
	
	return token.SignedString([]byte(secretKey))
}

func VerifyToken(token string) (int64, error) {
	// Here we are trying to parse the token
	parsedToken, err := jwt.Parse(token, func(token *jwt.Token) (any, error) {
		_, ok := token.Method.(*jwt.SigningMethodHMAC)
		// This makes sure that the token received was really signed with the same method with which they signing in
		if !ok {
			return nil, errors.New("Unexpected signing method")
		}
		return []byte(secretKey), nil
	})
	
	if err != nil {
		return 0, errors.New("Could not parse token")
	}
	
	tokenIsValid := parsedToken.Valid
	if !tokenIsValid {
		return 0, errors.New("Invalid Token")
	}
	
	claims, ok := parsedToken.Claims.(jwt.MapClaims)
	if !ok {
		return 0, errors.New("Invalid Token Claims")
	}
	
	// email := claims["email"].(string)
	userId := int64(claims["userId"].(float64))
	return userId, nil
}