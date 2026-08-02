package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/DataistOS/adm/src/adm_backend/models"
)

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
