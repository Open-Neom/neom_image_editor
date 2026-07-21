# Changelog

## [2.0.0-unreleased] - 2026-07-21
- Refactor and compatibility updates for pro_image_editor_page.dart, pubspec.yaml.

All notable changes to neom_image_editor will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2025-02-08

### Changed
- **Improved UX**: Hidden bottom controls (Scale/Rotate) in cropper for cleaner interface on modern devices
- **Updated README**: Complete rewrite with ambitious ROADMAP 2026 for professional-grade image editing
- Updated `flutter_lints` to ^6.0.0

### Documentation
- Added comprehensive ROADMAP 2026 with quarterly milestones
- Added competitive analysis vs Snapseed, Canva, Lightroom Mobile
- Added technical architecture goals
- Added performance targets

### ROADMAP 2026 Highlights
- Q1: Basic adjustments (brightness, contrast, shadows, highlights)
- Q2: Filters & effects engine (50+ filters, blur effects, light leaks)
- Q3: Creative tools (text, stickers, drawing, layers)
- Q4: AI-powered features (auto-enhance, background removal, upscaling)

## [1.1.2] - Previous Release

### Fixed
- Minor bug fixes and improvements

## [1.1.0] - Previous Release

### Added
- Platform-specific UI customization
- Improved aspect ratio presets

## [1.0.0] - Initial Release

### Added

#### Module Decoupling
- Standalone module extracted from neom_posts and neom_media_upload
- Self-contained image editing logic

#### Core Features
- **Image Cropping**: Precise aspect ratio control
  - Square (1:1)
  - Ratio 3x2
  - Ratio 4x3
  - Ratio 16x9
  - Original aspect ratio
- **Platform-Optimized UI**: Native-like cropping experience
- **Integration with Media Pipeline**: Seamless image processing workflow

#### Technical
- Implements `ImageEditorService` interface
- Uses `image_cropper` for native cropping
- Built on `neom_core` and `neom_commons`
