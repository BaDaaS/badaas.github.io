# GitHub Copilot Instructions

Repository-wide instructions for GitHub Copilot (chat, code review, agents).

## Project context

This is the BaDaaS website (`badaas.be`), built with Astro 5.x + Tailwind
CSS v4 and deployed to GitHub Pages. The site has a landing page and a
technical blog at `src/content/blog/` (Markdown/MDX).

## Reviewing blog post PRs

When reviewing pull requests that add or modify files under
`src/content/blog/`, apply the rules in:

- [`.github/llm/writing-core.md`](./llm/writing-core.md) - shared
  neutral-tone rules (no flourishing, soften absolute claims, prefer
  citations over qualitative claims, what to remove on review).
- [`.github/llm/blog-post.md`](./llm/blog-post.md) - blog-specific
  guidance (voice, opinions framed as opinions, structure).
  Inherits from `writing-core.md`.

Specifically, flag in review:

- Unsourced superlatives ("the most", "the largest", "dominant",
  "densest concentration", "leading", "the standard").
- Hyperbole ("extraordinarily", "incredibly", "enormous", "huge").
- Marketing language ("revolutionizing", "game-changing", "the future
  of X", "empowering").
- Urgency or emotional pressure ("urgent", "critical", "must",
  "every", "always") without citation.
- Rhetorical contrasts ("not X but Y") that add drama without
  information.
- Filler adjectives ("truly", "really", "deeply", "fundamentally").
- Comparisons without a benchmark or citation.

Suggest concrete rewrites that follow the soften-affirmative-claims
templates in `writing-core.md` (e.g., "X solves Y" -> "X is one
approach to Y").

## Code style

- Follow existing project conventions in nearby files.
- Match the style of the file being edited.
- See `CLAUDE.md` at the repo root for the project's general
  guidelines (commands, theming, SEO).
