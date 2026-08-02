package routes

import (
	"net/http"

	"github.com/DataistOS/adm/src/adm_backend/handlers"
)

func SetupRouter() *http.ServeMux {
	mux := http.NewServeMux()

	mux.HandleFunc("/health", handlers.HealthCheck)
	mux.HandleFunc("/api/categories", handlers.GetCategories)

	return mux
}