# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project Overview

This is the website for BaDaaS, an Applied Mathematics & Cryptography Lab from
Belgium. Built with Astro, it includes a landing page and technical blog with
code highlighting.

## Architecture

- **Framework**: Astro 5.x with MDX support
- **Styling**: SASS with CSS custom properties for theming
- **Blog**: Content collections with Markdown/MDX
- **Hosting**: GitHub Pages with custom domain `badaas.be`

## Project Structure

```
├── src/
│   ├── content/
│   │   └── blog/          # Blog posts (Markdown/MDX)
│   ├── layouts/
│   │   ├── BaseLayout.astro
│   │   └── BlogPost.astro
│   ├── pages/
│   │   ├── index.astro    # Landing page
│   │   └── blog/
│   │       ├── index.astro
│   │       └── [...slug].astro
│   └── styles/
│       └── global.scss    # Global styles with themes
├── public/
│   ├── fonts/             # Custom fonts
│   └── res/               # Logo images
└── astro.config.mjs
```

## Commands

Use Makefile targets for all commands:

- `make help` - Show available commands
- `make install` - Install dependencies
- `make dev` - Start development server
- `make build` - Build for production
- `make preview` - Preview production build
- `make format` - Format all files
- `make fix-trailing-whitespaces` - Remove trailing whitespaces
- `make clean` - Clean build artifacts

## Writing Blog Posts

Create new posts in `src/content/blog/` with frontmatter:

```markdown
---
title: "Post Title"
description: "Brief description"
pubDate: 2026-01-23
tags: ["cryptography", "security"]
---

Content here with code blocks...
```

Code blocks support syntax highlighting via Shiki (github-dark theme).

## Required Actions Before Committing

1. `make format`
2. `make fix-trailing-whitespaces`

## Theming

Themes are controlled via `data-theme` attribute on `<html>`:

- Default: dark theme
- `data-theme="light"` - Light theme
- `data-theme="blue"` - Blue accent theme
