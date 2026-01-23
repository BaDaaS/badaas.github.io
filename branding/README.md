# BaDaaS Brand Assets

This directory contains official BaDaaS brand assets for consistent use across
all platforms.

## Directory Structure

```
branding/
├── logo/
│   ├── svg/          # Vector format (preferred)
│   ├── png/          # Raster with transparency
│   │   ├── 32/       # Favicon size
│   │   ├── 64/
│   │   ├── 128/
│   │   ├── 256/
│   │   ├── 512/
│   │   └── 1024/     # High resolution
│   ├── pdf/          # Print-ready
│   └── source/       # Original AI/design files
├── colors/           # Color palette documentation
├── fonts/            # Font information
└── social/           # Pre-sized social media assets
```

## Logo Variants

| Variant             | Use Case                            |
| ------------------- | ----------------------------------- |
| `badaas-logo`       | Default logo (green on transparent) |
| `badaas-logo-light` | For dark backgrounds                |
| `badaas-logo-dark`  | For light backgrounds               |
| `badaas-icon`       | Icon only, no text                  |

## Usage Guidelines

- Always use the appropriate variant for the background
- Maintain aspect ratio when scaling
- Use SVG for web, PNG for applications, PDF for print
- Minimum clear space: height of the "B" in BaDaaS

## Quick Reference

- **Primary Color**: `#c1bb3a`
- **Background Dark**: `#191919`
- **Font**: Source Code Pro

See `colors/palette.md` for full color specifications.
