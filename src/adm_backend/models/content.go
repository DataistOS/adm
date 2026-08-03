package models

type ContentItem struct {
	ID            string `json:"id"`
	Name          string `json:"name"`
	Size          int64  `json:"size"`
	FormattedSize string `json:"formatted_size"`
	Extension     string `json:"extension"`
}

type CategoryContent struct {
	ID            string        `json:"id"`
	Title         string        `json:"title"`
	Desc          string        `json:"desc"`
	FormattedSize string        `json:"formatted_size"`
	Items         []ContentItem `json:"items"`
}