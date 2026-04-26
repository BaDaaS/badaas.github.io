---
title: "High Assurance Cryptography: A snapshot of the landscape"
description:
  "An overview of the high assurance cryptography ecosystem: the companies,
  research labs, tools, programming languages, products, and cryptographic
  primitives that make up the world of formally verified and rigorously
  engineered cryptographic software."
pubDate: 2026-04-26
tags:
  [
    "cryptography",
    "formal-verification",
    "high-assurance",
    "security",
    "rust",
    "fstar",
  ]
---

<div class="note-box">

_This article is part of an ongoing effort at [BaDaaS](https://badaas.be) to
track the cryptographic engineering landscape. If an organization, tool, or
country is missing,
[open an issue](https://github.com/BaDaaS/badaas.github.io/issues)._

_This document was mostly generated with Claude Opus 4.7. If you spot any error,
please [contact me](mailto:danny@badaas.be) or
[open an issue](https://github.com/BaDaaS/badaas.github.io/issues)._ Claude is
used at BaDaaS to gather information available across the Internet, codebases
and papers. We do not encourage to use AI to generate cryptographic code (or
critical code in general). This document does not reflect any opinion of the
company or the author. If you think that the article has opiniated content,
please contact us.

</div>

Cryptographic software has a unique property: a single implementation bug can
silently undermine the security of millions of users. Padding oracle
vulnerabilities, timing side-channels, integer overflows in bignum arithmetic --
the attack surface of a cryptographic library is measured not just in lines of
code, but in the gap between mathematical specification and running program.

**High assurance cryptography** is the discipline of closing that gap using
formal methods, memory-safe languages, and machine-checked proofs. The goal is
software where correctness is not a claim made in a README, but a theorem proved
in a proof assistant.

This article maps the ecosystem: the organizations building it, the tools they
use, the languages they write in, and the primitives they have verified.

---

## What "high assurance" means

The term covers a spectrum of rigor:

| Level                        | Technique                                          | Example                                                                                                                                                |
| ---------------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Testing + fuzzing**        | Property-based tests, differential fuzzing         | [libsodium](https://libsodium.gitbook.io/doc) test suite                                                                                               |
| **Constant-time discipline** | Compiler analysis, ct-verif, dudect                | [s2n](https://github.com/aws/s2n-tls), [BearSSL](https://bearssl.org/)                                                                                 |
| **Memory safety**            | Safe language, borrow checker, garbage collection  | [RustCrypto](https://github.com/rustcrypto), [ring](https://github.com/briansmith/ring)                                                                |
| **Functional correctness**   | Machine-checked proofs against a formal spec       | [HACL\*](https://github.com/hacl-star/hacl-star), [Fiat-Crypto](https://github.com/mit-plv/fiat-crypto), [EverCrypt](https://eprint.iacr.org/2019/757) |
| **Computational security**   | Game-based proofs, symbolic or computational model | CryptoVerif proofs of TLS, Signal                                                                                                                      |

In practice, the most credible high assurance libraries combine several of these
levels: a formally specified API, a machine-checked proof of functional
correctness, constant-time guarantees verified by a dedicated tool, and
extraction to a safe or audited target language.

---

## Organizations

### Research labs and universities

**[INRIA](https://www.inria.fr/)** (France) and the
[Prosecco team](https://prosecco.inria.fr/) at INRIA Paris produced
**[miTLS](https://www.mitls.org/)** -- a formally verified TLS implementation
written in F\* -- and contributed core work on the
**[HACL\*](https://hacl-star.github.io/)** library. Former Prosecco members span
academia and industry worldwide.

**[Carnegie Mellon University](https://www.cmu.edu/)** (USA) houses
[CyLab](https://www.cylab.cmu.edu/) and has produced verified cryptographic
protocols through projects like
**[OWL](https://www.andrew.cmu.edu/user/bparno/papers/owl.pdf)** and
contributions to Coq-based verification infrastructure.

**[MIT CSAIL](https://www.csail.mit.edu/)** (USA) contributed
**[Fiat-Crypto](https://github.com/mit-plv/fiat-crypto)**, the Coq-based
generator of verified finite-field arithmetic that now ships inside Google
Chrome and Mozilla Firefox.

**[ETH Zurich](https://ethz.ch/)** (Switzerland) runs the
[Programming Methodology group](https://www.pm.inf.ethz.ch/) and has produced
verification work on separation logic and program analysis relevant to
cryptographic code.

**[IMDEA Software Institute](https://software.imdea.org/)** (Spain) developed
the **[Jasmin](https://github.com/jasmin-lang/jasmin)** programming language and
the **[EasyCrypt](https://www.easycrypt.info/)** framework for game-based
cryptographic security proofs.

**[Centrum Wiskunde & Informatica (CWI)](https://www.cwi.nl/)** (Netherlands)
hosts the [Cryptology Group](https://www.cwi.nl/en/groups/cryptology/) led by
[Ronald Cramer](https://homepages.cwi.nl/~cramer/),
[Léo Ducas](https://homepages.cwi.nl/~ducas/), and
[Serge Fehr](https://homepages.cwi.nl/~fehr/). Léo Ducas is a co-author of
CRYSTALS-Kyber (ML-KEM) and CRYSTALS-Dilithium (ML-DSA).

**[Radboud University](https://www.ru.nl/en)** (Netherlands) produced the
**[XMSS](https://datatracker.ietf.org/doc/html/rfc8391)** stateful hash-based
signature scheme and associated verification work, adopted by NIST and the
German BSI.

### Companies

**[Galois](https://galois.com/)** (Portland, USA) is probably the best-known
commercial organization exclusively focused on high assurance software. They
build cryptographic libraries, write formal proofs in Coq and SAW (Software
Analysis Workbench), and advise US government and defense clients. Notable work:
**[cryptol](https://cryptol.net/)** (a domain-specific language for specifying
cryptographic algorithms) and **[SAW](https://saw.galois.com/)** (Software
Analysis Workbench for bit-precise equivalence checking).

**[Cryspen](https://cryspen.com/)** (Germany / distributed) is a spinout from
INRIA Prosecco alumni. They maintain the
**[HACL\* packages](https://github.com/cryspen/hacl-packages)** and
**[libcrux](https://github.com/cryspen/libcrux)** -- a formally verified
cryptographic library targeting the Rust and C ecosystems, including the first
formally verified ML-KEM (Kyber) implementation.

**[Trail of Bits](https://www.trailofbits.com/)** (New York, USA) combines
security auditing with tool development. Their
**[manticore](https://github.com/trailofbits/manticore)** symbolic execution
engine and **[echidna](https://github.com/crytic/echidna)** fuzzer are widely
used. They have audited many cryptographic implementations and contributed to
constant-time verification tooling.

**[NCC Group](https://www.nccgroup.com/)** (Manchester, UK / worldwide) performs
cryptographic audits at scale, including formal reviews of TLS implementations,
key management systems, and hardware security modules. Their Cryptography
Services team has published extensive public research on implementation flaws.

**[Cure53](https://cure53.de/)** (Berlin, Germany) audits cryptographic code and
protocols. Their published reports are listed at
[cure53/Publications](https://github.com/cure53/Publications).

**[Nadim Kobeissi / Symbolic Software](https://symbolic.software/)** (France)
built **[Verifpal](https://verifpal.com/)** -- a protocol verification tool
designed for a wider audience than ProVerif or Tamarin.

**[Amazon Web Services (AWS)](https://aws.amazon.com/)** (USA) produced
**[s2n-tls](https://github.com/aws/s2n-tls)** -- their TLS implementation with a
formal proof of the handshake state machine -- and
**[s2n-bignum](https://github.com/awslabs/s2n-bignum)** -- machine-checked
assembly for big-number arithmetic used in AWS cryptographic services.

**[Google](https://security.google/)** (USA) ships Fiat-Crypto-generated field
arithmetic in Chrome's TLS stack and is the primary maintainer of
**[BoringSSL](https://boringssl.googlesource.com/boringssl)**, which has
undergone multiple formal analyses.

**[Microsoft Research](https://www.microsoft.com/en-us/research/)** (USA / UK /
India) is the primary developer of **[F\*](https://fstar-lang.org/)** -- the
dependently typed language underlying HACL\* and EverCrypt -- and has
contributed formally verified cryptographic components to the
**[Everest](https://project-everest.github.io/)** project.

**[PQShield](https://pqshield.com/)** (Oxford, UK) focuses on post-quantum
cryptography for hardware and software, with formal verification work on
lattice-based schemes. Their engineers contributed to the NIST PQC
standardization process.

**[SandboxAQ](https://www.sandboxaq.com/)** (USA) develops cryptographic agility
and post-quantum migration tools, with formal analysis components for enterprise
systems.

---

## Tools and technologies

### Proof assistants and verification frameworks

**[F\*](https://fstar-lang.org/)** is a dependently typed language developed at
Microsoft Research and INRIA. It combines functional programming with refinement
types and effect systems. F\* is the primary language for **HACL\*** and
**EverCrypt**, and supports extraction to C, OCaml, and WebAssembly. Security
proofs in F\* combine type-level specifications with SMT-backed discharge of
verification conditions.

**[Coq](https://coq.inria.fr/)** is the proof assistant behind **Fiat-Crypto**.
It has the longest history in the space (since 1989) and an enormous ecosystem
of verified mathematics. Cryptographic work in Coq typically proves functional
correctness (the implementation computes the right mathematical function) and
extracts to OCaml or, via specialized tools, to C.

**[Lean 4](https://leanprover.github.io/)** is an emerging proof assistant with
growing interest for cryptographic verification. Its metaprogramming
capabilities and mathematical library (**Mathlib**) make it attractive for
proofs that blend number theory with implementation correctness.

**[Isabelle/HOL](https://isabelle.in.tum.de/)** (UK / Germany) has been used for
verified cryptographic protocols in academia, including proofs in the
Computational Model using the **CryptHOL** framework developed at ETH Zurich and
Karlsruhe Institute of Technology.

**[EasyCrypt](https://www.easycrypt.info/)** targets game-based cryptographic
proofs -- the standard proof technique in modern cryptography. It provides a
probabilistic relational Hoare logic and has been used to verify constructions
like OCB, OAEP, and components of TLS. Developed at IMDEA (Spain).

**[CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)** is a proof
assistant for computational security proofs of cryptographic protocols. It is
directly connected to real-world protocols: it has been used to verify Signal,
TLS 1.3, and WireGuard. Developed by Bruno Blanchet at INRIA.

**[ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/)** works in the
Dolev-Yao (symbolic) model and is the most widely deployed protocol verifier,
used for SSH, TLS 1.3, OAuth, and many other protocols. Also from Bruno Blanchet
at INRIA.

**[Tamarin Prover](https://tamarin-prover.com/)** provides a more expressive
symbolic model with support for mutable global state and complex protocol
properties. Used for formal analysis of 5G protocols, TLS 1.3, and post-quantum
handshakes.

**[SAW (Software Analysis Workbench)](https://saw.galois.com/)** from Galois
performs bit-precise equivalence checking between a Cryptol specification and a
C or LLVM implementation. It has verified parts of **Amazon s2n**, **OpenSSL**,
and **BoringSSL** at the assembly level.

**[ct-verif](https://github.com/imdea-software/verifying-constant-time)** and
**[binsec/rel](https://binsec.github.io/)** verify constant-time properties of
binary code -- ensuring no secret-dependent branching or memory access patterns
exist that could leak via timing channels.

**[Jasmin](https://github.com/jasmin-lang/jasmin)** is a programming language
for high-speed cryptographic implementations with verified compilation. Jasmin
programs can be proven functionally correct and secure, then compiled to
optimized x86 assembly. Used for verified implementations of X25519, SHA-256,
ChaCha20, and others.

### Memory safety approaches

**[Rust](https://www.rust-lang.org/)** has become the dominant memory-safe
language for production cryptographic software. Its ownership model and borrow
checker eliminate use-after-free, buffer overflows, and data races at compile
time -- the classes of bugs responsible for the majority of cryptographic
implementation vulnerabilities historically.

**[Haskell](https://www.haskell.org/)** provides strong type safety and is used
in **[cryptonite](https://github.com/haskell-crypto/cryptonite)** and
**[botan](https://github.com/haskell-cryptography/botan)**. Its garbage
collection eliminates memory corruption but introduces timing variability that
must be managed carefully.

**[OCaml](https://ocaml.org/)** is the extraction target for Coq-generated code
and is used in **miTLS** (which extracts F\* code to OCaml). The
**[mirage-crypto](https://github.com/mirage/mirage-crypto)** library provides a
pure OCaml cryptographic stack for the MirageOS unikernel ecosystem.

---

## Libraries and products

| Library / Product                                          | Language(s)       | Verification approach        | Organization                |
| ---------------------------------------------------------- | ----------------- | ---------------------------- | --------------------------- |
| [HACL\*](https://hacl-star.github.io/)                     | F\* → C / Wasm    | F\* proofs, ct-verif         | INRIA / Microsoft / Mozilla |
| [EverCrypt](https://project-everest.github.io/)            | F\* → C           | F\* proofs                   | Everest project             |
| [libcrux](https://github.com/cryspen/libcrux)              | Rust / F\*        | F\* proofs, ct-verif         | Cryspen                     |
| [Fiat-Crypto](https://github.com/mit-plv/fiat-crypto)      | Coq → C / Rust    | Coq proofs                   | MIT CSAIL                   |
| [s2n-tls](https://github.com/aws/s2n-tls)                  | C                 | CBMC, TLA+, SAW              | Amazon Web Services         |
| [s2n-bignum](https://github.com/awslabs/s2n-bignum)        | ARM/x86 asm + HOL | HOL Light proofs             | Amazon Web Services         |
| [miTLS](https://www.mitls.org/)                            | F\* → OCaml       | F\* proofs, CryptoVerif      | INRIA / MSR                 |
| [ring](https://github.com/briansmith/ring)                 | Rust + assembly   | Fuzzing, audits              | Brian Smith (community)     |
| [RustCrypto](https://github.com/RustCrypto)                | Rust              | Memory safety, audits        | Community                   |
| [orion](https://github.com/orion-rs/orion)                 | Rust              | Memory safety, fuzzing       | Orion project               |
| [cryptonite](https://github.com/haskell-crypto/cryptonite) | Haskell           | Memory safety, tests         | Haskell Crypto Group        |
| [mirage-crypto](https://github.com/mirage/mirage-crypto)   | OCaml             | Memory safety, tests         | MirageOS                    |
| [libsodium](https://libsodium.org/)                        | C                 | Extensive tests, ct-verif    | Frank Denis                 |
| [BoringSSL](https://boringssl.googlesource.com/boringssl)  | C + asm           | SAW partial, fuzzing, audits | Google                      |
| [Verifpal](https://verifpal.com/)                          | Go                | Symbolic protocol verifier   | Symbolic Software           |
| [BearSSL](https://bearssl.org/)                            | C                 | Constant-time design, audits | Thomas Pornin               |
| [PQ-Crystals](https://pq-crystals.org/)                    | C / Rust          | Reference implementation     | CRYSTALS team               |

---

## Programming languages in use

The high assurance cryptography ecosystem uses a wider range of languages than
most software domains, because the choice of language directly impacts what
properties can be verified.

**F\*** is the specification and proof language for the largest single corpus of
formally verified cryptographic code. Writing in F\* gives access to dependent
types, effect systems that track stateful and probabilistic computations, and
SMT-backed verification. The resulting code is extracted to readable C or
compiled to WebAssembly.

**Coq** is used where the proof style benefits from tactics-based interactive
theorem proving and the existing Coq mathematical library. Fiat-Crypto generates
finite-field arithmetic (used for Curve25519, P-256, P-384, P-521) through a
Coq-certified synthesis pipeline.

**Jasmin** combines the expressiveness of a high-level language with the control
of assembly, allowing verified implementations of cryptographic primitives that
match hand-optimized C in performance while carrying machine-checked correctness
proofs.

**Rust** is the dominant safe-systems language. While Rust does not provide
functional correctness proofs out of the box, its type system eliminates memory
safety vulnerabilities, and the ecosystem is large and active. Tools like
**[Kani](https://github.com/model-checking/kani)** (AWS) and
**[Prusti](https://github.com/viperproject/prusti-dev)** (ETH Zurich) extend
Rust with formal verification.

**Cryptol** (Galois) is a domain-specific language for writing cryptographic
specifications. It maps directly to hardware and software implementations,
enabling equivalence checking between spec and implementation via SAW.

---

## Cryptographic primitives covered

The formally verified ecosystem now covers most of the cryptographic primitives
in modern use:

### Elliptic curves

- **Curve25519 / X25519**: Field arithmetic verified in
  [Fiat-Crypto](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/curve25519_64.c);
  scalar multiplication verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/curve25519)
- **Ed25519 / EdDSA**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/ed25519); Rust
  bindings exposed by [libcrux](https://github.com/cryspen/libcrux)
- **P-256, P-384, P-521**: Field arithmetic generated by Fiat-Crypto
  ([p256_64.c](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/p256_64.c),
  [p384_64.c](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/p384_64.c),
  [p521_64.c](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/p521_64.c)),
  deployed in Chrome, Firefox, and Android. P-256 ECDSA also verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/ecdsap256)
- **secp256k1**: Field arithmetic generated by Fiat-Crypto
  ([secp256k1_dettman_64.c](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/secp256k1_dettman_64.c));
  curve operations in
  [HACL\* k256](https://github.com/hacl-star/hacl-star/tree/main/code/k256).
  Production library
  [bitcoin-core/secp256k1](https://github.com/bitcoin-core/secp256k1) is audited
  but not formally verified end-to-end.

### Symmetric primitives

- **ChaCha20-Poly1305**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/chacha20poly1305)
  (F\* proofs) and
  [Jasmin / formosa-crypto](https://github.com/formosa-crypto/formosa-25519)
- **AES-GCM**: Verified in
  [EverCrypt](https://github.com/hacl-star/hacl-star/tree/main/providers/evercrypt)
  (F\*), with hardware intrinsics; AWS-LC / BoringSSL AES-256-GCM verified via
  [SAW](https://github.com/awslabs/aws-lc-verification)
- **AES**: Verified assembly in
  [HACL\* / Vale](https://github.com/hacl-star/hacl-star/tree/main/vale/code/crypto/aes)
- **BLAKE2b / BLAKE2s**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/blake2)
- **SHA-256, SHA-384, SHA-512**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/hash) and
  [s2n-bignum](https://github.com/awslabs/s2n-bignum)
- **SHA-3 / SHAKE**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/sha3)
- **HMAC**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/hmac)

### Key derivation and agreement

- **HKDF**: Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/hkdf)
- **X25519** (Diffie-Hellman on Curve25519): Verified in
  [HACL\*](https://github.com/hacl-star/hacl-star/tree/main/code/curve25519)
- **ECDH on P-256**: Built on Fiat-Crypto
  [p256_64.c](https://github.com/mit-plv/fiat-crypto/blob/master/fiat-c/src/p256_64.c)
  field arithmetic, with curve operations in
  [HACL\* ecdsap256](https://github.com/hacl-star/hacl-star/tree/main/code/ecdsap256)

### Post-quantum cryptography (NIST standards)

- **ML-KEM** (CRYSTALS-Kyber): Formally verified in
  **[libcrux](https://github.com/cryspen/libcrux/tree/main/libcrux-ml-kem)**
  (Cryspen), with F\* functional correctness proofs and constant-time
  verification.
  [First formally verified ML-KEM implementation](https://cryspen.com/post/ml-kem-verification/).
- **ML-DSA** (CRYSTALS-Dilithium): Verification work underway in
  [libcrux](https://github.com/cryspen/libcrux/tree/main/libcrux-ml-dsa) and
  PQShield toolchains
- **SLH-DSA** (SPHINCS+):
  [reference implementation](https://github.com/sphincs/sphincsplus); hash-based
  signature, stateless and conservatively designed
- **FN-DSA** (FALCON): [reference implementation](https://falcon-sign.info/);
  lattice-based, verification work ongoing

### Protocols

- **TLS 1.3**: Formally analyzed with
  [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)
  (computational) and [Tamarin](https://tamarin-prover.com/) (symbolic);
  implementation verification in
  [miTLS](https://github.com/project-everest/mitls-fstar)
- **Signal Protocol**: Formally analyzed with
  [CryptoVerif](https://eprint.iacr.org/2016/1013); shown to meet forward
  secrecy and break-in recovery
- **WireGuard**:
  [formally analyzed with Tamarin and ProVerif](https://www.wireguard.com/papers/wireguard-formal-verification.pdf);
  Noise protocol framework verified
- **SSH**: Analyzed with
  [ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/); various
  implementation audits

---

## Countries

High assurance cryptography research and engineering is concentrated in a
handful of countries, driven by a combination of academic tradition, government
funding, and industrial demand.

### France

France has the densest concentration of formal cryptographic verification
research globally. **INRIA** funds and houses multiple teams directly engaged in
verified cryptography. The **[ANSSI](https://www.ssi.gouv.fr/)** (Agence
nationale de la sécurité des systèmes d'information) sets technical standards
for cryptographic products used by the French government and publishes reference
documentation on acceptable algorithms. ANSSI has contributed to the
[French post-quantum cryptography roadmap](https://cyber.gouv.fr/en/publications/follow-position-paper-post-quantum-cryptography)
and requires formal security evaluations under
[Common Criteria](https://www.commoncriteriaportal.org/) for high-security
products.

Key organizations: INRIA (Prosecco, CASCADE teams), IRIF (Paris), Cryspen
(distributed, INRIA spinout), Symbolic Software, LIP6 (Sorbonne).

### United States

The US has the largest industry concentration. NIST drives global standards
(SHA-3, AES, the PQC standardization process). Defense and intelligence agencies
fund verification research through DARPA (programs like
**[HACMS](https://www.darpa.mil/program/high-assurance-cyber-military-systems)**
-- High Assurance Cyber Military Systems) and the NSA's
**[Commercial National Security Algorithm Suite](https://www.nsa.gov/Resources/Commercial-Solutions-for-Classified-Program/)**
(CNSA 2.0), which mandates post-quantum cryptography for classified systems
by 2030.

Key organizations: Galois (Portland), Trail of Bits (New York), Amazon Web
Services (Seattle), Google Security (Mountain View), Microsoft Research
(Redmond), MIT CSAIL (Boston), CMU CyLab (Pittsburgh).

### United Kingdom

The UK's **[NCSC](https://www.ncsc.gov.uk/)** (National Cyber Security Centre)
publishes cryptographic guidance and has engaged formally with post-quantum
transition planning. **PQShield** is headquartered in Oxford and has been active
in NIST PQC standardization and formal verification of lattice-based schemes.
**ARM** (Cambridge) produces cryptographic acceleration hardware widely used in
formally verified software stacks.

Key organizations: NCSC, PQShield (Oxford), NCC Group (Manchester), Nomadic Labs
(distributed), Royal Holloway University of London.

### Germany

**BSI** (Bundesamt für Sicherheit in der Informationstechnik) is Germany's
federal cybersecurity authority and one of the most technically rigorous
national security agencies in Europe. The BSI has co-developed
**[XMSS](https://www.bsi.bund.de/EN/Themen/Unternehmen-und-Organisationen/Informationen-und-Empfehlungen/Quantentechnologien-und-Post-Quanten-Kryptografie/quantentechnologien-und-post-quanten-kryptografie_node.html)**
(a stateful hash-based signature adopted by NIST and RFC 8391) and published
guidance recommending formally verified implementations for critical systems.

Key organizations: BSI, KIT (Karlsruhe Institute of Technology), TU Darmstadt
(Cryptoplexity group), Cryspen (distributed), Cure53 (Berlin).

### Netherlands

The Netherlands has produced significant cryptographic theory (CWI, TU/e) and
verification work. The **[Radboud University](https://www.ru.nl/en)** group
(Bernstein, Lange, and colleagues) produced Curve25519, Ed25519, and
SPHINCS/SPHINCS+. **[TU/e (Eindhoven)](https://www.tue.nl/)** is home to leading
public-key cryptography researchers.

Key organizations: CWI (Amsterdam), Radboud University (Nijmegen), TU/e
(Eindhoven).

### Switzerland

**ETH Zurich** runs the
**[CryptHOL](https://www.isa-afp.org/entries/CryptHOL.html)** framework for
machine-checked computational security proofs in Isabelle/HOL and the
**[Prusti](https://github.com/viperproject/prusti-dev)** verifier for Rust
programs. **EPFL** (Lausanne) has a cryptography and security lab with active
formal verification contributions.

Key organizations: ETH Zurich, EPFL, University of Bern.

### Spain

**IMDEA Software Institute** (Madrid) developed both **EasyCrypt** and
**Jasmin** -- two of the most important tools in the high assurance cryptography
toolchain.

Key organizations: IMDEA Software (Madrid), UPM (Universidad Politécnica de
Madrid).

### Belgium

**KU Leuven** (Leuven) is home to the COSIC research group (Computer Security
and Industrial Cryptography), one of the most productive cryptographic research
groups in the world. COSIC designed **AES** (Rijndael), led the **SHA-3**
competition candidate Keccak, and is deeply involved in post-quantum
standardization.

Key organizations: KU Leuven COSIC, UCLouvain.

### Japan

**[CRYPTREC](https://www.cryptrec.go.jp/en/)** is Japan's government-run
cryptographic evaluation project, producing the list of ciphers approved for use
in Japanese e-government applications. NTT and NEC have strong cryptographic
research divisions with contributions to lattice-based cryptography and protocol
verification.

Key organizations: CRYPTREC, NTT Research (also active in USA), NEC, Tohoku
University.

---

## Why this matters now

Three forces are converging to make high assurance cryptography urgent:

**Post-quantum migration**: NIST finalized ML-KEM, ML-DSA, and SLH-DSA in 2024.
Every TLS stack, VPN, secure messaging app, and HSM on the planet must be
updated. The window for introducing implementation bugs is large. Formally
verified implementations reduce that risk.

**Regulatory pressure**: The EU's
[Cyber Resilience Act](https://digital-strategy.ec.europa.eu/en/policies/cyber-resilience-act)
and DORA (Digital Operational Resilience Act) impose liability for software
vulnerabilities. NIST's
[Secure Software Development Framework](https://csrc.nist.gov/projects/ssdf) and
the US Executive Order on Cybersecurity (2021) push toward formal verification
for high-risk software.

**Hardware proliferation**: Cryptographic operations are moving into enclaves,
trusted execution environments, and dedicated accelerators. Bugs in these
environments are extraordinarily hard to patch. Formally verified cryptographic
primitives for hardware are an active research and product area.

---

## Further reading

### Libraries and tools

- [HACL\* -- High Assurance Cryptographic Library](https://hacl-star.github.io/)
- [EverCrypt -- formally verified cryptographic provider](https://project-everest.github.io/)
- [libcrux -- verified cryptography by Cryspen](https://github.com/cryspen/libcrux)
- [Fiat-Crypto -- verified field arithmetic](https://github.com/mit-plv/fiat-crypto)
- [s2n-tls -- AWS TLS with formal proofs](https://github.com/aws/s2n-tls)
- [Jasmin language](https://github.com/jasmin-lang/jasmin)
- [EasyCrypt](https://www.easycrypt.info/)
- [CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)
- [SAW -- Software Analysis Workbench](https://saw.galois.com/)
- [Cryptol](https://cryptol.net/)

### Post-quantum

- [NIST PQC Standards -- ML-KEM, ML-DSA, SLH-DSA](https://csrc.nist.gov/pqc-standardization)
- [CRYSTALS-Kyber specification](https://pq-crystals.org/kyber/)
- [First formally verified ML-KEM (Cryspen, 2024)](https://cryspen.com/post/ml-kem-verification/)
- [ANSSI post-quantum transition views](https://cyber.gouv.fr/en/publications/follow-position-paper-post-quantum-cryptography)
- [BSI post-quantum cryptography guidance](https://www.bsi.bund.de/EN/Themen/Unternehmen-und-Organisationen/Informationen-und-Empfehlungen/Quantentechnologien-und-Post-Quanten-Kryptografie/quantentechnologien-und-post-quanten-kryptografie_node.html)

### Formal verification of protocols

- [CryptoVerif proofs of TLS 1.3](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)
- [Tamarin prover -- formal protocol analysis](https://tamarin-prover.com/)
- [ProVerif -- automatic cryptographic protocol verifier](https://bblanche.gitlabpages.inria.fr/proverif/)
- [Formal analysis of Signal Protocol](https://eprint.iacr.org/2016/1013)
- [Formal analysis of WireGuard](https://www.wireguard.com/papers/wireguard-formal-verification.pdf)

### Regulatory

- [EU Cyber Resilience Act](https://digital-strategy.ec.europa.eu/en/policies/cyber-resilience-act)
- [NIST Secure Software Development Framework (SSDF)](https://csrc.nist.gov/projects/ssdf)
- [NSA CNSA 2.0 -- post-quantum migration timeline](https://media.defense.gov/2022/Sep/07/2003071236/-1/-1/0/CSA_CNSA_2.0_ALGORITHMS_.PDF)
- [DARPA HACMS program](https://www.darpa.mil/program/high-assurance-cyber-military-systems)
