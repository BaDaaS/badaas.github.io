# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Project Overview

This is a static website for BaDaaS (Blockchain and DLT as a Service), hosted on
GitHub Pages. The site serves as a landing page for a Belgian cryptography lab
that builds blockchain applications.

## Architecture

- **Static HTML Site**: Single `index.html` file with minimal structure
- **Custom CSS**: Single stylesheet at `css/style.css` with custom fonts and
  dark theme
- **Assets**: Logo images in `res/` directory, custom fonts in `fonts/`
  directory
- **Hosting**: GitHub Pages with custom domain `badaas.be` (configured via
  CNAME)

## Key Files

- `index.html`: Main landing page with company information and links
- `css/style.css`: Custom stylesheet with dark theme and custom fonts
- `CNAME`: Domain configuration for GitHub Pages
- `res/`: Contains BaDaaS logo images (regular and reverse versions)
- `fonts/`: Custom font files (VT323, Source Code Pro variable font)

## Development

This is a simple static site with no build process required. Changes can be made
directly to the HTML and CSS files.

### Commands

Use the Makefile targets to run commands:

- `make help`: Show available commands
- `make install`: Install dependencies (prettier)
- `make prettify`: Format all files with prettier
- `make fix-trailing-whitespaces`: Remove trailing whitespaces from all files
- `make check-trailing-whitespaces`: Check for trailing whitespaces in files
- `make format-check`: Check if files are formatted correctly

### Required Actions Before Committing

Always run these commands before committing changes:

1. `make prettify`
2. `make fix-trailing-whitespaces`

### Making Changes

1. Edit `index.html` for content changes
2. Edit `css/style.css` for styling changes
3. Replace images in `res/` as needed
4. Run formatting commands before committing
5. Commit and push changes - GitHub Pages will automatically deploy

### Git Commit Guidelines

- Never mention Claude as a co-author in commit messages
- Keep commits focused and descriptive

### Code Style Guidelines

- Always wrap lines at 80 characters in Makefiles
- Use line continuation with backslashes for long commands

### Design Notes

- Uses a dark theme with green accent color (#c1bb3a)
- Custom fonts: VT323 for headings, Source Code Pro for body text
- Responsive design with flexbox centering
- Simple, minimalist design focused on company branding and contact information
