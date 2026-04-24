---
title: 'Why "Tactic"?'
description:
  "The origin of the word tactic in proof assistants, from Robin Milner's LCF to
  Lean 4."
pubDate: 2026-04-24
tags: ["formal-verification", "history", "lean4"]
---

The word comes from **LCF** (Logic for Computable Functions), created by Robin
Milner at Stanford (1972) and then Edinburgh (1977-1979).

## The Problem Milner Faced

How do you construct formal proofs without writing enormous proof terms by hand?
In the early 1970s, interactive proof assistants did not exist. You either wrote
the full proof term in one shot, or you gave up.

## The Military Metaphor

Milner's insight: separate the **strategy** (what you want to prove) from the
**tactics** (the individual steps to get there). The vocabulary is deliberately
military:

- **Goal**: the objective to achieve
- **Tactic**: a maneuver that transforms one objective into simpler
  sub-objectives
- **Tactical**: a combinator that composes tactics (like `<;>`, `first`,
  `repeat` in Lean)

In LCF, a tactic was literally an ML function:

```ml
type tactic = goal -> (goal list * validation)
```

It takes a goal, returns a list of sub-goals and a **validation**: a function
that, given proofs of the sub-goals, reconstructs the proof of the original
goal.

This is exactly what Lean does today. When you write:

```lean
apply hqr
```

The tactic takes the goal `R`, produces the sub-goal `Q`, and records the
validation: "given a proof `?a : Q`, the proof of `R` is `hqr ?a`."

## Why Not "Command" or "Rule"?

A tactic is a precise concept: a function that transforms a **proof state**
(goal + context) into a new proof state. It is not just a command (it produces a
verified term). It is not an inference rule (it can fail, combine multiple
rules, backtrack).

The term captures the idea of a local move in a proof that does not guarantee
success by itself, but advances toward the objective.

## The Family Tree

```
LCF (Milner, 1972, Stanford; 1977, Edinburgh)
  |
  +-> HOL (Gordon, 1988, Cambridge)
  |
  +-> Isabelle (Paulson, 1986, Cambridge)
  |
  +-> Coq (Huet/Coquand, 1989, INRIA)
  |     |
  |     +-> Ltac (Delahaye, 2000)
  |
  +-> Lean 4 (de Moura, 2021, Microsoft Research)
```

All these systems use "tactic" in Milner's sense. Lean 4 is the first where
tactics are written in the same language as proofs (Lean itself), via the
`TacticM` monad.

## References

- Robin Milner,
  ["Logic for Computable Functions: description of a machine implementation,"](https://apps.dtic.mil/sti/pdfs/AD0785072.pdf)
  Stanford AI Memo AIM-169, 1972.
- Michael Gordon, Robin Milner, Christopher Wadsworth,
  ["Edinburgh LCF: A Mechanised Logic of Computation,"](https://archive.org/details/edinburghlcfmech0000gord/page/164/mode/2up)
  Springer LNCS 78, 1979.

---

_This post was generated with Claude Opus 4.6._
