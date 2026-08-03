package routes

import (
    "net/http"

    "github.com/DataistOS/adm/src/adm_backend/handlers"
    "github.com/DataistOS/adm/src/adm_backend/services"
)

func SetupRouter(contentService *services.ContentService) *http.ServeMux {
    mux := http.NewServeMux()

    contentHandler := handlers.NewContentHandler(contentService)

    mux.HandleFunc("/health", handlers.HealthCheck)
    mux.HandleFunc("/api/categories", handlers.GetCategories)
    mux.HandleFunc("/api/v1/categories", contentHandler.GetRealCategories)
    mux.HandleFunc("/api/v1/transfer", contentHandler.TransferContent)

    return mux
}