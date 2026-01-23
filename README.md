# BaDaaS Website

Website for BaDaaS - Applied Mathematics & Cryptography Lab from Belgium.

**Live site:** [badaas.be](https://badaas.be)

## Tech Stack

- [Astro](https://astro.build) - Static site generator
- SASS - Styling with theme support
- MDX - Blog with code highlighting

## Development

```bash
make install    # Install dependencies
make dev        # Start dev server (localhost:4321)
make build      # Build for production
make preview    # Preview production build
```

## Formatting

```bash
make format                    # Format all files
make format-check              # Check formatting
make fix-trailing-whitespaces  # Fix trailing whitespaces
```

## Structure

```
src/
├── content/blog/    # Blog posts (Markdown/MDX)
├── layouts/         # Page layouts
├── pages/           # Routes
└── styles/          # SASS stylesheets
public/              # Static assets
branding/            # Logo variants and brand assets
```

## License

All rights reserved.
