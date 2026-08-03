# Changelog

## [0.1.9] - 2026-08-03
### Added
- Implemented category-detail navigation screen (`CategoryDetailPage`) in Flutter frontend.
- Added dynamic category cards displaying folder descriptions, file counts, and total sizes.
- Enhanced file transfer feedback dialogs and loading indicators.
### Changed
- Refactored `CatalogPage` to support multi-level browsing from main categories to individual files.
- Updated `ApiService` to fetch and parse category-based content (`CategoryContent`).
- Updated project version to `0.1.8`.

## [0.1.8] - 2026-08-03
### Added
- Implemented `ScanCategories` method in `ContentService` to dynamically read folder structures from local storage.
- Added `CategoryContent` model in Go backend to structure category metadata and items.
### Changed
- Updated `ContentHandler` and API routes (`/api/v1/categories`) to support hierarchical category mapping.
- Refactored `TransferFile` logic to accurately locate and copy files nested inside category subfolders.
- Updated project version to `0.1.8`.

## [0.1.7] - 2026-08-02
### Added
- Modularized Go backend (`adm_backend`) implementing Clean Architecture.
- Created dedicated `models` package for data structures (e.g., `Category`).
- Implemented `handlers` package for business logic and HTTP endpoint controllers.
- Added `routes` package for centralized router and endpoint management using standard `ServeMux`.
### Changed
- Migrated monolithic `main.go` into a clean architecture structure.
- Updated project version to `0.1.7`.

## [0.1.6] - 2026-08-02
### Added
- Initialized Flutter frontend application (`adm_frontend`) for touch screen kiosks.
- Designed interactive Home screen (`KioskHomePage`) with dynamic UI styling.
- Created Catalog screen (`CatalogPage`) to list media and offline service packages.
- Integrated HTTP package to fetch real-time data from the Go backend.
- Added smart icon mapping for media (movies, series, music) and services (maps, flash format, ticketing).
### Changed
- Updated project version to `0.1.6`.

## [v0.1.5] - 2026-07-02
### Documentation
- **UI/UX:** Optimized `custom.css` by reducing code volume by ~30% and improving selector performance.
- **Fix:** Resolved `current_version` undefined error by implementing `versions.html` template.
- **Config:** Refactored `conf.py` to ensure theme stability and consistent rendering.

## [0.1.4] - 2026-06-30
### Added
- **Documentation:** Initialized full Sphinx documentation structure under `docs/`.
- **Roadmap:** Created `REQUIREMENTS.md` to track hardware and software dependencies.
- **Project Structure:** Standardized directory hierarchy across `src/`, `hardware/`, and `docs/`.
### Changed
- **README:** Updated `README.md` to reflect the new hierarchical structure of the repository.
- **Configuration:** Cleaned up `.gitignore` to support multi-language project (Dart, Go, Rust, Python).
### Fixed
- Resolved index mapping issues within Sphinx `toctree` directives.

## [0.1.3] - 2026-06-29
### Added
- Automated GitHub Release workflow for ZIP distribution.
- Structured project repository (Monorepo).
- Sphinx documentation configuration (RTD theme, RTL support).
### Changed
- Finalized ADM directory structure.
- Optimized .gitignore for Python, Go, and system files.
- Updated README.md with project architecture.