# Research notes: Funding Bitcoin development

Working scratchpad for the long-form essay on how Bitcoin protocol development
is funded. Numbers/dates here are cross-checked against multiple sources before
they land in the final piece.

## Primary source

- 1A1z report — "Building Bitcoin: Funding a $1.2 Trillion Dollar Project", Part
  1, Dan O'Prey and Mas Nakachi, published October 2024. Landing page:
  https://1a1z.com/fund.html Twitter announcement:
  https://x.com/1A1zBTC/status/1848845545714098311 (The PDF is large — relied on
  secondary summaries plus original numbers cross-confirmed across sources.)

## Headline 1A1z numbers (cross-confirmed)

- **$8.4M** = total funding flowing to Bitcoin Core development in 2023
  (nobsbitcoin.com 2024-10; Bitget 2024; Chaincatcher 2024).
- **41 active core developers** (≥5 merged commits in the year leading up to
  October 2024).
- **5 maintainers** at time of report. As of January 2026 there are 6
  (sedited/TheCharlatan added Jan 8–9, 2026)
  https://insider.btcpp.dev/p/bitcoin-core-adds-new-maintainer
- **13 funding organizations** that either directly employ Core devs or run a
  continuous grant program for Core devs: Blockstream, Chaincode Labs, MIT DCI,
  Spiral (ex-Square Crypto), OKX, HRF, Brink, Btrust, OpenSats, Vinteum,
  Maelstrom, B4OS, 2140. Of these: 5 privately funded, 8 donation-dependent.

## Comparison figures

- **Ethereum Foundation 2023**: $134.9M total spend; $32.1M (30%) to layer-1 R&D
  — described as the "core development" line item. Source: EF 2024 report;
  Cointelegraph 2024-08; Vitalik breakdown
  https://cointelegraph.com/news/vitalik-buterin-breakdown-2023-ethereum-foundation-spending
- **EF 2024**: roughly $100M budgeted; treasury $970M.
- **Polkadot / Web3 Foundation**: $45M Decentralized Futures Program announced
  Nov 2023 (20M USD + 5M DOT). H1 2024 spend ~$87M total, with ~$16.8M
  classified as Bitcoin-Core-equivalent.
- **Meta**: ~20,000 engineers at comparable market cap (~$1.5T in 2023).

## Geographic distribution (1A1z, October 2024)

By head-count (33 of 41 disclose location):

- US: 11
- UK: 7
- Netherlands: 2
- Switzerland: 2
- India: 1
- Nigeria: 1
- China: 0

By commit share:

- Europe: 56%
- US: 25%
- UK alone: 30%
- Asia + Africa + Australia combined: <10%
- A single Swedish developer ≈ half of all US contributions combined.

Contribution concentration:

- Top 15 devs = 71% of contributions
- Top 5 devs = 41%
- Top 1 dev = 11%

## Maintainer concentration

- 5 maintainers at the time of the 1A1z report (Oct 2024): Marco Falke /
  fanquake (promoted 2016), Hennadii Stepanov / hebasto (2021), Ava Chow /
  achow101 (2021), Gloria Zhao / glozow (2022), Ryan Ofsky / ryanofsky (2023).
- fanquake handles ~65% of all merges. If he departs, throughput drops ~65%
  immediately ("Brink risk"). Source: GitHub issue bitcoin/bitcoin#35055
  (apparently empty body now but referenced widely); Bitcoinmagazine maintainer
  history.
- Of the last four maintainer promotions, employer concentration: Chaincode Labs
  (Ofsky), Brink (Zhao at the time), Blockstream/contract, OpenSats-supported.
  The lineage is tight.
- Jan 2026: sedited/TheCharlatan added — first new maintainer in 3 years.
  University of Zurich CS grad from South Africa, focus on reproducibility +
  validation logic. https://insider.btcpp.dev/p/bitcoin-core-adds-new-maintainer

## Historical timeline

### Phase 1 — Satoshi → Andresen (2008–2012)

- Satoshi releases 0.1 Jan 2009. Gavin Andresen becomes de facto lead by 2010,
  formally designated when Satoshi steps back Dec 2010.
- No funding infrastructure. Volunteer model.

### Phase 2 — Bitcoin Foundation (2012–2015)

- Founded Sept 2012. Peter Vessenes chair. Andresen hired as chief scientist
  (salary: $15K in 2012 → $147,917 in 2014).
- 2013: California DFI cease-and-desist for operating as unlicensed money
  transmitter.
- Jan 2014: VC Charlie Shrem arrested (Silk Road connection).
- Mark Karpeles of Mt. Gox on board.
- July 2015: Olivier Janssens publicly reveals foundation near insolvency, staff
  layoffs.
- Effectively defunct by end of 2015.
  https://en.wikipedia.org/wiki/Bitcoin_Foundation

### Phase 3 — MIT DCI rescue (2015–2019)

- Joi Ito launches MIT Digital Currency Initiative in 2015.
- DCI funds salaries of Wladimir van der Laan (lead maintainer from April 2014),
  Gavin Andresen, Cory Fields.
- Epstein donations to MIT 2002–2017 totaled $850K of which $525K earmarked for
  DCI per House Oversight Committee documents released Feb 2026. Ito resigned
  September 2019 after Epstein link surfaced.
  https://genfinity.io/2026/02/02/epstein-documents-bitcoin-core-mit-funding/
  https://www.dlnews.com/articles/people-culture/epstein-files-reveal-desire-to-steer-bitcoin-via-its-developers/
- Devs have publicly said they were unaware at the time and that the funding
  carried no technical conditions.

### Phase 4 — Grant explosion (2019–2022)

- 2014: Blockstream founded by Maxwell, Wuille, Corallo, Timón, Friedenbach,
  Back, Hill. Raised $21M seed, $55M Series A. Through 0.12.0rc1, Blockstream
  devs authored ~500/2185 commits (>23%).
- 2014: Chaincode Labs founded by Alex Morcos & Suhas Daftuar (both ex-Hudson
  River Trading).
- 2019: Square Crypto launched by Dorsey. Renames to Spiral Dec 2021.
- 2019: Okcoin (later OKX) launches Open Source Developer Grant Program, $1.5M+
  cumulative.
- Nov 2020: Brink founded by John Newbery + Mike Schmidt. Seed from John
  Pfeffer + Wences Casares. First fellows funded by HRF, Square Crypto, Gemini;
  first grant $150K from Kraken.
- May 2020: HRF Bitcoin Development Fund launched.
- 2020: OpenSats founded (501(c)(3) EIN 85-2722249 — incorporated 2020).
- Feb 2021: Btrust announced — 500 BTC (~$21.5M at the time) committed by
  Dorsey + Jay-Z, "blind irrevocable trust", Africa+India focus.

### Phase 5 — Maturation & geographic diversification (2022–2026)

- Aug 2022: Vinteum founded by Lucas Ferreira + André Neves (Brazil). First
  grantee: Bruno Garcia.
- 2023: Dec 2023 Dorsey #startsmall gives $21M to OpenSats ($15M General Fund,
  $5M Nostr Fund, $1M ops).
- Jan 2024: VanEck pledges 5% of spot ETF profits to Brink for 10 yrs, plus
  immediate $10K donation.
- Feb 2024: Coinbase GiveCrypto donates $3.6M to Brink (Coinbase wound down
  GiveCrypto, distributed remaining funds).
- 2024: Maelstrom (Arthur Hayes family office) launches Bitcoin Grant Program
  ($50K–$150K, 12-month, BTC/USDC/USDT).
- Sept 2024: Btrust acquires Qala (Nigerian dev training firm); becomes Btrust
  Builders Programme. Khalil (Nigerian Core dev) appointed interim CEO.
- Oct 2024: 1A1z report.
- 2025: OKX provides multi-year grant to launch 2140 Foundation (Amsterdam,
  co-founded by Josie Baker + Ruben Somsen).
- Jul 23, 2025: Payjoin Foundation receives 501(c)(3) status.
- Aug 2025: B4OS (Bitcoin 4 Open Source) — Btrust-backed senior dev training;
  provides micro-grants to 21 devs + 5 educators + 3 UI/UX. Latin-American
  focused, run via Librería de Satoshi.
- Oct 2025: Tether donates $250K to OpenSats (Dorsey publicly prods Tether for
  the small size: "Only $250K?").
- Nov 2025: Quarkslab audit publishes — first public third-party audit of
  Bitcoin Core. 100 man-days, May–Sept 2025. Funded by Brink, coordinated by
  OSTIF. No critical/high/medium-severity findings; 2 low + 13 informational.
  Technical liaison: Niklas Gögge (Brink), Antoine Poinsot (Chaincode).
  https://blog.quarkslab.com/bitcoin-core-audit.html
  https://brink.dev/blog/2025/11/19/bitcoin-core-security-audit/
- Jan 8–9, 2026: sedited/TheCharlatan made 6th Bitcoin Core maintainer.

## The 13 organizations — detailed

### Corporate employers (5)

1. **Blockstream** (2014, BC/Canada+global). Founders: Maxwell, Wuille, Corallo,
   Timón, Friedenbach + Back, Hill. $21M seed, $55M Series A. Adam Back CEO.
   Employs/contracted: Wuille, Sanders, Strateman, Willen, Dashjr (contract).
   Authored ~23% of commits through 0.12.0rc1. Business model: Liquid sidechain,
   satellite, mining. https://en.wikipedia.org/wiki/Blockstream
2. **Chaincode Labs** (2014, NYC). Founders: Alex Morcos + Suhas Daftuar.
   Self-funded by HRT money. Employs senior contributors (e.g. Marco Falke /
   fanquake at points, John Newbery before Brink, Murch, ryanofsky, Russell
   O'Connor, Antoine Poinsot/darosior). Runs Chaincode Seminars / Residency /
   BOSS program. https://chaincode.com/about
3. **MIT DCI** (2015). Launched by Joi Ito under MIT Media Lab. Funded Wladimir
   van der Laan, Gavin Andresen, Cory Fields. Bear market 2022 shrunk MIT's $8M
   commitment from 2021 considerably.
4. **Spiral** (2019 as Square Crypto, rebranded Dec 2021). Block, Inc.
   subsidiary. Funds LDK, BDK, Bitcoin Design. 30+ developers/designers across
   18+ countries. Employment + grants hybrid.
   https://spiral.xyz/blog/square-crypto-grants-for-everybody/
5. **OKX (Okcoin Developer Grant Program)**. Started 2019 under Okcoin; OKX
   joined 2022. >$1.5M cumulative. Lennix Lai & Hong Fang drive it. Funds Marco
   Falke, Amiti Uttarwar, Dusty Daemon (Splicing/LN). Multi-year initial grant
   to seed 2140.
   https://www.okx.com/learn/okx-okcoin-developer-grant-program-award-bitcoin-developer-dusty-daemon

### Non-profit / grant orgs (8)

6. **HRF Bitcoin Development Fund** (May 2020). Alex Gladstein, CSO. $8.5M+ in
   BTC across nearly 300 projects in 62 countries. Quarterly grant rounds (sept
   2023 = 15 projects; April 2026 = 1.5B sats). Frame: human-rights tooling,
   privacy, usability.
7. **Brink** (Nov 2020). John Newbery + Mike Schmidt. 100% donations. Donors:
   Pfeffer, Casares, Dorsey (~14.2%), Gemini, Bitfinex, Kraken, Coinbase ($3.6M
   Feb 2024), VanEck (5% ETF pledge, Jan 2024). 2022 donations −58% YoY (bear
   market). Funds 8 engineers per 2025 impact report. Funded the Quarkslab
   audit.
   https://www.coindesk.com/business/2024/01/05/vaneck-to-donate-5-of-profits-from-btc-etf-to-bitcoin-core-developers
8. **OpenSats** (2020/2021 incorporated; major activity from 2022). 501(c)(3).
   LTS grants for Core devs (Marco Falke, Josi Baker, Sjors Provoost, Vasil
   Dimov, Will Clark, 0xB10C, Bruno Garcia). Total allocated ~$27.4M to ~319
   grantees in 32+ countries. 2024: $23.6M donations received, $12M+ from
   General Fund + $9M+ from Nostr Fund disbursed. Top donor Dorsey #startsmall =
   90.5% of inflows ($21M Dec 2023). Sends ~$1M/mo in BTC.
   https://opensats.org/blog/2024-year-in-review
9. **Btrust** (Feb 2021). 500 BTC (~$21.5M) Dorsey+Jay-Z, blind trust.
   Africa+India focus. Acquired Qala Sept 2023. Abubakar Nur Khalil interim CEO
   Sept 2024. 2025: $1M+ in event/education grants.
10. **Vinteum** (Aug 2022). Brazil. Founders: Lucas Ferreira (LN Labs), André
    Neves (Zebedee). Sponsors: Pfeffer, Casares, Sebastian Serrano (Ripio),
    Okcoin, HRF. First grantee Bruno Garcia.
    https://medium.com/vinteum-org/announcing-vinteum-supporting-bitcoin-development-in-brazil-bb74559ef164
11. **Maelstrom** (2024). Arthur Hayes family office. $50K–$150K x 12mo. Admin'd
    by Jonathan Bier (ex-BitMEX OSS). Recipients: rkrux (1st), Ben Allen ($100K
    Payjoin), macgyver13/Ron (4th, Silent Payments). Focus: privacy + censorship
    resistance.
12. **2140 Foundation** (2025). Amsterdam. Co-founders Josie Baker
    - Ruben Somsen. Seed: multi-year OKX grant. Office-based employment model
      for protocol veterans. "Think in years not months."
      https://www.nobsbitcoin.com/2140-foundation-launched-to-support-open-source-bitcoin-development/
13. **B4OS** (Bitcoin 4 Open Source, 2024+). Btrust-backed. Run via Librería de
    Satoshi. Spanish-speaking Latin-America focus. Senior dev mentorship +
    micro-grants. Not directly employing Core devs but feeds the pipeline.

## The "Dorsey Problem"

- OpenSats: 90.5% of donations from Dorsey #startsmall
- Brink: 14.2% Dorsey
- Btrust: 100% Dorsey + Jay-Z
- Spiral: Block subsidiary, Dorsey is Block CEO

One man directly or indirectly influences more than half of all funding to
Bitcoin Core. Despite this, Dorsey publicly does not interfere with technical
direction (per 1A1z report and multiple journalists).

Sustainability red flag from 1A1z: 2022 bear market caused MIT DCI's 2021
commitment to shrink and Brink donations to fall 58% YoY.

## Privacy funding sub-question (for teaser)

- No dedicated privacy foundation in Bitcoin until Payjoin Foundation (501(c)(3)
  Jul 23, 2025).
- Maelstrom is the closest thing — explicit privacy-tool mandate, funds Payjoin
  (Ben Allen) + Silent Payments (macgyver13).
- HRF funds privacy through human-rights lens (dissident tooling).
- Spiral funds LN-adjacent privacy (LDK/BDK).
- No equivalent to Shielded Labs / Electric Coin Co / Zcash Foundation.
- No protocol-level privacy mandate.

## Recent funding events table

| Date          | Event                                    | Amount          |
| ------------- | ---------------------------------------- | --------------- |
| Jan 2024      | VanEck 5% ETF pledge to Brink, 10-yr     | + $10K initial  |
| Feb 2024      | Coinbase GiveCrypto → Brink              | $3.6M           |
| Dec 2023      | Dorsey #startsmall → OpenSats            | $21M            |
| 2024          | Maelstrom Bitcoin Grant Program launched | Up to ~$250K/yr |
| Sept 2024     | Btrust acquires Qala                     | (acquisition)   |
| Oct 2024      | 1A1z report published                    | —               |
| Jul 23, 2025  | Payjoin Foundation 501(c)(3)             | —               |
| Oct 2025      | Tether → OpenSats                        | $250K           |
| Nov 2025      | Quarkslab Bitcoin Core audit published   | (Brink-funded)  |
| Jan 8–9, 2026 | sedited/TheCharlatan → 6th maintainer    | —               |
| Apr 2026      | HRF BDF round                            | 1.5B sats       |

## Key URLs (consolidated for citation)

- 1A1z: https://1a1z.com/fund.html and
  https://x.com/1A1zBTC/status/1848845545714098311
- nobsbitcoin coverage:
  https://www.nobsbitcoin.com/bitcoin-core-development-funded-with-8-4m-in-2023-report/
- chaincatcher synthesis: https://www.chaincatcher.com/en/article/2227383
- Brink VanEck:
  https://www.coindesk.com/business/2024/01/05/vaneck-to-donate-5-of-profits-from-btc-etf-to-bitcoin-core-developers
- Brink Coinbase:
  https://www.theblock.co/post/277882/coinbase-donates-3-6-million-to-support-bitcoin-developer-funding-through-brink
- Quarkslab audit: https://blog.quarkslab.com/bitcoin-core-audit.html
- Brink security audit post:
  https://brink.dev/blog/2025/11/19/bitcoin-core-security-audit/
- Vinteum:
  https://bitcoinmagazine.com/business/vinteum-to-fund-bitcoin-developers-in-brazil
- Btrust+Qala:
  https://unchainedcrypto.com/jack-dorsey-jay-z-btrust-acquires-bitcoin-qala/
- Payjoin Foundation:
  https://bitcoinmagazine.com/business/payjoin-foundation-gains-501c3-status-enabling-tax-deductible-donations-for-bitcoin-privacy-development
- Maelstrom Bitcoin Grant:
  https://www.theblock.co/post/305798/arthur-hayes-maelstrom-bitcoin-developer-grant-program
- Maelstrom Payjoin:
  https://cointelegraph.com/news/bitcoin-payjoin-privacy-grant-maelstrom
- 2140:
  https://www.nobsbitcoin.com/2140-foundation-launched-to-support-open-source-bitcoin-development/
- OpenSats 2024 year in review: https://opensats.org/blog/2024-year-in-review
- OpenSats LTS:
  https://opensats.org/blog/announcing-lts-grant-program-to-support-bitcoin-core-contributors
- Dorsey $21M to OpenSats:
  https://www.tftc.io/jack-dorseys-startsmall-donates-21-million-opensats/
- Tether $250K to OpenSats:
  https://tether.io/news/tether-donates-250000-to-opensats-to-strengthen-free-and-open-source-ecosystems-supporting-bitcoin-and-freedom-tech/
- Bitcoin Foundation history: https://en.wikipedia.org/wiki/Bitcoin_Foundation
- Wladimir van der Laan / MIT DCI:
  https://www.weusecoins.com/wladimir-van-der-laan/
- Epstein/DCI documents:
  https://genfinity.io/2026/02/02/epstein-documents-bitcoin-core-mit-funding/
  and
  https://www.dlnews.com/articles/people-culture/epstein-files-reveal-desire-to-steer-bitcoin-via-its-developers/
- sedited/TheCharlatan:
  https://insider.btcpp.dev/p/bitcoin-core-adds-new-maintainer
- HRF BDF: https://hrf.org/program/financial-freedom/bitcoin-development-fund/
- EF 2023 breakdown:
  https://cointelegraph.com/news/vitalik-buterin-breakdown-2023-ethereum-foundation-spending
- Web3 Foundation Decentralized Futures:
  https://web3.foundation/press/w3f-launches-decentralized-futures-program/

## Open questions / things still to verify

- Exact Spiral cumulative grant total (sources say >$1.5M Okcoin path but
  Spiral's own number not published cleanly; flag as estimate).
- Exact HRF BDF cumulative — sources say "$8.5M+" (HRF page).
- 2140 grant amount from OKX — "multi-year" but no public figure; flag as
  estimate.
- "Brink 58% drop" specifically — attributed to 1A1z; only the 1A1z derivative
  summaries carry this number. Treat as 1A1z-original.
- The Joi Ito/Epstein angle is now well-sourced (House Oversight docs Feb 2026),
  safe to include with care.
