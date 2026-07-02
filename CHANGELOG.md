# Changelog

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
