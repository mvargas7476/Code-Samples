package main

import (
	"net/http"

	"github.com/justinas/nosurf"
)

// Adds CSRF protection
func NoSurf(next http.Handler) http.Handler {
	csrfHandler := nosurf.New(next)

	csrfHandler.SetBaseCookie(http.Cookie{
		HttpOnly: true,
		Secure: app.InProduction,
		Path: "/",
		SameSite: http.SameSiteLaxMode,

	})

	return csrfHandler
}

// Saves information and loads it in a cookie
func SessionLoad(next http.Handler) http.Handler {
	return session.LoadAndSave(next)
}
