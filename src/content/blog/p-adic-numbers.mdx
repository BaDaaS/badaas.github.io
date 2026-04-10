---
title:
  "p-adic Numbers: From a Different Idea of Closeness to Cryptographic Attacks"
description:
  "An introduction to p-adic numbers for developers and engineers. We build the
  p-adic integers from scratch, work through concrete examples, trace the
  history from Hensel to Scholze, and explain why cryptographers need to care."
pubDate: 2026-04-10
author: "Danny Willems"
authorUrl: "https://dannywillems.github.io"
tags:
  [
    "cryptography",
    "number-theory",
    "p-adic-numbers",
    "elliptic-curves",
    "mathematics",
  ]
---

## What does "close" mean?

How close are 1 and 1000001? In the usual sense, they are a million apart. But
what if I told you there is a perfectly rigorous, perfectly useful notion of
distance under which 1 and 1000001 are extremely close, while 1 and 2 are not
particularly close at all?

The real numbers are built on one specific idea of size: the usual absolute
value, $|x|$. Two numbers are close when $|x - y|$ is small. We are so used to
this that it feels like a law of nature. It is not. It is a choice, and
[Ostrowski's theorem](https://en.wikipedia.org/wiki/Ostrowski%27s_theorem) tells
us exactly what the other choices are. For each prime $p$, there is a completely
different absolute value on $\mathbb{Q}$, and completing the rationals with
respect to it gives a completely different number system. These are the $p$-adic
numbers.

What makes this more than a curiosity is that these alternative completions turn
out to be essential. You cannot fully understand the integers without
understanding them locally at every prime. And you cannot break certain elliptic
curve cryptosystems without reaching for the $p$-adic toolkit.

## The p-adic absolute value

Everything starts with a simple counting function. Given a prime $p$ and a
nonzero integer $n$, define $v_p(n)$ to be the largest power of $p$ that divides
$n$. This is the **p-adic valuation**.

Let us work with $p = 5$ throughout.

- $v_5(75) = 2$, because $75 = 3 \cdot 5^2$.
- $v_5(12) = 0$, because 5 does not divide 12.
- $v_5(500) = 3$, because $500 = 4 \cdot 5^3$.

For rationals, extend by the rule $v_5(a/b) = v_5(a) - v_5(b)$. So
$v_5(3/25) = 0 - 2 = -2$.

Now define the **5-adic absolute value**:

$$|x|_5 = 5^{-v_5(x)}, \qquad |0|_5 = 0.$$

Read that definition twice. It inverts the valuation. The more times 5 divides
$x$, the _smaller_ $|x|_5$ becomes. Numbers that are highly divisible by 5 are
$p$-adically tiny.

Concretely:

- $|75|_5 = 5^{-2} = 1/25$. So 75 is small.
- $|12|_5 = 5^{0} = 1$. Nothing special.
- $|1/25|_5 = 5^{-(-2)} = 5^2 = 25$. That is large.

This is the key inversion. In the 5-adic world, multiples of high powers of 5
vanish, while fractions with 5 in the denominator blow up.

The $p$-adic absolute value satisfies something stronger than the triangle
inequality. It satisfies the **ultrametric inequality**:

$$|x + y|_p \leq \max(|x|_p, |y|_p).$$

Check it: let $x = 75$ and $y = 50$. Then $x + y = 125$. We have $|75|_5 =
1/25$,
$|50|_5 = 1/25$, and $|125|_5 = 5^{-3} = 1/125$. Indeed
$1/125 \leq
\max(1/25, 1/25) = 1/25$. The sum is actually _smaller_ than either
term.

This ultrametric property has a famous consequence: every triangle is isosceles.
If two sides have different lengths, the third side equals the longer one. This
is not a curiosity. It fundamentally changes the topology, making every open
ball also closed, and making convergence far easier to control than in
$\mathbb{R}$.

## Construction of $\mathbb{Z}_p$

How do we build the $p$-adic integers? The approach is the same one used to
construct the reals, but with a different measuring stick.

Recall how $\mathbb{R}$ is built. Start with $\mathbb{Q}$. A sequence $(a_n)$ of
rationals is _Cauchy_ with respect to the usual absolute value if, for every
$\varepsilon > 0$, eventually $|a_m - a_n| < \varepsilon$. The real numbers are
equivalence classes of such Cauchy sequences, where two sequences are equivalent
if their difference converges to zero.

Now do the same thing with $|\cdot|_p$ instead of $|\cdot|$. A sequence of
rationals is $p$-adically Cauchy if $|a_m - a_n|_p$ eventually becomes
arbitrarily small, meaning $a_m \equiv a_n \pmod{p^N}$ for arbitrarily large
$N$. The completion is $\mathbb{Q}_p$, the field of $p$-adic numbers. The
subring of elements with $|x|_p \leq 1$ is $\mathbb{Z}_p$, the $p$-adic
integers.

That is clean, but what do elements of $\mathbb{Z}_p$ actually look like?

Every element of $\mathbb{Z}_p$ has a unique representation as a formal power
series in $p$:

$$x = a_0 + a_1 p + a_2 p^2 + a_3 p^3 + \cdots$$

where each $a_i \in \{0, 1, \ldots, p-1\}$. This looks like writing a number in
base $p$, except the expansion goes to the _right_ (toward higher powers of $p$)
rather than to the left. Ordinary base-$p$ notation is a finite sum; this is
potentially infinite.

How do you find this expansion for a given rational? The algorithm is direct.
Given $x \in \mathbb{Z}_p$:

1. Set $a_0 = x \bmod p$.
2. Replace $x$ with $(x - a_0) / p$.
3. Repeat: $a_n = x \bmod p$, then $x \leftarrow (x - a_n)/p$.

Each step peels off one digit. For ordinary positive integers, the process
terminates (all subsequent digits are 0). For negative integers and fractions,
it runs forever, producing the infinite expansions that make $\mathbb{Z}_p$
genuinely larger than $\mathbb{Z}$.

There is one more way to say this, and it is the one algebraists prefer. The
maps $\mathbb{Z}/p^{n+1}\mathbb{Z} \to \mathbb{Z}/p^n\mathbb{Z}$ (reduce mod
$p^n$) form a projective system. The $p$-adic integers are its inverse limit:
$\mathbb{Z}_p = \varprojlim \mathbb{Z}/p^n\mathbb{Z}$. An element is a
compatible sequence of residues, one for each level, which is exactly the digit
expansion above packaged differently.

## Worked examples

Abstract definitions earn their keep when you compute with them. Let us work in
$\mathbb{Z}_5$.

### $-1$ in $\mathbb{Z}_5$

Apply the algorithm. We need $a_0 \equiv -1 \pmod{5}$. That gives $a_0 = 4$. Now
compute $((-1) - 4)/5 = -5/5 = -1$. We are back where we started. So $a_1 = 4$,
and the pattern repeats forever:

$$-1 = 4 + 4 \cdot 5 + 4 \cdot 5^2 + 4 \cdot 5^3 + \cdots = \ldots 44444_5.$$

Does this check out? Add 1 to it. The digit $a_0 = 4$ plus 1 gives 5, which is
$0$ with a carry of 1. The next digit: $4 + 1 = 5$, again $0$ with a carry. This
propagates forever, leaving all zeros. So
$\ldots 44444_5 + 1 = \ldots 00000_5 = 0$. Exactly right.

If this reminds you of two's complement, it should. In a 32-bit unsigned
integer, $-1$ is represented as `0xFFFFFFFF`, all bits set. The $p$-adic
representation is the same idea, except with no word-length bound. Two's
complement is a finite truncation of the 2-adic expansion.

### $1/3$ in $\mathbb{Z}_5$

We need $x$ such that $3x = 1$ in $\mathbb{Z}_5$. Apply the algorithm to $1/3$.

Step 0: Find $a_0$ such that $3 a_0 \equiv 1 \pmod{5}$. Since
$3 \cdot 2 = 6
\equiv 1$, we get $a_0 = 2$.

Now compute $(1/3 - 2)/5$. We have $1/3 - 2 = -5/3$, so $(-5/3)/5 = -1/3$.

Step 1: Find $a_1$ such that $3 a_1 \equiv -1 \pmod{5}$. Since
$3 \cdot 3 = 9
\equiv -1$, we get $a_1 = 3$.

Now $((-1/3) - 3)/5 = (-10/3)/5 = -2/3$.

Step 2: $3 a_2 \equiv -2 \pmod{5}$. Since $3 \cdot 1 = 3 \equiv -2$, we get
$a_2 = 1$.

Now $((-2/3) - 1)/5 = (-5/3)/5 = -1/3$. We are back to the state after step 0.
The expansion is periodic:

$$1/3 = 2 + 3 \cdot 5 + 1 \cdot 5^2 + 3 \cdot 5^3 + 1 \cdot 5^4 + \cdots = \ldots 13132_5.$$

Verify: the partial sum $2 + 3 \cdot 5 = 17$, and
$17 \cdot 3 = 51 \equiv 1
\pmod{25}$. The next partial sum
$17 + 1 \cdot 25 = 42$, and $42 \cdot 3 = 126
\equiv 1 \pmod{125}$. Each
truncation is the multiplicative inverse of 3 modulo the appropriate power of 5.

Why does $1/3$ have a 5-adic expansion at all? Because 3 is coprime to 5. The
element $3$ is a unit in $\mathbb{Z}_5$, so its inverse exists. On the other
hand, $1/5$ does _not_ live in $\mathbb{Z}_5$. Since $|1/5|_5 = 5 > 1$, it falls
outside the unit ball. It lives in $\mathbb{Q}_5$ but not $\mathbb{Z}_5$.

## A short, honest history

Kurt Hensel introduced the $p$-adic numbers in 1897, motivated by a striking
analogy. Algebraic number theory studies number fields, which resemble the
function fields of algebraic curves. Completing a function field at a point
gives a ring of formal power series. Hensel asked: what happens if you
"complete" the rationals at a prime $p$ the same way? The answer was
$\mathbb{Q}_p$. His instinct was brilliant, but his early work was marred by a
famously wrong proof that $e$ is transcendental over $\mathbb{Q}_p$. The error
was eventually corrected by others, and the underlying framework survived
intact.

Alexander Ostrowski proved in 1916 what might be the most clarifying result in
all of number theory.
[His theorem](https://en.wikipedia.org/wiki/Ostrowski%27s_theorem) states that,
up to equivalence, the only nontrivial absolute values on $\mathbb{Q}$ are the
usual one and the $p$-adic ones. That is it. There is no hidden fifth option.
The real numbers and the family of $p$-adic fields, one for each prime, are the
_complete_ list of completions of the rationals. When we study $\mathbb{Q}$
through the lens of $\mathbb{R}$ alone, we are looking at one view in an
infinite family.

Helmut Hasse, in the 1920s, transformed this from a structural observation into
a working tool. His **local-global principle** (also called the Hasse-Minkowski
theorem) states that a quadratic form over $\mathbb{Q}$ has a rational solution
if and only if it has a solution in $\mathbb{R}$ and in every $\mathbb{Q}_p$.
You break a hard global question into infinitely many local ones, each of which
is tractable. The principle does not hold for all equations (cubic forms can
fail it), but where it applies, it is devastatingly effective.

John Tate's 1950 doctoral thesis, often called "Tate's thesis," rebuilt the
analytic theory of $L$-functions using harmonic analysis on the group of adeles,
a structure that packages $\mathbb{R}$ and all the $\mathbb{Q}_p$ together. What
had been a collection of ad hoc calculations became a single, uniform argument.
The thesis circulated for years before formal publication and reshaped the way
number theorists think about zeta functions and their generalizations.

Peter Scholze's introduction of perfectoid spaces in 2012 opened the most recent
chapter. Perfectoid spaces provide a way to move between characteristic 0 (like
$\mathbb{Q}_p$) and characteristic $p$ (like $\mathbb{F}_p$), making problems in
one world solvable via the other. The theory earned Scholze a Fields Medal in
2018 and has already produced results that seemed out of reach a decade earlier.
The details are formidable, but the underlying impulse is Hensel's original
analogy, taken to its logical extreme.

## Why cryptographers care

The $p$-adic numbers are not just number-theoretic decoration. They appear in
concrete algorithms and concrete attacks.

### Hensel lifting

The most direct application is Hensel's lemma itself. If you can find a root of
a polynomial modulo $p$, and the derivative does not vanish there, you can lift
the root to a solution modulo $p^2$, then $p^3$, and so on. Each step is a
single Newton iteration in the $p$-adic metric.

This is not abstract. Every time you solve a system of polynomial equations over
$\mathbb{Z}/p^n\mathbb{Z}$ by first solving mod $p$ and then lifting, you are
doing $p$-adic computation. Groebner basis algorithms over local rings,
lattice-based attacks on number-theoretic problems, and CRT-based
reconstructions all use this idea in some form.

### Smart's attack on anomalous elliptic curves

This is where $p$-adic numbers deliver a direct cryptographic kill.

Let $E$ be an elliptic curve over $\mathbb{F}_p$. Normally, the elliptic curve
discrete logarithm problem (ECDLP) on $E(\mathbb{F}_p)$ is hard. That hardness
is the foundation of ECDSA, ECDH, and most elliptic curve cryptography.

But there is a degenerate case. If $\#E(\mathbb{F}_p) = p$, the curve is called
**anomalous**. Nigel Smart showed in 1999 that the ECDLP on anomalous curves can
be solved in linear time. The mechanism goes through $p$-adic numbers.

Here is the idea. Lift the curve $E/\mathbb{F}_p$ to a curve
$\tilde{E}/\mathbb{Q}_p$. Points on $E(\mathbb{F}_p)$ lift to points on
$\tilde{E}(\mathbb{Q}_p)$. The key object is the **formal group**
$\hat{E}(p\mathbb{Z}_p)$, which consists of points on $\tilde{E}$ that reduce to
the identity modulo $p$.

The formal group carries a **formal logarithm** map:

$$\log_{\hat{E}} : \hat{E}(p\mathbb{Z}_p) \to p\mathbb{Z}_p$$

This map is an isomorphism of groups. It sends the (hard) group law on the
elliptic curve to plain addition in $p\mathbb{Z}_p$. Once you are in
$p\mathbb{Z}_p$, discrete logarithm is just division: given
$\log(Q) = n
\cdot \log(P)$, compute $n = \log(Q) / \log(P)$ in $\mathbb{Q}_p$.

The anomalous condition $\#E(\mathbb{F}_p) = p$ is what makes the formal group
large enough to capture all the points we care about. Without it, the logarithm
does not see enough of the group, and the attack fails.

The takeaway for implementers: never use an anomalous curve. Any reasonable
curve generation procedure checks $\#E(\mathbb{F}_p) \neq p$, but the attack
illustrates something deeper. The $p$-adic structure was always there,
underlying the curve arithmetic. The anomalous condition simply makes it visible
and exploitable.

Here is a sketch in Sage that demonstrates the attack:

```python
def smart_attack(P, Q, p):
    """
    Solve Q = n*P on an anomalous curve E/GF(p)
    using the p-adic formal group logarithm.
    """
    E = P.curve()
    Qp = Qp(p, 5)
    Ep = EllipticCurve(Qp, [Qp(a) for a in E.a_invariants()])

    # Lift points to Q_p
    P_lift = Ep.lift_x(Qp(int(P.xy()[0])))
    Q_lift = Ep.lift_x(Qp(int(Q.xy()[0])))

    # Compute p * lifted_point, extract formal group element
    pP = p * P_lift
    pQ = p * Q_lift

    # Read off the formal logarithm from the x/y coordinate
    log_P = -pP.xy()[0] / pP.xy()[1]
    log_Q = -pQ.xy()[0] / pQ.xy()[1]

    # Discrete log is now just division in Q_p
    n = log_Q / log_P
    return ZZ(n)
```

The entire ECDLP, normally requiring $O(\sqrt{p})$ operations, collapses to a
handful of $p$-adic arithmetic steps.

### The broader picture

Beyond Smart's attack, $p$-adic analysis appears throughout modern number theory
in ways that feed back into cryptography. $p$-adic $L$-functions encode deep
arithmetic information about elliptic curves and modular forms. The Iwasawa main
conjecture (now a theorem in many cases) relates $p$-adic $L$-functions to the
structure of certain Galois modules, connecting analytic and algebraic
invariants. This circle of ideas informs our understanding of why certain
number-theoretic problems are hard and others are not, which is ultimately what
cryptographic security rests on.

## Closing

Hensel started with an analogy: primes are like points on a curve, and maybe we
should treat them that way. A century later, that analogy has become one of the
load-bearing walls of modern mathematics. The $p$-adic numbers did not just add
a new tool to the kit. They revealed that the rationals have a richer geometry
than anyone had imagined, one prime at a time.
