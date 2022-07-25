/**
 * @prettier
 */
package render

import (
	"bytes"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"path/filepath"

	"github.com/mvargas7476/go-course/pkg/config"
	"github.com/mvargas7476/go-course/pkg/models"
)

// this is a map of functions that I can use in a template
var functions = template.FuncMap{}

var app *config.AppConfig

// sets the config for the new template
func NewTemplate(a *config.AppConfig) {
	app = a
}

func AddDefaultData(templateData *models.TemplateData) *models.TemplateData{
	return templateData
}

// Using html/templates to render out pages from the templates
func RenderTemplate(w http.ResponseWriter, tmpl string, templateData *models.TemplateData) {
	var templateCache map[string]*template.Template
	if app.UsedCache {
		templateCache = app.TemplateCache
	} else {
		templateCache, _ = CreateTemplateCache()
	}

	template, ok := templateCache[tmpl]
	// ok is checking if someone is using a template that doesnt exist
	if !ok {
		log.Fatal("Could not get the template from template cache")
	}

	buf := new(bytes.Buffer)

	templateData = AddDefaultData(templateData)

	// we are storing the buf variable into the template
	_ = template.Execute(buf, templateData)

	_, err := buf.WriteTo(w)
	if err != nil {
		fmt.Println("Error writing template to browser:", err)
	}
}

func CreateTemplateCache() (map[string]*template.Template, error) {
	// Having a mapper for a string to and a pointer to the template file
	myCache := map[string]*template.Template{}

	// Getting all the pages that are in the path and are of type .page.html
	pages, err := filepath.Glob("./templates/*.page.html")
	if err != nil {
		return myCache, err
	}

	// Looping through the pages and collecting the base name
	for _, page := range pages {
		name := filepath.Base(page)
		templateSet, err := template.New(name).Funcs(functions).ParseFiles(page)
		if err != nil {
			return myCache, err
		}

		// Loof for any layout type file
		matches, err := filepath.Glob("./templates/*.layout.html")
		if err != nil {
			return myCache, err
		}

		if len(matches) > 0 {
			templateSet, err = templateSet.ParseGlob("./templates/*.layout.html")
			if err != nil {
				return myCache, err
			}
		}

		// Add tthings to cache ass "About" => about.layout.html
		myCache[name] = templateSet
	}

	return myCache, nil
}
