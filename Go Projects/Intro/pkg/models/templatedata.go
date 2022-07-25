package models

// Holds data sent from handlers to templates
type TemplateData struct {
	StringMap map[string]string
	IntMap map[string]int
	FloatMap map[string]float32
	// interface requires {} after but they are a type of "anything"
	Data map[string]interface{}
	// Cross Site Request Forgery Token = CSRF Token
	CSRFToken string
	Flash string
	Warning string
	Error string
}