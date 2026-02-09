# neom_image_editor

A professional-grade image editing module for Flutter applications, part of the Open Neom ecosystem. Designed to compete with industry-leading image editors like Canva, Snapseed, and Adobe Lightroom Mobile.

## Current Version: 1.2.0

## Features

### Current Capabilities (v1.2.0)
- **Image Cropping**: Precise aspect ratio control (square, 3x2, 4x3, 16x9, original)
- **Platform-Optimized UI**: Native-like experience on Android and iOS
- **Improved UX**: Hidden bottom controls for cleaner interface on modern devices
- **Integration Ready**: Seamless integration with media pipelines

## Installation

```yaml
dependencies:
  neom_image_editor:
    git:
      url: git@github.com:Open-Neom/neom_image_editor.git
```

## Usage

```dart
import 'package:neom_image_editor/neom_image_editor.dart';

// Crop an image
final imageEditorService = ImageEditorController();
final croppedFile = await imageEditorService.cropImage(sourceFile);
```

---

## ROADMAP 2026: Professional Image Editor

Our vision is to transform neom_image_editor into a **world-class image editing solution** capable of competing with any professional mobile image editor.

### Q1 2026: Foundation Enhancement

#### Basic Adjustments
- [ ] **Brightness & Exposure** - Full range control with real-time preview
- [ ] **Contrast & Saturation** - HSL color space manipulation
- [ ] **Shadows & Highlights** - Advanced tone mapping
- [ ] **Temperature & Tint** - White balance correction
- [ ] **Sharpness & Clarity** - Edge enhancement algorithms
- [ ] **Vignette** - Customizable corner darkening

#### Crop & Transform Enhancements
- [ ] **Free-form Crop** - Custom aspect ratios
- [ ] **Rotation** - Precise angle adjustment with grid overlay
- [ ] **Perspective Correction** - Keystone adjustment
- [ ] **Flip & Mirror** - Horizontal/vertical transformations

### Q2 2026: Filters & Effects Engine

#### Professional Filter System
- [ ] **Filter Categories**: Portrait, Landscape, Urban, Vintage, Cinematic, B&W
- [ ] **50+ Preset Filters** - Professionally designed color grading
- [ ] **Filter Intensity Slider** - Adjustable strength (0-100%)
- [ ] **Custom Filter Creation** - Save personal filter presets
- [ ] **LUT Import Support** - Import .cube and .3dl files

#### Effects Library
- [ ] **Blur Effects**: Gaussian, Motion, Radial, Tilt-shift
- [ ] **Grain & Noise** - Film simulation
- [ ] **Light Leaks** - Artistic light overlays
- [ ] **Bokeh** - Background blur with shape selection
- [ ] **Glitch Effects** - Digital art effects
- [ ] **Double Exposure** - Image blending

### Q3 2026: Creative Tools

#### Text & Typography
- [ ] **Rich Text Editor** - Full formatting control
- [ ] **100+ Font Library** - Curated typography collection
- [ ] **Text Effects**: Shadow, outline, gradient fill
- [ ] **Curved Text** - Text on path
- [ ] **Text Templates** - Social media ready designs

#### Stickers & Overlays
- [ ] **Sticker Library** - 500+ categorized stickers
- [ ] **Custom Sticker Import** - PNG with transparency
- [ ] **Animated Stickers** - GIF and APNG support
- [ ] **Frame Overlays** - Polaroid, vintage, modern frames
- [ ] **Shape Overlays** - Geometric design elements

#### Drawing & Annotation
- [ ] **Brush Engine**: Pen, marker, highlighter, airbrush
- [ ] **Brush Customization** - Size, opacity, hardness
- [ ] **Shape Tools** - Rectangle, circle, arrow, line
- [ ] **Color Picker** - Eyedropper from image
- [ ] **Layers Support** - Non-destructive editing

### Q4 2026: AI-Powered Features

#### Intelligent Editing
- [ ] **Auto-Enhance** - One-tap AI improvement
- [ ] **Smart Object Selection** - AI-powered subject detection
- [ ] **Background Removal** - Automatic background extraction
- [ ] **Background Replacement** - AI scene generation
- [ ] **Portrait Mode** - Depth-aware blur
- [ ] **Sky Replacement** - Intelligent sky detection and swap

#### Advanced AI Tools
- [ ] **Face Detection & Enhancement** - Skin smoothing, blemish removal
- [ ] **Object Removal** - Content-aware fill
- [ ] **Image Upscaling** - AI super-resolution (2x, 4x)
- [ ] **Style Transfer** - Apply artistic styles
- [ ] **Colorization** - B&W to color conversion

### Technical Architecture Goals

```
lib/
├── core/
│   ├── engine/
│   │   ├── image_processor.dart      # GPU-accelerated processing
│   │   ├── filter_engine.dart        # Real-time filter pipeline
│   │   └── layer_manager.dart        # Multi-layer composition
│   ├── ai/
│   │   ├── segmentation_service.dart # Object/background separation
│   │   ├── enhancement_service.dart  # Auto-enhance algorithms
│   │   └── ml_models/                # On-device ML models
│   └── utils/
│       ├── color_space.dart          # RGB, HSL, LAB conversions
│       └── histogram.dart            # Image analysis
├── features/
│   ├── adjustments/                  # Brightness, contrast, etc.
│   ├── filters/                      # Filter system
│   ├── effects/                      # Blur, grain, etc.
│   ├── text/                         # Typography system
│   ├── stickers/                     # Overlay system
│   ├── drawing/                      # Brush engine
│   └── ai_tools/                     # AI-powered features
└── ui/
    ├── editor_page.dart              # Main editor interface
    ├── tools_panel.dart              # Tool selection
    └── preview_canvas.dart           # Real-time preview
```

### Performance Targets
- **Real-time Preview**: <16ms frame time (60 FPS)
- **Filter Application**: <100ms for full-resolution
- **Export Time**: <2s for 4K images
- **Memory Usage**: <200MB peak during editing
- **Startup Time**: <500ms cold start

### Competitive Analysis

| Feature | neom_image_editor (2026) | Snapseed | Canva | Lightroom Mobile |
|---------|--------------------------|----------|-------|------------------|
| Basic Adjustments | Full | Full | Limited | Full |
| Filters | 50+ | 30+ | 100+ | 50+ |
| AI Background Removal | Yes | No | Yes (Pro) | Yes |
| Text/Typography | Full | Basic | Full | No |
| Layers | Yes | Limited | Yes | No |
| LUT Support | Yes | No | No | Yes |
| Offline AI | Yes | No | No | Partial |
| Open Source | Yes | No | No | No |

---

## Dependencies

- `neom_core` - Core services and configuration
- `neom_commons` - Shared UI components
- `image_cropper` - Native image cropping

## License

Apache License 2.0 - see [LICENSE](LICENSE) for details.

---

**Open Neom** - Empowering digital expression through open-source technology.
