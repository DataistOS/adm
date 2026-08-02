package main

import (
	"net/http"

	"github.com/DataistOS/adm/src/adm_backend/routes"
)

func main() {
	mux := routes.SetupRouter()

	println("ADM Backend (Clean Architecture) is running on port 9090...")
	http.ListenAndServe(":9090", mux)
}