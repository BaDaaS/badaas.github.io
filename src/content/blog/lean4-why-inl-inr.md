---
title: "Lean 4 Lore: Why inl and inr?"
description:
  "If you have ever pattern-matched on Or in Lean 4 and wondered why the
  branches are called inl and inr instead of left and right, the answer is older
  than any proof assistant. It comes from category theory."
pubDate: 2026-04-02
author: "Danny Willems"
authorUrl: "https://dannywillems.github.io"
tags: ["lean4", "type-theory", "category-theory", "formal-verification"]
---

_This is part of a series where we explore Lean 4 from the ground up, linking
every concept back to the mathematics it encodes. Each post includes real Lean
code you can compile and check yourself._

_Source material:
[lean4-courses/lore/why-inl-inr.md](https://github.com/BaDaaS/lean4-courses/blob/main/lore/why-inl-inr.md)_

---

## The question

You are pattern-matching on a disjunction `h : P \/ Q` in Lean 4:

```lean4
cases h with
| inl hp => ...   -- hp : P
| inr hq => ...   -- hq : Q
```

Why `inl`? Why `inr`? Why not `left` and `right`?

---

## The short answer

`inl` and `inr` stand for **injection left** and **injection right**. They are
the two canonical morphisms that define a
[coproduct](https://en.wikipedia.org/wiki/Coproduct) in category theory.

---

## Coproducts in category theory

Given two objects `A` and `B` in a category, their **coproduct** `A + B` is an
object equipped with two morphisms:

```
        inl         inr
  A ---------> A + B <--------- B
```

These morphisms are called **injections** because they embed `A` (respectively
`B`) into the sum `A + B` without losing information. Every element of `A + B`
came from exactly one side, and you can always tell which.

The coproduct satisfies a **universal property**: for any object `C` and any
pair of morphisms `f : A -> C` and `g : B -> C`, there is a unique morphism
`[f, g] : A + B -> C` that factors through `inl` and `inr`. This is precisely
what pattern matching does: you provide one branch for `inl` and one for `inr`,
and Lean builds the combined function.

For a full treatment, see
[Mac Lane, _Categories for the Working Mathematician_](https://link.springer.com/book/10.1007/978-1-4757-4721-8)
(Springer, 1971), chapter on coproducts and colimits.

---

## How Lean defines Or

In Lean 4, propositional disjunction is an inductive type with two constructors:

```lean4
inductive Or (a b : Prop) where
  | inl (h : a) : Or a b
  | inr (h : b) : Or a b
```

The constructors are named after the categorical injections. When you do
`cases h` on `h : P \/ Q`, the branches are named after the constructors of the
inductive type. `Or` has constructors `Or.inl` and `Or.inr`, so the branches are
`inl` and `inr`.

This is consistent across all inductive types in Lean. `cases` on `Nat` gives
branches `zero` and `succ`. On `Bool`, it gives `true` and `false`. On `Or`, it
gives `inl` and `inr`. The pattern is always: branch names = constructor names.

---

## Tactics vs. constructors

Lean has tactics called `left` and `right` for **constructing** an `Or`:

```lean4
example (hp : P) : P \/ Q := by
  left       -- goal becomes P
  exact hp

example (hq : Q) : P \/ Q := by
  right      -- goal becomes Q
  exact hq
```

Under the hood, `left` applies `Or.inl` and `right` applies `Or.inr`. The tactic
names are human-friendly aliases for **building** a proof. But when you
**eliminate** (pattern match on) an `Or`, you see the real constructor names.

This is a deliberate separation of concerns:

- **Introduction** (building a value): tactics can have ergonomic names (`left`,
  `right`)
- **Elimination** (pattern matching): branch names reflect the datatype's actual
  structure (`inl`, `inr`)

---

## The same pattern in Sum types

For data (as opposed to propositions), Lean uses `Sum`:

```lean4
inductive Sum (a b : Type) where
  | inl (val : a) : Sum a b
  | inr (val : b) : Sum a b
```

Same names. Same categorical origin. `Or` is the propositional version (living
in `Prop`), `Sum` is the data version (living in `Type`). Both are coproducts.

---

## The same pattern in other proof assistants

This naming is not a Lean invention. The injection terminology appears across
the proof assistant ecosystem:

| System                                                                    | Left injection       | Right injection      |
| ------------------------------------------------------------------------- | -------------------- | -------------------- |
| Lean 4                                                                    | `Or.inl` / `Sum.inl` | `Or.inr` / `Sum.inr` |
| [Coq](https://coq.inria.fr/doc/v8.18/refman/language/core/inductive.html) | `or_introl`          | `or_intror`          |
| [Agda](https://agda.readthedocs.io/en/latest/language/data-types.html)    | `inj1`               | `inj2`               |
| [Idris](https://idris2.readthedocs.io/)                                   | `Left`               | `Right`              |

The names vary, but they all trace back to the same categorical concept.

---

## Why this matters

Understanding `inl`/`inr` is not trivia. It connects three things:

1. **Category theory** gives the abstract structure (coproducts, universal
   property)
2. **Type theory** realises it as an inductive type with two constructors (see
   [Martin-Lof, _Intuitionistic Type Theory_](https://archive-pml.github.io/martin-lof/pdfs/Bibliopolis-Book-retypeset-1984.pdf),
   Bibliopolis, 1984, section on disjoint sum types)
3. **Lean's implementation** makes the connection explicit by using the
   categorical names

When you see `inl` in Lean, you are looking at the same mathematical object that
categorists have studied since the 1950s. The proof assistant is not inventing
jargon. It is preserving it.

---

## References

- Saunders Mac Lane,
  [_Categories for the Working Mathematician_](https://link.springer.com/book/10.1007/978-1-4757-4721-8),
  Springer, 1971. Chapter on coproducts and colimits.
- Per Martin-Lof,
  [_Intuitionistic Type Theory_](https://archive-pml.github.io/martin-lof/pdfs/Bibliopolis-Book-retypeset-1984.pdf),
  Bibliopolis, 1984. Disjoint sum type (A + B).
- Lean 4 source:
  [`Init.Prelude`](https://github.com/leanprover/lean4/blob/master/src/Init/Prelude.lean),
  definition of `Or`.
- BaDaaS lean4-courses:
  [why-inl-inr.md](https://github.com/BaDaaS/lean4-courses/blob/main/lore/why-inl-inr.md).
