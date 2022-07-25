/**
 * @prettier
 */
package handlers

import (
	"net/http"

	"github.com/mvargas7476/go-course/pkg/config"
	"github.com/mvargas7476/go-course/pkg/models"
	"github.com/mvargas7476/go-course/pkg/render"
)

// The repository used by the handlers
var Repo *Repository

// Teh repository type
type Repository struct {
	App *config.AppConfig
}

// creates a new repository
func NewRepo(a *config.AppConfig) *Repository {
	return &Repository {
		App: a,
	}
}

// Sets the repository for the handlers
func NewHandlers(r *Repository){
	Repo = r
}

// This will handle requests! always two parameters. Called Handlers
// Home is the home page handler
func (m *Repository) Home(w http.ResponseWriter, r *http.Request) {
	render.RenderTemplate(w, "home.page.html", &models.TemplateData{})
}

// About is the about page handler
func (m *Repository) About(w http.ResponseWriter, r *http.Request) {
	stringMap := make(map[string]string)
	stringMap["test"] = "Hello There"

	render.RenderTemplate(w, "about.page.html", &models.TemplateData{
		StringMap: stringMap,
	})
}
