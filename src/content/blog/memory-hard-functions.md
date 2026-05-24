---
title:
  "An Overview and History of Memory-Hard Functions, from scrypt to RandomX"
description:
  "A symmetric cryptographer's tour of memory-hard functions: why they exist,
  how they evolved from scrypt and the Password Hashing Competition to RandomX,
  the formal models behind them (cumulative memory complexity, depth-robustness,
  pebbling games), and the trade-offs between data-dependent and
  data-independent designs."
pubDate: 2026-05-24
author: "Danny Willems"
authorUrl: "https://dannywillems.github.io"
tags:
  [
    "cryptography",
    "symmetric-cryptography",
    "hash-functions",
    "memory-hard-functions",
    "proof-of-work",
    "password-hashing",
  ]
---

<div class="note-box">

_This article is an overview written from the point of view of a symmetric
cryptography researcher. It surveys published designs and the academic
literature; it is not a recommendation. If you spot an error, please
[contact me](mailto:danny@badaas.be) or
[open an issue](https://github.com/BaDaaS/badaas.github.io/issues)._

</div>

A hash function takes a bitstring and returns a fixed-size digest. From the
inside, SHA-256, BLAKE2, and Keccak look like sequences of bitwise mixing
operations: a few kilobytes of state, a round function, a sponge or
Merkle-Damgård mode. Their security goals (collision resistance, preimage
resistance, indifferentiability from a random oracle) are stated in terms of
query complexity, not in terms of how much RAM an evaluator owns.

**Memory-hard functions** (MHFs) deliberately break this picture. They are
constructions, built on top of an underlying compression primitive, whose
intended computational cost is dominated by memory traffic rather than by
arithmetic. Evaluating them on a machine with little memory should be
significantly slower or significantly more expensive than evaluating them on a
machine with enough memory. The goal is to make custom hardware (ASICs, FPGAs,
GPUs) less effective relative to commodity CPUs, either to slow down
password-cracking attacks or to keep proof-of-work mining accessible.

This article traces the line from Colin Percival's scrypt to Argon2, then to the
proof-of-work family (Ethash, Equihash, CryptoNight, RandomX), with the formal
models that emerged alongside.

---

## Motivation: why memory at all?

Two application domains drive MHF design, and the literature occasionally
conflates them.

**Password hashing.** A server stores `H(password, salt)` and must recompute it
on each login. An attacker who steals the database wants to enumerate candidate
passwords at the lowest possible cost per guess. PBKDF2
([RFC 2898](https://datatracker.ietf.org/doc/html/rfc2898), 2000) and bcrypt
([Provos and Mazières, USENIX 1999](https://www.usenix.org/legacy/event/usenix99/provos/provos.pdf))
inflate the cost per guess by iterating a PRF. The asymmetry an attacker
exploits is hardware: a GPU or ASIC running PBKDF2-HMAC-SHA-256 evaluates
millions of candidates in parallel for a fraction of the energy a CPU spends. An
MHF aims to remove that asymmetry by forcing each evaluation to occupy a large
fraction of fast memory for a non-trivial period of time.

**Egalitarian proof-of-work.** Bitcoin uses double-SHA-256, which is
small-state, compute-bound, and trivially pipelined. ASIC vendors built mining
hardware that outperforms general-purpose CPUs by several orders of magnitude,
concentrating hash rate among a few manufacturers and operators. Several
projects (Litecoin, Monero, Ethereum, Zcash) chose hash functions designed to
reduce that gap by tying the cost of evaluation to commodity DRAM, CPU caches,
or instruction-decoder bandwidth. Whether this is sustainable in the long run is
debated; the design intent is what matters for this article.

The two settings impose different constraints. Password hashing needs
side-channel resistance (the salt and password leak through cache timing if
memory access depends on them) and parameters small enough to evaluate at login
latency. Proof-of-work needs fast verification by a third party, and can
tolerate longer evaluation. Both settings care about the same underlying
question: how do we lower-bound the amortized hardware cost of evaluating a
function?

---

## scrypt and the start of the field

The first construction explicitly called "memory-hard" is **scrypt**, by Colin
Percival, published in
[Stronger Key Derivation via Sequential Memory-Hard Functions](https://www.tarsnap.com/scrypt/scrypt.pdf)
(BSDCan 2009). Two ideas matter.

First, Percival proposed a complexity measure for hardware cost. He used the
**area-time (AT) product**: if an attacker builds a custom circuit of area $A$
that evaluates the function in time $T$, the cost (energy, silicon, opportunity)
scales like $A \cdot T$. A function is **sequential memory-hard** if any
algorithm evaluating it in time $T$ on a parallel machine requires memory of
order $N$ such that $A \cdot T = \Omega(N^2)$, where $N$ is a parameter
controlling memory use.

Second, he gave a concrete construction. scrypt internally calls **ROMix**,
which:

1. Initializes a vector $V[0], V[1], \dots, V[N-1]$ by iterating a hash function
   ($V[i+1] = H(V[i])$).
2. Performs $N$ random reads: at step $j$, computes $k = X \mod N$ for the
   current state $X$, reads $V[k]$, and mixes it in.

The random reads are **data-dependent**: the address $k$ at step $j$ depends on
the values computed so far. An evaluator who keeps the full $V$ in memory runs
in time $O(N)$. An evaluator with less memory must recompute entries on demand,
and Percival proved (assuming the underlying hash behaves as a random oracle)
that this leads to the $N^2$ trade-off.

scrypt ships in Tarsnap, in many password-hashing libraries, and as a
proof-of-work in Litecoin (with very small $N$, which weakens the
memory-hardness argument and was anticipated by Percival; see
[Litecoin's parameter choice](https://litecoin.info/index.php/Scrypt) and
critiques such as
[Andersen 2014](https://da-data.blogspot.com/2014/03/in-defense-of-gpu-mining-monero-bytecoin.html)).

### What a symmetric cryptographer notices first

The cryptographic core of scrypt is **Salsa20/8** (a reduced-round variant of
Bernstein's Salsa20) used inside `BlockMix`. Salsa20 is a stream cipher, not a
collision-resistant hash, and the reduced-round version is far from any
recommended use. Percival's argument treats it as an indifferentiable
permutation; whether this is sound for an MHF is an empirical question. The
analysis in
[Salsa20 cryptanalysis](https://cr.yp.to/snuffle/salsafamily-20071225.pdf)
(Bernstein, 2007) suggests Salsa20/8 has substantial security margin against
known attacks, but using a reduced primitive remains a recurring criticism.

---

## Formalizing memory hardness

Percival's AT framework was a starting point but left questions open. What does
$A$ mean precisely? Are sequential algorithms the right baseline? How do
parallel attackers using $p$ processors change the picture?

The line of work that addressed this begins with Alwen and Serbinenko,
[High Parallel Complexity Graphs and Memory-Hard Functions](https://eprint.iacr.org/2014/238)
(STOC 2015). They introduced **cumulative memory complexity (CMC)** as the right
measure.

### Cumulative memory complexity

Model an MHF evaluation as a DAG where each node is a call to the compression
function $H$ and edges encode "the input to this call is the output of those
calls". An algorithm computing the function corresponds to a strategy for
placing **pebbles** on the DAG: a pebble represents the value of a node being
held in memory. To pebble a node, all its predecessors must currently hold
pebbles; once pebbled, a node's pebble can be removed and re-placed later, at
the cost of re-pebbling its predecessors.

If at time step $t$ the algorithm uses $s_t$ pebbles, its **cumulative memory
complexity** is

$$
\mathrm{CMC} = \sum_t s_t
$$

For a parallel attacker, this matches "total RAM occupied across the whole
computation" and is closely related to energy use (DRAM cells need refresh power
proportional to their occupancy time). Alwen and Serbinenko argued that CMC is a
better hardware-cost proxy than peak memory or AT, because amortizing many
evaluations on shared hardware exposes any temporal slack that AT cannot see.

The pebbling reformulation also clarified an important fact: **the
memory-hardness of an MHF reduces to a graph property of its underlying DAG**,
as long as the compression function is modeled as a random oracle. The symmetric
primitive is, in this framework, a black box; the design problem is
graph-theoretic.

### Data-independent vs data-dependent

The graph $G$ falls in one of two categories.

- **Data-independent MHFs (iMHFs).** The DAG is fixed by the public parameters;
  memory access patterns do not depend on the secret input. This matters for
  password hashing because cache-timing attacks
  ([Bernstein 2005](https://cr.yp.to/antiforgery/cachetiming-20050414.pdf)) on
  data-dependent access can leak the password. Argon2i and Balloon Hashing are
  iMHFs.

- **Data-dependent MHFs (dMHFs).** The graph is determined at runtime by the
  input. scrypt, Argon2d, and most PoW MHFs are dMHFs. They allow stronger
  memory-hardness lower bounds but expose memory access patterns, so they are
  inappropriate for cases where the input is a secret that lives on the same
  machine as a potential side-channel attacker.

Alwen, Blocki, and Pietrzak,
[Depth-Robust Graphs and Their Cumulative Memory Complexity](https://eprint.iacr.org/2016/875)
(EUROCRYPT 2017), showed that iMHFs are inherently weaker: any iMHF on $N$ nodes
has CMC at most $O(N^2 \log \log N / \log N)$, while well-designed dMHFs can
reach the optimal $\Theta(N^2)$. The gap is small in asymptotic terms but real,
and it tracks the practical trade-off between side-channel resistance and attack
cost.

A series of papers turned these bounds into concrete attacks on Argon2i:

- Alwen and Blocki,
  [Efficiently Computing Data-Independent Memory-Hard Functions](https://eprint.iacr.org/2016/115)
  (CRYPTO 2016).
- Alwen and Blocki,
  [Towards Practical Attacks on Argon2i and Balloon Hashing](https://eprint.iacr.org/2016/759)
  (EuroS&P 2017).
- Alwen, Blocki, and Harsha,
  [Practical Graphs for Optimal Side-Channel Resistant Memory-Hard Functions](https://eprint.iacr.org/2017/443)
  (CCS 2017).

The first two papers reduce the memory required to evaluate Argon2i by constant
factors in the parameter ranges actually deployed (1 GiB, a few passes). The
third paper gives a graph construction (the DRSample family) that pushes iMHFs
close to the theoretical limit and was proposed as a replacement for the Argon2i
indexing function.

For a careful introduction by one of the authors, Joël Alwen's
[home page](https://jalwen.com/) collects this line of work; the survey
[Bandwidth-Hard Functions: Reductions and Lower Bounds](https://eprint.iacr.org/2018/944)
(Blocki, Ren, Zhou, CRYPTO 2018) extends the framework to energy cost under
realistic memory hierarchies, which is where the literature has mostly moved
since.

---

## The Password Hashing Competition

The 2013-2015 [Password Hashing Competition](https://www.password-hashing.net/)
(PHC), organized by an informal panel including Jean-Philippe Aumasson, Tony
Arcieri, Dmitry Khovratovich, and Solar Designer (Alexander Peslyak), was the
main catalyst for the modern MHF literature. Twenty-four candidates were
submitted; the panel selected **Argon2** as the winner, with **Catena**,
**Lyra2**, **Makwa**, and **yescrypt** receiving special recognition.

### Argon2

Argon2, by Biryukov, Dinu, and Khovratovich
([specification PDF](https://www.password-hashing.net/argon2-specs.pdf), later
RFC [9106](https://datatracker.ietf.org/doc/html/rfc9106)), comes in three
variants:

- **Argon2d**: data-dependent indexing. Maximum memory-hardness, intended for
  PoW or for settings where the input is not a secret on the local machine.
- **Argon2i**: data-independent indexing. Side-channel resistant, intended for
  password hashing.
- **Argon2id**: a hybrid that runs one pass of Argon2i (to limit early
  side-channel leakage) followed by Argon2d (to recover memory-hardness). RFC
  9106 recommends Argon2id as the default.

Internally, Argon2 calls **BLAKE2b** (compressed to a single round on 1024-byte
blocks) as its mixing function. The choice is pragmatic: BLAKE2b is
well-analyzed, has a fast software implementation on x86-64 (SIMD-friendly ARX),
and contributes negligibly to the overall cost compared with the memory
accesses.

The history of Argon2 illustrates the iMHF/dMHF gap concretely. The original
Argon2i (Argon2i-A) was attacked by Alwen-Blocki within months of PHC's
conclusion; the response was Argon2i-B with two-pass indexing, which recovers
most of the lost CMC but at the price of a constant factor in runtime. The
hybrid Argon2id was added in response to ongoing discussion about the right
design point, and is now the recommended variant in
[RFC 9106](https://datatracker.ietf.org/doc/html/rfc9106).

### yescrypt

[yescrypt](https://www.openwall.com/yescrypt/), by Solar Designer (Alexander
Peslyak), extends scrypt with a tunable amount of "pwxform"-style integer
multiplication aimed at frustrating GPU implementations. Solar Designer's
[design notes](https://www.openwall.com/articles/PHC-yescrypt-pwxform) and the
[PHC discussion archive](https://www.openwall.com/lists/crypt-dev/) give the
rationale. yescrypt is used by default on recent Fedora and some other Linux
distributions for the system password database, replacing SHA-512 crypt.

### Balloon hashing

[Balloon hashing](https://eprint.iacr.org/2016/027), by Boneh, Corrigan-Gibbs,
and Schechter (ASIACRYPT 2016), is a simple iMHF built from any standard
cryptographic hash. Its appeal is pedagogical and engineering: it is short, has
a clean security proof in the random oracle model, and does not introduce a new
permutation. It has seen less deployment than Argon2id but is occasionally cited
as a reference design (for example, in the
[Filecoin proofs](https://research.protocol.ai/) literature).

---

## Proof-of-work memory-hard functions

PoW MHFs differ from password-hashing MHFs in three ways:

1. The verifier must check a candidate quickly, so the function is evaluated
   many times to find a small digest, but a single evaluation should be cheap to
   verify.
2. There is no secret input, so cache-timing side channels are irrelevant and
   data-dependent designs are preferred.
3. The relevant adversary is an industrial ASIC vendor with a multi-year
   horizon, not an attacker trying to crack a leaked database overnight.

The four main deployed designs are Ethash, CryptoNight, RandomX, and Equihash,
plus several variants.

### Ethash (Ethereum, 2015-2022)

[Ethash](https://ethereum.org/en/developers/docs/consensus-mechanisms/pow/mining-algorithms/ethash/)
was Ethereum's PoW until the [Merge](https://ethereum.org/en/roadmap/merge/)
in 2022. It is built around a 1+ GiB DAG generated from the chain epoch
(regenerated every ~30 000 blocks). Mining performs ~64 pseudo-random reads from
the DAG per nonce attempt. Verification can use a much smaller "cache" (a few
MiB) to recompute the needed DAG entries on demand.

The intent was that DRAM bandwidth, not arithmetic, would dominate mining cost.
In practice, GPU mining dominated, and ASICs for Ethash (notably from Bitmain
and Linzhi) appeared around 2018. The Ethereum community considered
[ProgPoW](https://github.com/ifdefelse/ProgPOW) as a more aggressively
GPU-friendly replacement, but it was never deployed; the move to proof-of-stake
superseded the discussion. Kik's analysis,
[Ethash and ASICs](https://medium.com/@Kik_Interactive/the-truth-about-progpow-2dca8ab7f51),
and Linzhi's
[whitepaper](https://www.linzhi.io/wp-content/uploads/2019/03/Linzhi-LZH1-Ethash-Whitepaper.pdf),
give the manufacturer-side view.

### Equihash (Zcash, 2016)

[Equihash](https://eprint.iacr.org/2015/946), by Biryukov and Khovratovich (NDSS
2016), reduces PoW to a generalized birthday problem. Given a hash function with
$n$-bit output, find $2^k$ inputs whose outputs XOR to zero, under a constraint
that forces the search to use Wagner's algorithm. The memory cost of Wagner's
algorithm at the chosen parameters ($n=200$, $k=9$) was originally around 700
MiB.

Equihash was deployed by Zcash, Bitcoin Gold, and others. ASICs eventually
appeared (Bitmain Z9, 2018), partly because the parameters were chosen too small
to make memory truly dominant. Zcash later migrated to Equihash $(200, 9)$ then
to Halo 2 proofs after the Heartwood/Halo upgrades; the trajectory is documented
on the [Electric Coin Company blog](https://electriccoin.co/blog/).

### CryptoNight (Monero, 2014-2019)

CryptoNight, defined in the
[CryptoNote v2 specification](https://web.archive.org/web/20180628211010/https://cryptonote.org/cns/cns008.txt),
uses a 2 MiB scratchpad and a sequence of AES-NI rounds. The scratchpad fits in
L3 cache on most CPUs of the period. CryptoNight powered Monero from launch
through 2019 and underwent several scheduled tweaks (CryptoNight-V7, V8, R)
intended to break compatibility with newly appearing ASICs. Each tweak
temporarily restored CPU and GPU competitive parity until vendors caught up; the
cycle is described in the Monero research lab notes
([MRL-0007](https://www.getmonero.org/resources/research-lab/), follow-ups). The
fatigue from this cycle motivated the move to RandomX.

### RandomX (Monero, 2019-present)

[RandomX](https://github.com/tevador/RandomX), by tevador and the Monero
Research Lab, was activated on Monero at block 1 978 433 on
[November 30, 2019](https://en.cryptonomist.ch/2019/09/23/hard-fork-monero-xmr/).
It departs from the earlier scratchpad pattern by introducing a
**random-program** layer.

The high-level structure:

1. A seed (from the block header) is used to generate a 2080 MiB dataset (the
   "fast mode" working set), or alternatively a 256 MiB cache for lightweight
   verification.
2. The seed also generates a short program in a custom RISC-like instruction
   set: integer arithmetic, IEEE-754 floating-point, branches, and memory
   accesses against the dataset.
3. The program is executed in a virtual machine that mixes a 2 MiB scratchpad.
   The program is JIT-compiled to native code on x86-64 and AArch64 for
   performance.
4. The final scratchpad state is hashed with BLAKE2b to produce the nonce
   result.

The hypothesis behind RandomX is that an ASIC designed to run RandomX would
essentially be a general-purpose CPU: it would need a floating-point unit, a
branch predictor, a JIT cache, a memory hierarchy with the right latency
profile, and AES units. Tevador's
[design document](https://github.com/tevador/RandomX/blob/master/doc/design.md)
makes this argument in detail. As of 2026, no commercially available ASIC for
RandomX has been reported, though this is not a formal hardness result.

RandomX is the most ambitious deployed MHF in the sense that it tries to exploit
several scarce resources at once (DRAM bandwidth, cache hierarchy, out-of-order
execution, IEEE-754 hardware) rather than just memory size. It is also the
hardest to analyze: the security argument is engineering and economic, not
graph-theoretic.

### ProgPoW

[ProgPoW](https://github.com/ifdefelse/ProgPOW) (2018) was proposed for Ethereum
as a more GPU-tuned alternative to Ethash. It generates short random programs of
GPU-typical operations (32-bit integer math, KISS99 PRNG rounds, FNV hashing)
and interleaves them with DAG reads. It was not deployed; the proposal and the
response from Bitmain are interesting case studies in the social side of ASIC
resistance. [Kik 2019](https://github.com/kik/progpow-exploits) raised concerns
about the achievability of its stated goals.

---

## A symmetric cryptographer's reading

From a symmetric-primitive standpoint, three observations recur across these
designs.

### The underlying primitive is a small piece of the security argument

All of the above use a standard (or near-standard) compression building block:
BLAKE2b in Argon2 and RandomX, SHA-256/SHA-512 in scrypt and Balloon, AES round
in CryptoNight and RandomX, Salsa20/8 in scrypt's BlockMix, Keccak in Ethash.
The memory-hardness argument is essentially graph-theoretic and assumes the
primitive behaves as a random oracle (for hash functions) or an ideal
permutation (for AES round, Salsa20/8 used as a mixer). Most known attacks on
these designs do not exploit the primitive; they exploit the graph or the
parameter choice. Tessaro and Thiruvengadam's
[Provable Time-Memory Trade-Offs: Symmetric Cryptography Against Memory-Bounded Adversaries](https://eprint.iacr.org/2018/780)
makes the dependence on the random-oracle assumption explicit.

That said, the dependence is real. The random-oracle assumption can fail in
subtle ways for reduced-round primitives, and the use of Salsa20/8 (not
Salsa20/20) in scrypt is the cleanest example. As MHFs migrate to non-standard
primitives (the AES rounds in RandomX, the SuperscalarHash in RandomX's dataset
generation), the symmetric-analysis surface grows. If a distinguisher were found
for one of these reduced primitives, the graph-theoretic CMC lower bound would
not protect the construction.

### Side channels deserve more attention than they get

The choice between iMHFs and dMHFs is usually framed as "memory-hardness vs
side-channel resistance". For password hashing on a server that an attacker can
co-tenant (think a cloud VM with Spectre-class attacks available), the
data-dependent variants leak the memory access pattern, and an attacker who can
observe cache state can often reduce the effective password search space
dramatically. The [Argon2id](https://datatracker.ietf.org/doc/html/rfc9106)
hybrid is the current pragmatic compromise; it is not a proof of security
against any realistic side-channel model.

For PoW, side channels do not matter because the input is public. But
side-channel-style analyses of mining hardware (power, EM, micro-architectural
fingerprinting) are still relevant to ASIC detection and to fairness arguments.
There is little academic work here.

### The "anti-ASIC" goal is engineering, not theory

Pebbling lower bounds give us asymptotic statements about CMC. None of them say
anything about the cost of a fab in 2030. The history of Ethash, CryptoNight,
and Equihash is that determined ASIC vendors caught up within two to four years
of deployment, despite memory-bound design goals. RandomX is the most aggressive
attempt to widen the moat (by demanding the full feature set of a modern CPU),
and it has held for about six years at the time of writing. Whether it will
continue to depends on the economics of CPU-class custom silicon, not on any
theorem we know how to prove.

The closest thing to a theoretical handle on this is the **bandwidth-hard
function** model of Ren and Devadas,
[Bandwidth Hard Functions for ASIC Resistance](https://eprint.iacr.org/2017/225)
(TCC 2017), which models the asymmetry between cheap on-chip computation and
expensive off-chip memory bandwidth. It captures the Ethash/RandomX intuition
more directly than CMC does, but it is still an asymptotic model with parameters
that have to be estimated from current process technology.

---

## Trade-offs summary

| Construction                     | Year | Class     | Underlying primitive     | Side-channel safe | Pebbling-style bound     | Deployed in (selection)               |
| -------------------------------- | ---- | --------- | ------------------------ | ----------------- | ------------------------ | ------------------------------------- |
| **scrypt**                       | 2009 | dMHF      | Salsa20/8, SHA-256       | No                | AT $= \Omega(N^2)$ (ROM) | Tarsnap, Litecoin (small $N$)         |
| **Catena**                       | 2014 | iMHF      | BLAKE2b                  | Yes               | Graph-theoretic          | None deployed widely                  |
| **Lyra2**                        | 2014 | dMHF      | BLAKE2b (sponge)         | No                | Heuristic                | Vertcoin                              |
| **Argon2d / Argon2i / Argon2id** | 2015 | dMHF/iMHF | BLAKE2b (1-round, 1 KiB) | i: Yes, d: No     | CMC bounds known         | RFC 9106, libsodium, many libraries   |
| **yescrypt**                     | 2014 | dMHF      | Salsa20/8 + pwxform      | No                | Same as scrypt + pwxform | Fedora password hashing               |
| **Balloon hashing**              | 2016 | iMHF      | Any standard hash        | Yes               | CMC proven               | Reference / research                  |
| **Ethash**                       | 2015 | dMHF      | Keccak-256, FNV          | N/A (PoW)         | Heuristic                | Ethereum (until 2022)                 |
| **CryptoNight**                  | 2014 | dMHF      | AES rounds, Keccak       | N/A (PoW)         | Heuristic                | Monero (until 2019), CryptoNote coins |
| **Equihash**                     | 2016 | dMHF      | BLAKE2b + Wagner         | N/A (PoW)         | Generalized birthday     | Zcash (until Halo), Bitcoin Gold      |
| **RandomX**                      | 2019 | dMHF      | AES rounds, BLAKE2b, JIT | N/A (PoW)         | Engineering argument     | Monero                                |
| **ProgPoW**                      | 2018 | dMHF      | Keccak-256, KISS99       | N/A (PoW)         | Heuristic                | Not deployed                          |

A few caveats on this table. "Pebbling-style bound" refers to a formal CMC or AT
lower bound under the random-oracle model; "heuristic" means the design has
security arguments but no published CMC lower bound. Argon2i's original bound
was tightened then partially broken by the Alwen-Blocki attacks; the "CMC bounds
known" entry refers to the more recent two-pass Argon2i-B analysis.

---

## Open problems

A short, biased list of questions I find interesting.

1. **A bandwidth-hard analogue for password hashing.** The bandwidth-hard
   framework is built around the AT model and assumes the adversary builds
   custom hardware. Translating its bounds into per-evaluation latency
   constraints suitable for an authentication server is open.

2. **Side-channel-resistant MHFs with tight CMC.** The Alwen-Blocki-Harsha
   DRSample construction comes very close to the iMHF upper bound, but verifying
   its practical CMC against realistic cache models is non-trivial. The
   [On the Depth-Robustness and Cumulative Pebbling Cost of Argon2i](https://eprint.iacr.org/2018/944)
   line (Blocki, Zhou, and others) is still active.

3. **RandomX cryptanalysis.** RandomX has not received much published
   cryptanalysis. Its security argument is mostly economic. Even a distinguisher
   on its SuperscalarHash that does not lead to a full attack would be
   informative.

4. **Post-quantum implications.** None of the above analysis considers a quantum
   adversary. Grover's algorithm reduces the work to find a PoW target from
   $2^n$ to $2^{n/2}$. The interaction between Grover and memory-hard structure
   has been explored
   ([Czajkowski-Hülsing-Schaffner 2018](https://eprint.iacr.org/2018/107)) but
   is far from settled.

---

## References

Primary papers (in roughly chronological order):

- C. Percival.
  [Stronger Key Derivation via Sequential Memory-Hard Functions](https://www.tarsnap.com/scrypt/scrypt.pdf).
  BSDCan 2009.
- N. Provos and D. Mazières.
  [A Future-Adaptable Password Scheme](https://www.usenix.org/legacy/event/usenix99/provos/provos.pdf).
  USENIX 1999. (bcrypt)
- J. Alwen and V. Serbinenko.
  [High Parallel Complexity Graphs and Memory-Hard Functions](https://eprint.iacr.org/2014/238).
  STOC 2015.
- A. Biryukov, D. Dinu, D. Khovratovich.
  [Argon2: the memory-hard function for password hashing and other applications](https://www.password-hashing.net/argon2-specs.pdf).
  PHC, 2015.
- A. Biryukov and D. Khovratovich.
  [Equihash: Asymmetric Proof-of-Work Based on the Generalized Birthday Problem](https://eprint.iacr.org/2015/946).
  NDSS 2016.
- J. Alwen and J. Blocki.
  [Efficiently Computing Data-Independent Memory-Hard Functions](https://eprint.iacr.org/2016/115).
  CRYPTO 2016.
- D. Boneh, H. Corrigan-Gibbs, S. Schechter.
  [Balloon Hashing: A Memory-Hard Function Providing Provable Protection Against Sequential Attacks](https://eprint.iacr.org/2016/027).
  ASIACRYPT 2016.
- J. Alwen, J. Blocki, K. Pietrzak.
  [Depth-Robust Graphs and Their Cumulative Memory Complexity](https://eprint.iacr.org/2016/875).
  EUROCRYPT 2017.
- J. Alwen and J. Blocki.
  [Towards Practical Attacks on Argon2i and Balloon Hashing](https://eprint.iacr.org/2016/759).
  IEEE EuroS&P 2017.
- L. Ren and S. Devadas.
  [Bandwidth Hard Functions for ASIC Resistance](https://eprint.iacr.org/2017/225).
  TCC 2017.
- J. Alwen, J. Blocki, B. Harsha.
  [Practical Graphs for Optimal Side-Channel Resistant Memory-Hard Functions](https://eprint.iacr.org/2017/443).
  CCS 2017.
- J. Blocki, L. Ren, S. Zhou.
  [Bandwidth-Hard Functions: Reductions and Lower Bounds](https://eprint.iacr.org/2018/944).
  CRYPTO 2018.
- A. Biryukov, D. Khovratovich.
  [Egalitarian Computing](https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_paper_biryukov.pdf).
  USENIX Security 2016.
- A. Hosoyamada, T. Iwata.
  [Tight Quantum Indifferentiability of a Rate-1/3 Compression Function](https://eprint.iacr.org/2021/322). 2021.
  (One of several papers exploring quantum security of hash modes relevant to
  MHF building blocks.)
- S. Tessaro, A. Thiruvengadam.
  [Provable Time-Memory Trade-Offs: Symmetric Cryptography Against Memory-Bounded Adversaries](https://eprint.iacr.org/2018/780).
  TCC 2018.

Specifications and deployment notes:

- [RFC 9106 (Argon2)](https://datatracker.ietf.org/doc/html/rfc9106).
- [RFC 7914 (scrypt)](https://datatracker.ietf.org/doc/html/rfc7914).
- [RandomX specification](https://github.com/tevador/RandomX/blob/master/doc/specs.md)
  and
  [design document](https://github.com/tevador/RandomX/blob/master/doc/design.md).
- [Ethash specification](https://ethereum.org/en/developers/docs/consensus-mechanisms/pow/mining-algorithms/ethash/).
- [yescrypt project page](https://www.openwall.com/yescrypt/).

Researcher blogs and surveys:

- Joël Alwen's [home page](https://jalwen.com/) collects the CMC line of work.
- Solar Designer's
  [crypt-dev list archive](https://www.openwall.com/lists/crypt-dev/) is the
  historical record of yescrypt's development.
- Filippo Valsorda,
  [The scrypt Parameters](https://words.filippo.io/the-scrypt-parameters/), on
  choosing parameters in practice.
- The [Password Hashing Competition site](https://www.password-hashing.net/)
  archives all PHC submissions and the panel's reports.
- The [Monero Research Lab](https://www.getmonero.org/resources/research-lab/)
  page hosts the RandomX rationale and the earlier CryptoNight notes.

---

_This article was drafted with the assistance of Claude Opus 4.7, with the
author reviewing and editing throughout. References were checked against primary
sources but errors may remain; please report them._
