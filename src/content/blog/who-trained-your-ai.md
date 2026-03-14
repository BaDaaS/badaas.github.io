---
title: "Who Trained Your AI, and Can You Prove It?"
description:
  "The web's implicit contract is breaking. AI crawlers consume content without
  receipts, and no one can cryptographically prove what trained a model. We
  explore the legal, technical, and mathematical landscape of AI training
  accountability."
pubDate: 2025-06-14
tags: ["cryptography", "ai", "data-governance", "zero-knowledge-proofs"]
---

The web was built on an implicit contract: you publish content, you receive
traffic. That contract is quietly breaking -- and almost nobody has a receipt to
prove it.

---

## Bots now outpace humans on the web

Today, automated bots account for roughly **49% of all internet traffic**,
according to
[Cloudflare's 2024 bot traffic report](https://www.cloudflare.com/en-gb/learning/bots/what-is-bot-traffic/).
A growing share of those bots are not indexing content for human readers. They
are _consuming_ it as raw material for AI training pipelines.

Major crawlers currently active include:

- **[GPTBot](https://platform.openai.com/docs/gptbot)** -- OpenAI's training
  crawler
- **[ClaudeBot](https://support.anthropic.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler)**
  -- Anthropic's crawler
- **[Meta-ExternalAgent](https://developers.facebook.com/docs/sharing/webmasters/crawler/)**
  -- Meta's data collection agent
- **[CCBot](https://commoncrawl.org/ccbot)** -- Common Crawl, source of many
  open training datasets

Publishers pay for bandwidth, editorial labour, and infrastructure. AI companies
ingest the output, distil it into model weights, and monetise the result --
often without attribution, compensation, or disclosure. **The crawl leaves no
receipt.**

---

## robots.txt: a gentleman's agreement

The [robots exclusion standard](https://www.rfc-editor.org/rfc/rfc9309) --
formalised in the mid-1990s -- allows webmasters to declare crawl permissions in
a plain-text file at `yourdomain.com/robots.txt`. It is entirely voluntary.

There is no cryptographic binding. No audit trail. No penalty for violation. A
crawler that ignores `robots.txt` faces no technical barrier -- only potential
legal exposure, which varies by jurisdiction and is rarely enforced against
large technology companies.

More fundamentally, `robots.txt` was designed for _indexing_, not _training_.
Its vocabulary -- `Allow`, `Disallow`, `Crawl-delay` -- has no semantics for
questions like: _"May this content be used to fine-tune a language model?"_

Emerging proposals attempt to bridge this gap:

- **[Cloudflare's AI Audit controls](https://blog.cloudflare.com/declaring-your-aI-preferences/)**
  -- allowing site owners to block AI crawlers via their dashboard
- **[HTTP 402 Payment Required](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/402)**
  -- a dormant status code being revisited for micropayment-gated data access
- **[ai.txt proposals](https://site.spawning.ai/spawning-ai-txt)** -- a proposed
  extension to robots.txt specifically for AI training opt-outs

These solve the _access_ problem -- not the _proof_ problem. A model trained on
data collected before these controls existed carries no verifiable record of
what it consumed.

---

## The lawsuits are piling up

The legal landscape reflects the epistemic crisis:

- **[The New York Times v. OpenAI and Microsoft](https://nytimes.com/2023/12/27/business/media/new-york-times-open-ai-microsoft-lawsuit.html)**
  (December 2023) -- alleging copyright infringement at scale
- **[Andersen v. Stability AI](https://stablediffusionlitigation.com/)** --
  artists suing over image generation models trained on their work
- **[Kadrey v. Meta](https://storage.courtlistener.com/recap/gov.uscourts.cand.414822/gov.uscourts.cand.414822.1.0.pdf)**
  -- authors challenging use of books in LLaMA training
- **[Getty Images v. Stability AI](https://www.theguardian.com/technology/2023/feb/06/getty-images-sues-stability-ai-for-scraping-its-content-for-training-data)**
  -- stock photography licensing conflict

Several publishers have moved toward licensing rather than litigation:

- **[Reddit's $60M data deal with Google](https://www.reuters.com/technology/reddit-ai-content-licensing-deal-with-google-2024-02-22/)**
  (February 2024)
- **[Stack Overflow's partnership with OpenAI](https://stackoverflow.com/company/press/archive/openai-partnership)**
  (May 2024)
- **[The Financial Times' deal with OpenAI](https://www.ft.com/content/33328743-3f11-4922-ad77-034f78e5b588)**
  (April 2024)

The majority of publishers, however, have neither the leverage to negotiate nor
the tools to detect whether their content was used at all.

---

## The scale problem: human audits cannot work

When regulators attempt to mandate AI auditing -- as the
[EU AI Act](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689)
does for high-risk systems -- they implicitly assume that auditors can inspect
training data. This assumption does not survive contact with reality.

Modern foundation models are trained on datasets of extraordinary scale:

| Dataset                                                          | Scale                       | Source       |
| ---------------------------------------------------------------- | --------------------------- | ------------ |
| [The Pile](https://pile.eleuther.ai/)                            | ~300 billion tokens         | EleutherAI   |
| [FineWeb](https://huggingface.co/datasets/HuggingFaceFW/fineweb) | ~15 trillion tokens         | Hugging Face |
| [LAION-5B](https://laion.ai/blog/laion-5b/)                      | ~5 billion image-text pairs | LAION        |
| [RedPajama](https://github.com/togethercomputer/RedPajama-Data)  | ~1.2 trillion tokens        | Together AI  |

A human auditor tasked with verifying the provenance of a 15-trillion-token
dataset is not doing an audit. They are doing archaeology with a teaspoon. Even
automated tooling -- deduplication pipelines, content classifiers, domain
filters -- can only _sample_. They cannot provide mathematical guarantees.

This is the central gap: **compliance frameworks demand accountability, but the
infrastructure to deliver it does not yet exist.**

---

## The core question nobody can answer

The problem of AI training audits reduces to statements that need to be
_proven_, not merely _claimed_:

- "This model was trained on dataset D and no other."
- "Dataset D does not contain documents from domain X."
- "The training algorithm followed specification S on committed dataset D."
- "This model's outputs are consistent with training exclusively on licensed
  content."

Today, for virtually every AI system in production, **none of these statements
can be verified by any external party**. Model providers can assert them. They
cannot prove them.

The
[EU AI Act's conformity assessment requirements](https://artificialintelligenceact.eu/the-act/)
for high-risk AI systems, the
[US Executive Order on Safe, Secure, and Trustworthy AI](https://www.whitehouse.gov/briefing-room/presidential-actions/2023/10/30/executive-order-on-the-safe-secure-and-trustworthy-development-and-use-of-artificial-intelligence/),
and national AI strategies across the UK, Singapore, and Canada all demand
accountability that self-attestation cannot provide.

---

## What cryptography can offer

This is not unsolvable. Mathematics has relevant answers -- though they come
with significant engineering cost.

### Dataset commitments and Merkle trees

A [Merkle tree](https://en.wikipedia.org/wiki/Merkle_tree) constructs a binary
hash tree over a corpus. Each leaf is the hash of a document. The root -- a
single 32-byte value -- is a _commitment_ to the entire dataset. A model
provider who publishes a Merkle root before training begins has made a
verifiable commitment: they cannot later claim the dataset was different without
invalidating the root.

This solves dataset _identity_. It does not yet prove that training actually
used the committed dataset.

### Zero-knowledge proofs

[Zero-knowledge proofs](https://en.wikipedia.org/wiki/Zero-knowledge_proof)
(ZKPs) allow a prover to convince a verifier that a statement is true, without
revealing any information beyond the truth of the statement itself.

Applied to AI training, the goal is a **proof of training**: a cryptographic
object proving that model parameters theta were produced by running algorithm A
on dataset D, without revealing D or intermediate computation.

Recent research demonstrates this is tractable for specific model classes. The
**[ZKBoost paper (2026)](https://arxiv.org/search/?searchtype=all&query=ZKBoost)**
shows verifiable training for gradient-boosted trees. Systems like
**[zkML](https://github.com/zkml-community/awesome-zkml)** are extending these
techniques toward neural network inference verification.

### The floating-point problem

Here is the central technical friction: modern neural networks operate in
**[floating-point arithmetic](https://en.wikipedia.org/wiki/Floating-point_arithmetic)**
(IEEE 754 -- fp32, bf16, fp16). Zero-knowledge proof systems operate over
**[finite fields](https://en.wikipedia.org/wiki/Finite_field)** -- exact integer
arithmetic modulo a prime. These are fundamentally incompatible.

The bridge is
**[fixed-point arithmetic](https://en.wikipedia.org/wiki/Fixed-point_arithmetic)**:
representing real-valued parameters as scaled integers. A weight of 0.375
becomes 384 at scale factor 1024. Additions and multiplications become integer
operations, directly expressible in a ZK circuit. The training algorithm is
re-implemented in fixed-point, and this re-implementation is what gets encoded
as an arithmetic circuit.

The costs are real: quantisation error, range management, and circuit size.
Current ZK proving systems -- including
**[Plonky3](https://github.com/Plonky3/Plonky3)**,
**[HyperPlonk](https://eprint.iacr.org/2022/1355)**, and folding schemes like
**[Nova](https://eprint.iacr.org/2021/370)** -- are advancing rapidly. Hardware
acceleration for ZK proving is an active research and commercial area.

---

## The statements we cannot currently verify

To be concrete about what is missing, here is a non-exhaustive list of claims
routinely made by AI companies that have **no current mechanism for
cryptographic verification**:

1. "Our model was not trained on this copyrighted content." --
   _[OpenAI's position on NYT lawsuit](https://openai.com/blog/openai-and-journalism)_
2. "We honour robots.txt opt-outs." -- _stated by multiple labs, unverifiable_
3. "Personal data was removed from our training set." -- _standard GDPR
   compliance claim_
4. "Our model does not exhibit bias against protected classes." -- _common in
   enterprise AI marketing_
5. "We trained only on licensed data." --
   _[Adobe Firefly's positioning](https://www.adobe.com/products/firefly/plans.html)_

Each of these is an assertion. None is a proof. **This is the problem
statement.**

---

## Further reading

- [EU AI Act -- Official Text](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689)
- [Awesome zkML -- curated list of verifiable ML resources](https://github.com/zkml-community/awesome-zkml)
- [Common Crawl -- open dataset used across AI training](https://commoncrawl.org/)
- [Data Provenance Initiative -- auditing popular AI datasets](https://www.dataprovenance.org/)
- [Spawning.ai -- opt-out infrastructure for AI training](https://spawning.ai/)
- [Have I Been Trained? -- check if your images are in AI datasets](https://haveibeentrained.com/)
- [The Foundation Model Transparency Index](https://crfm.stanford.edu/fmti/)

---

_This article is part of an ongoing effort at [badaas.be](https://badaas.be) to
track verifiable statements at the intersection of AI, data governance, and
cryptographic accountability. Claims cited here link to primary sources. If a
source is missing or a claim has been updated,
[open an issue](https://badaas.be/contact)._
