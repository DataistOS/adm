package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/DataistOS/adm/src/adm_backend/models"
	"github.com/DataistOS/adm/src/adm_backend/services"
)

type ContentHandler struct {
	Service *services.ContentService
}

func NewContentHandler(service *services.ContentService) *ContentHandler {
	return &ContentHandler{Service: service}
}

func HealthCheck(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(`{"status": "online", "system": "ADM Backend (Go - Clean Architecture)"}`))
}

func GetCategories(w http.ResponseWriter, r *http.Request) {
	categories := []models.Category{
       {Title: "فیلم‌های سینمایی", Desc: "گلچین جدیدترین فیلم‌های سینمایی روز دنیا و ایران", Size: "15.4 گیگابایت"},
       {Title: "سریال‌های محبوب", Desc: "مجموعه‌های کامل سریال‌های پرمخاطب", Size: "32.0 گیگابایت"},
       {Title: "موسیقی و پادکست", Desc: "گلچین آهنگ‌های مجاز، آلبوم‌ها و پادکست‌های صوتی", Size: "4.5 گیگابایت"},
       {Title: "محتوای آموزشی و مستند", Desc: "دوره‌های مهارتی، مستندهای علمی و حیات‌وحش", Size: "8.2 گیگابایت"},
       {Title: "نقشه و راهنمای آفلاین", Desc: "نقشه‌های دقیق شهری و مسیرهای گردشگری", Size: "850 مگابایت"},
       {Title: "ابزار فرمت و آماده‌سازی فلش", Desc: "بررسی فضای خالی و بهینه‌سازی حافظه جانبی", Size: "15 مگابایت"},
       {Title: "نوبت‌دهی و ثبت درخواست", Desc: "ثبت درخواست خدمات و دریافت نوبت حضوری", Size: "2 مگابایت"},
    }

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(categories)
}

func (h *ContentHandler) GetRealCategories(w http.ResponseWriter, r *http.Request) {
	categories, err := h.Service.ScanCategories()
	if err != nil {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": "Failed to scan categories directory"})
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"status": "success",
		"data":   categories,
	})
}

type TransferRequest struct {
	FileID     string `json:"file_id"`
	TargetPath string `json:"target_path"`
}

func (h *ContentHandler) TransferContent(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		w.WriteHeader(http.StatusMethodNotAllowed)
		json.NewEncoder(w).Encode(map[string]string{"error": "Method not allowed"})
		return
	}

	var req TransferRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": "Invalid request body"})
		return
	}

	if req.FileID == "" || req.TargetPath == "" {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode(map[string]string{"error": "file_id and target_path are required"})
		return
	}

	err := h.Service.TransferFile(req.FileID, req.TargetPath)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Error()})
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"status":      "success",
		"message":     "File transferred successfully to external storage",
		"file_id":     req.FileID,
		"target_path": req.TargetPath,
	})
}