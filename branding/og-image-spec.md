# OG Image Specification

## Current problem

The current `og-image.png` shows only the "aa" logo on a dark background. When
shared on LinkedIn, Twitter, or Slack, the preview card shows a cryptic symbol
with no text. Visitors scroll past it because there is no information to read.

## Requirements

- Dimensions: 1200x630px (standard OG ratio)
- Format: PNG
- File: `public/og-image.png`

## Layout

```
+--------------------------------------------------+
|                                                  |
|   [aa logo]  BaDaaS                              |
|              60px circle   VT323 font, 72px      |
|                                                  |
|   Making the Internet better.                    |
|   SourceCodePro, 28px, muted                     |
|                                                  |
|   ----  (80px accent bar, steel blue)            |
|                                                  |
|   badaas.be                                      |
|   SourceCodePro, 20px, muted                     |
|                                                  |
+--------------------------------------------------+
```

Left-aligned content, vertically centered. Left padding: ~100px. Top/bottom:
auto-centered.

## Colors

- Background: #161b26 (dark theme bg)
- Logo circle: existing "aa" logo colors
- "BaDaaS" text: #5b8fd4 (accent blue)
- Tagline: #8891a5 (muted text)
- Accent bar: #5b8fd4
- URL: #8891a5

## Fonts

- "BaDaaS": VT323 at 72px
- Tagline: SourceCodePro at 28px
- URL: SourceCodePro at 20px

## Safe zone

Social platforms crop differently. Keep all content within the center 1100x530
area (50px margin on all sides).

LinkedIn crops to ~1.91:1, Twitter to ~2:1. Both work with 1200x630 if content
is centered vertically.

## How to create

Option A: Figma/Canva with the above spec Option B: Generate with satori
(Vercel's OG image library) Option C: HTML screenshot with Playwright at
1200x630

The simplest approach is Figma: create a 1200x630 frame, set bg to #161b26,
place the logo, add text layers.
