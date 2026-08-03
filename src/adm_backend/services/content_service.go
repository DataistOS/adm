package services

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/DataistOS/adm/src/adm_backend/models"
)

type ContentService struct {
	StoragePath string
}

func NewContentService(storagePath string) *ContentService {
	_ = os.MkdirAll(storagePath, 0755)
	return &ContentService{StoragePath: storagePath}
}

func (s *ContentService) ScanFiles() ([]models.ContentItem, error) {
	var items []models.ContentItem

	files, err := os.ReadDir(s.StoragePath)
	if err != nil {
		return nil, err
	}

	for i, file := range files {
		if file.IsDir() {
			continue
		}

		info, err := file.Info()
		if err != nil {
			continue
		}

		size := info.Size()
		ext := filepath.Ext(file.Name())

		items = append(items, models.ContentItem{
			ID:            fmt.Sprintf("file_%d", i+1),
			Name:          file.Name(),
			Size:          size,
			FormattedSize: formatBytes(size),
			Extension:     strings.TrimPrefix(ext, "."),
		})
	}

	return items, nil
}

func (s *ContentService) ScanCategories() ([]models.CategoryContent, error) {
	var categories []models.CategoryContent

	entries, err := os.ReadDir(s.StoragePath)
	if err != nil {
		return nil, err
	}

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		catName := entry.Name()
		catPath := filepath.Join(s.StoragePath, catName)

		subFiles, err := os.ReadDir(catPath)
		if err != nil {
			continue
		}

		var items []models.ContentItem
		var totalSize int64

		for i, file := range subFiles {
			if file.IsDir() {
				continue
			}

			info, err := file.Info()
			if err != nil {
				continue
			}

			size := info.Size()
			totalSize += size
			ext := filepath.Ext(file.Name())

			items = append(items, models.ContentItem{
				ID:            fmt.Sprintf("%s_file_%d", catName, i+1),
				Name:          file.Name(),
				Size:          size,
				FormattedSize: formatBytes(size),
				Extension:     strings.TrimPrefix(ext, "."),
			})
		}

		categories = append(categories, models.CategoryContent{
			ID:            catName,
			Title:         translateCategoryTitle(catName),
			Desc:          getCategoryDesc(catName),
			FormattedSize: formatBytes(totalSize),
			Items:         items,
		})
	}

	return categories, nil
}

func formatBytes(bytes int64) string {
	const unit = 1024
	if bytes < unit {
		return fmt.Sprintf("%d B", bytes)
	}
	div, exp := int64(unit), 0
	for n := bytes / unit; n >= unit; n /= unit {
		div *= unit
		exp++
	}
	return fmt.Sprintf("%.1f %ciB", float64(bytes)/float64(div), "KMGTPE"[exp])
}

func (s *ContentService) TransferFile(fileID string, targetPath string) error {
	categories, err := s.ScanCategories()
	if err != nil {
		return err
	}

	var targetFile *models.ContentItem
	var foundCatName string

	for _, cat := range categories {
		for _, item := range cat.Items {
			if item.ID == fileID {
				targetFile = &item
				foundCatName = cat.ID
				break
			}
		}
		if targetFile != nil {
			break
		}
	}

	if targetFile == nil {
		return fmt.Errorf("file with ID %s not found", fileID)
	}

	if err := os.MkdirAll(targetPath, 0755); err != nil {
		return fmt.Errorf("failed to create target directory: %v", err)
	}

	srcPath := filepath.Join(s.StoragePath, foundCatName, targetFile.Name)
	dstPath := filepath.Join(targetPath, targetFile.Name)

	input, err := os.ReadFile(srcPath)
	if err != nil {
		return fmt.Errorf("failed to read source file: %v", err)
	}

	err = os.WriteFile(dstPath, input, 0644)
	if err != nil {
		return fmt.Errorf("failed to write target file: %v", err)
	}

	return nil
}

func translateCategoryTitle(name string) string {
	switch name {
	case "movies":
		return "فیلم‌های سینمایی"
	case "series":
		return "سریال‌های محبوب"
	case "music":
		return "موسیقی و پادکست"
	case "education":
		return "محتوای آموزشی و مستند"
	case "offline_maps":
		return "نقشه و راهنمای آفلاین"
	default:
		return name
	}
}

func getCategoryDesc(name string) string {
	switch name {
	case "movies":
		return "گلچین جدیدترین فیلم‌های سینمایی روز دنیا و ایران"
	case "series":
		return "مجموعه‌های کامل سریال‌های پرمخاطب"
	case "music":
		return "گلچین آهنگ‌های مجاز، آلبوم‌ها و پادکست‌های صوتی"
	case "education":
		return "دوره‌های مهارتی، مستندهای علمی و حیات‌وحش"
	case "offline_maps":
		return "نقشه‌های دقیق شهری و مسیرهای گردشگری"
	default:
		return "مجموعه فایل‌های دسته‌بندی شده"
	}
}
