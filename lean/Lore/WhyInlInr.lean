/-
Copyright (c) 2026 BaDaaS. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Danny Willems
-/

/-!
# Why inl and inr?

Compilable examples for the blog post "Lean 4 Lore: Why inl and inr?"
Each snippet is delimited by `-- SNIPPET:` / `-- END:` markers so the
blog can import individual sections.
-/

-- Or and Sum are defined in Lean core. We use `#print` to display
-- their definitions, proving they exist and match what the blog shows.

-- SNIPPET: print-or
#print Or
-- END: print-or

-- SNIPPET: print-sum
#print Sum
-- END: print-sum

variable {P Q : Prop}

-- SNIPPET: cases-example
example (h : P \/ Q) : Q \/ P := by
  cases h with
  | inl hp => exact Or.inr hp
  | inr hq => exact Or.inl hq
-- END: cases-example

-- SNIPPET: left-right-tactics
example (hp : P) : P \/ Q := by
  left
  exact hp

example (hq : Q) : P \/ Q := by
  right
  exact hq
-- END: left-right-tactics

-- SNIPPET: sum-example
def swapSum {A B : Type} (s : Sum A B) : Sum B A :=
  match s with
  | Sum.inl a => Sum.inr a
  | Sum.inr b => Sum.inl b
-- END: sum-example
