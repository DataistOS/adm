package main

import (
    "net/http"
    "os"

    "github.com/DataistOS/adm/src/adm_backend/routes"
    "github.com/DataistOS/adm/src/adm_backend/services"
)

func main() {
    storagePath := "./data/content"
    _ = os.MkdirAll(storagePath, 0755)

    contentService := services.NewContentService(storagePath)
    mux := routes.SetupRouter(contentService)

    println("ADM Backend (Clean Architecture) is running on port 9090...")
    println("Storage path initialized at:", storagePath)

    if err := http.ListenAndServe(":9090", mux); err != nil {
        println("Server failed to start:", err.Error())
    }
}