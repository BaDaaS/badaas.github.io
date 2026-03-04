# BaDaaS Website

Website for [BaDaaS](https://badaas.be) - Making the Internet better through
applied mathematics, cryptography, and open source.

## Stack

- [Astro 5](https://astro.build) with MDX
- [Tailwind CSS v4](https://tailwindcss.com)
- GitHub Pages (custom domain `badaas.be`)

## Commands

```bash
make install   # Install dependencies
make dev       # Dev server (localhost:4321)
make build     # Production build
make format    # Format all files
```

## Structure

```
src/
├── content/blog/   # Blog posts (Markdown/MDX)
├── components/     # Astro components
├── layouts/        # BaseLayout, BlogPost
├── pages/          # Routes (index, blog, 404)
└── styles/         # Tailwind + CSS custom properties
public/
├── fonts/          # VT323, SourceCodePro
└── res/            # Logo SVG
```

## License

All rights reserved.
