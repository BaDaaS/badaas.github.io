# Writing Core Rules

Shared neutral-tone rules for any long-form prose (blog posts, research papers,
articles, technical documentation). Specialized files (`blog-post.md`,
`research-paper.md`, `article.md`) inherit these rules and add context-specific
guidance.

## Tone

- **NEVER** use flowery, grandiose, or vague language. No metaphors, no poetic
  flourishes, no "the future of X", "revolutionizing", "unleashing",
  "empowering", "game-changing", or similar marketing language.
- **NEVER** make overly affirmative or absolute claims. Avoid "must", "always",
  "never", "every", "all", "everyone", "the only way", "the best", unless backed
  by a citation or explicitly factual.
- **STAY NEUTRAL**. Present facts, trends, and trade-offs. Do not advocate
  unless explicitly asked. Frame opinions as opinions, not facts.
- **NEVER** use urgency or emotional pressure ("urgent", "critical",
  "essential", "you need to", "you should") unless the context explicitly calls
  for a call-to-action.
- **NO hyperbole**. Avoid "extraordinarily", "incredibly", "massively",
  "vastly", "tremendously", "enormous", "huge", and similar intensifiers.

## Structure

- State the concrete fact or claim first. Then add context and citation.
- If a sentence could be removed without losing information, remove it.
- Prefer specific numbers, dates, names, and links over qualitative claims.
- Avoid filler transitions like "in today's world", "as we all know", "needless
  to say", "it is worth noting that".

## Soften affirmative claims

When stating that a technique, tool, or approach has a benefit, soften it:

- Instead of "X solves Y", write "X is one approach to Y" or "X aims to address
  Y".
- Instead of "X reduces risk", write "X may help reduce risk" or "X is intended
  to reduce risk".
- Instead of "X is the standard", write "X is widely used" or "X is one of the
  commonly used approaches".
- Instead of "everyone uses X", write "X is used by [specific examples]".

## Comparisons

- Comparisons must be specific and sourced. Do not write "X is faster than Y"
  without a benchmark or citation.
- Acknowledge trade-offs. If X has an advantage over Y in one dimension, Y
  likely has an advantage in another. State both.

## References and citations

- Link to primary sources whenever possible (papers, official docs, source
  code).
- Prefer specific URLs over generic references ("see the documentation").
- When citing a tool, organization, or paper, include a link or a proper
  bibliographic reference.

## What to remove on review

When reviewing prose, look for and rewrite or remove:

- Adjectives that add emphasis without information ("truly", "really", "deeply",
  "fundamentally").
- Sentences asserting urgency or importance without evidence.
- Marketing-style closings ("the future is here", "the time is now").
- Overgeneralizations ("every developer", "all systems", "no one").
- Subjective superlatives without sources ("most important", "most productive",
  "densest concentration", "the leading", "the best").
- Rhetorical contrasts ("not X but Y") that add drama without information.

## Exclusions

These rules do NOT override:

- Direct quotes from external sources (preserve exact wording).
- Content the user explicitly marks as verbatim (do not rewrite).
- Documentation prose where formality and assertiveness are appropriate (API
  references, normative specification documents).
