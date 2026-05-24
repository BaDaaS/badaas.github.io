---
title:
  "Who pays for Bitcoin: a structural account of how protocol-level development
  is funded"
description:
  "A long-form analytical look at how Bitcoin Core development is funded across
  its 13-organisation ecosystem: $8.4M for 41 developers and 5 maintainers
  maintaining a $1.7T network, the Dorsey Problem, the fanquake bottleneck,
  geographic asymmetry, and the 2024–2026 shift."
pubDate: 2026-05-24
tags:
  [
    "bitcoin",
    "funding",
    "open-source",
    "governance",
    "cryptography",
    "ecosystem",
  ]
---

<div class="note-box">

_This article was researched and drafted with the assistance of Claude Opus 4.7.
Numbers and dates were cross-checked against multiple sources, but the original
1A1z report PDF (the primary source) was not directly fetchable at draft time
and figures rely on secondary summaries. If you spot a factual error or want to
point to a missing source, please [contact us](mailto:danny@badaas.be) or
[open an issue](https://github.com/BaDaaS/badaas.github.io/issues)._

</div>

## Executive summary

- In 2023 the entire Bitcoin Core development effort ran on roughly **$8.4M**,
  supporting **41 active developers** and **5 maintainers**. At the time, the
  network's market cap sat near **$1.2T**; by mid-2025 it had passed **$1.7T**.
  The Ethereum Foundation alone spent **$32.1M** on layer-1 R&D the same year,
  against a $134.9M total budget. Polkadot's Web3 Foundation moved comparable
  amounts.
- Funding is distributed across **13 organisations** identified by the 1A1z
  report (Oct 2024). Five are corporate employers (Blockstream, Chaincode Labs,
  MIT DCI, Spiral, OKX) and eight are grant non-profits (HRF BDF, Brink,
  OpenSats, Btrust, Vinteum, Maelstrom, 2140, B4OS). None is a foundation in the
  Ethereum-Foundation sense, and Bitcoin has had no central treasury since the
  collapse of the Bitcoin Foundation in 2015.
- One donor — Jack Dorsey, through **#startsmall**, **Block/Spiral** and the
  **Btrust** endowment — directly or indirectly accounts for more than half of
  all dollars flowing to Bitcoin Core, including **90.5%** of OpenSats inflows
  and **14.2%** of Brink donations. The 1A1z report calls this the **Dorsey
  Problem**.
- Maintainer concentration is sharper than the donor problem. **fanquake
  (Michael Ford)** merges about **65%** of all pull requests; the maintainer
  cohort sat at 5 from 2023 to early 2026, and the most recent additions came
  from a tight set of organisations. The first new maintainer in three years —
  **sedited / TheCharlatan** — was added on **8 January 2026**.
- The 2024–2026 window has visibly hardened the funding base — VanEck's 10-year
  ETF pledge to Brink, Coinbase's $3.6M wind-down gift, Tether's $250K to
  OpenSats, the OKX-seeded 2140 Foundation in Amsterdam, the Maelstrom grant
  programme, and the Payjoin Foundation's July 2025 501(c)(3) status — without
  resolving the bus-factor or the donor-concentration problem.

---

## The paradox in numbers

Bitcoin's protocol is maintained by an effort that, by every quantitative
measure, would not survive a corporate quarterly review. In 2023, the entire
global expenditure on Bitcoin Core development was **$8.4M**
([1A1z, October 2024](https://1a1z.com/fund.html);
[nobsbitcoin, 2024](https://www.nobsbitcoin.com/bitcoin-core-development-funded-with-8-4m-in-2023-report/)).
That figure paid for **41 active core developers** — defined as contributors
with at least five merged commits in the trailing year — and the **5
individuals** then holding merge authority. The network those people maintain
settled, in the same year, more dollar value than the GDP of Switzerland.

The contrast hardens when set against directly comparable peers. The Ethereum
Foundation spent **$134.9M** in 2023, of which **$32.1M (30%)** was allocated
specifically to "Layer 1 R&D" — the line item that maps onto what Bitcoin Core
developers do
([Cointelegraph, August 2024](https://cointelegraph.com/news/vitalik-buterin-breakdown-2023-ethereum-foundation-spending)).
The Web3 Foundation, whose underlying network has roughly one percent of
Bitcoin's market capitalisation, allocated $45M to its Decentralised Futures
programme alone in late 2023
([Web3 Foundation, November 2023](https://web3.foundation/press/w3f-launches-decentralized-futures-program/)),
with the protocol-equivalent line item estimated at ~$16.8M for H1 2024. At the
company level, Meta — comparable in market cap to Bitcoin in 2023 — employed
roughly **20,000 engineers**. Bitcoin's core team is smaller than the platform
engineering org of a mid-sized SaaS company.

This is not a deficit being papered over by hidden capital. There is no Bitcoin
Foundation, no consensus-bearing non-profit, no validator inflation routed back
to developers, no protocol treasury and no on-chain bounty mechanism. The 1A1z
report by Dan O'Prey and Mas Nakachi — the first systematic accounting of the
question — calls the structural answer "remarkable resilience under chronic
under-investment." A senior engineer reading the same numbers might phrase it
differently: Bitcoin's anti-fragility thesis is being stress-tested in real time
against the bus factor of a handful of salaried Europeans.

## A short history of who paid the bills

Bitcoin's funding architecture has gone through five recognisable phases, each
shaped by the failure or limitation of the previous one.

The **Satoshi-to-Andresen period (2009–2012)** had no funding infrastructure at
all. Gavin Andresen became de facto lead maintainer when Satoshi stepped back in
late 2010, and the work was unpaid volunteer work in the open-source tradition.

The first attempt at institutionalisation, the **Bitcoin Foundation
(2012–2015)**, was both ambitious and badly designed. Founded in September 2012
with Peter Vessenes as chair, the Foundation hired Andresen as chief scientist
on a salary that grew from $15,000 in 2012 to $147,917 in 2014 according to
IRS-990 filings
([Wikipedia, Bitcoin Foundation](https://en.wikipedia.org/wiki/Bitcoin_Foundation)).
The organisation's collapse was a textbook case of governance failure under
regulatory and reputational pressure. In June 2013, the California Department of
Financial Institutions issued a cease-and-desist letter for operating as an
unlicensed money transmitter. In January 2014 vice-chair Charlie Shrem was
arrested for aiding a Silk Road money-transmitting operation; Mark Karpeles of
Mt. Gox sat on the same board. By July 2015 — when Olivier Janssens publicly
revealed the foundation was near insolvency — the institution was finished.
Bitcoin's first organised funder had managed roughly three productive years.

The vacuum was filled by the **MIT Digital Currency Initiative (2015–2019)**,
which became the academic refuge for Bitcoin Core during what could have been a
catastrophic interregnum. Joi Ito launched the DCI under the MIT Media Lab in
2015, funding the salaries of Wladimir van der Laan — who had taken over as lead
maintainer in April 2014 — along with Andresen and Cory Fields
([van der Laan profile, weusecoins](https://www.weusecoins.com/wladimir-van-der-laan/)).
That arrangement underwrote stable, university-style employment for the three
most consequential developers in the project at exactly the moment the
Foundation was disintegrating. It also turned out to have a darker dimension.
House Oversight Committee documents released in February 2026 show that Jeffrey
Epstein donated roughly **$525,000** to the DCI as part of an **$850,000** total
to MIT between 2002 and 2017, with email correspondence in which Ito thanked
Epstein for funds that "allowed us to move quickly and win this round" in
recruiting Bitcoin developers
([Genfinity, February 2026](https://genfinity.io/2026/02/02/epstein-documents-bitcoin-core-mit-funding/);
[DL News, 2026](https://www.dlnews.com/articles/people-culture/epstein-files-reveal-desire-to-steer-bitcoin-via-its-developers/)).
Ito resigned in September 2019 after the connection surfaced. Developers funded
through the line have said publicly they were unaware of the source and that the
funding carried no technical conditions; the structural point — that a
single-source academic sponsorship had unknown provenance — is independent of
any intention.

The next phase, **the grant explosion (2019–2022)**, replaced the
single-institution model with a diversified grant economy. Blockstream had
already been founded in 2014 by Gregory Maxwell, Pieter Wuille, Matt Corallo,
Jorge Timón and Mark Friedenbach alongside Adam Back and Austin Hill, raising
$21M in seed and $55M Series A; by version 0.12.0rc1, Blockstream developers had
authored roughly **23%** of all commits
([Wikipedia, Blockstream](https://en.wikipedia.org/wiki/Blockstream)). Chaincode
Labs, founded the same year in New York by ex-Hudson River Trading partners Alex
Morcos and Suhas Daftuar, took a quieter path: self-funded from trading capital,
employing senior contributors on salary, and running an in-house seminar that
eventually became the BOSS programme. But the explosion came on the grant side.
Square Crypto launched in 2019 under Jack Dorsey's Square, rebranding to Spiral
in December 2021. The Human Rights Foundation's Bitcoin Development Fund opened
in May 2020. OpenSats incorporated as a 501(c)(3) in 2020. Brink launched in
November 2020, founded by John Newbery and Mike Schmidt with seed capital from
John Pfeffer and Wences Casares
([CoinDesk, November 2020](https://www.coindesk.com/tech/2020/11/24/square-human-rights-foundation-back-new-bitcoin-open-source-developer-fund)).
In February 2021 Dorsey and Jay-Z committed 500 BTC — about $21.5M at the time —
to Btrust, a blind irrevocable trust focused on African and Indian developer
training.

The final phase, **maturation and geographic diversification (2022–2026)**, is
where the structure visible today actually settles. Vinteum was founded in
Brazil in August 2022 by Lucas Ferreira and André Neves
([Bitcoin Magazine, 2022](https://bitcoinmagazine.com/business/vinteum-to-fund-bitcoin-developers-in-brazil)).
The Maelstrom grant programme launched in 2024 under Arthur Hayes's family
office. OKX seeded the 2140 Foundation in Amsterdam in 2025. The Payjoin
Foundation received 501(c)(3) status on 23 July 2025. Coinbase wound down its
GiveCrypto programme in February 2024 and sent the remaining $3.6M to Brink;
VanEck pledged 5% of its spot Bitcoin ETF profits to Brink for ten years
([CoinDesk, January 2024](https://www.coindesk.com/business/2024/01/05/vaneck-to-donate-5-of-profits-from-btc-etf-to-bitcoin-core-developers)).
The structure has gone from one institution to thirteen in roughly a decade — a
slow, contested decentralisation that mirrors, at the funding layer, what the
protocol layer claims as its main political property.

## The thirteen organisations

The 1A1z report's main contribution is a clean taxonomy: it counts an
organisation only if it directly employs Bitcoin Core developers or runs a
continuous grant programme aimed at them. By that test, the field reduces to
thirteen entities — five corporate employers and eight grant non-profits — none
of which can dominate the other twelve on its own.

**Blockstream** is the largest single corporate sponsor by historical commit
count. Founded in 2014, it has employed or contracted Pieter Wuille, Gregory
Sanders, Patrick Strateman, Glenn Willen and Luke Dashjr at various points, and
its commercial business — the Liquid sidechain, satellite, and mining
infrastructure — subsidises the salary line on protocol contributors. Its
strategic role is to keep the most senior cryptographic talent on a payroll
structure that survives the market cycle.

**Chaincode Labs**, founded the same year by Alex Morcos and Suhas Daftuar, is
the most consequential employer of mid-career Core contributors. Funded out of
personal capital from a HFT background, it runs no commercial product — its sole
output is salaried contributor time and the Chaincode Seminars/Residency that
has trained a sizeable fraction of the post-2018 dev cohort. People employed or
hosted at Chaincode include Marco Falke, Ryan Ofsky, John Newbery (before
Brink), Russell O'Connor, Antoine Poinsot (darosior), and historically Murch.
The strategic position is quiet leverage: Chaincode does not advertise its
budget but underwrites a disproportionate share of senior review capacity.

**MIT DCI** remains the academic anchor and now the smallest of the
employer-type organisations by output. Its 2021 $8M multi-year commitment shrank
materially during the 2022 bear market per the 1A1z analysis, and the
Epstein-era reputational damage has constrained its visibility. It still employs
developers — and its research arm continues to publish on consensus protocol
theory — but it is no longer the gravitational centre of paid Core development.

**Spiral**, the rebranded Square Crypto, sits inside Block, Inc. as a
fully-funded subsidiary. Its core mandate is layered Bitcoin infrastructure: the
Lightning Development Kit (LDK), the Bitcoin Development Kit (BDK), Bitcoin
Design. Spiral describes its grant programme as supporting "over two dozen
developers and designers across more than 18 countries"
([Spiral blog](https://spiral.xyz/blog/square-crypto-grants-for-everybody/)).
The strategic role is hybrid: it employs salaried staff on Lightning and
adjacent infrastructure while running an externally-facing grant arm that funds
discrete Bitcoin contributors — closer to in-house R&D than to a pure
foundation.

**OKX** (operating as a continuation of Okcoin's grant programme, which OKX
joined in 2022) is the only exchange in the corporate-employer cohort. The
Okcoin Developer Grant Program launched in 2019 and has now disbursed more than
**$1.5M** cumulatively
([OKX, 2022](https://www.okx.com/learn/okx-okcoin-developer-grant-program-award-bitcoin-developer-dusty-daemon)).
It funds Marco Falke, Amiti Uttarwar, and Dusty Daemon (the latter working on
Lightning Splicing). OKX also provided the multi-year seed for the 2140
Foundation in Amsterdam in 2025.

On the non-profit side, **the Human Rights Foundation's Bitcoin Development
Fund** is the longest-running. Launched in May 2020 under Alex Gladstein, it has
distributed more than **$8.5M in BTC to nearly 300 projects across 62
countries**
([HRF Bitcoin Development Fund](https://hrf.org/program/financial-freedom/bitcoin-development-fund/)).
The grant cadence is roughly quarterly: a September 2023 round allocated $505K
across 15 projects with a stated focus on global education, Bitcoin Core, DLCs
on Lightning and e-cash; the most recent round in April 2026 disbursed 1.5
billion satoshis. The HRF's framing is the human-rights utility of the protocol
— which positions it as the natural funder of privacy and dissident tooling.

**Brink** is the closest thing to a dedicated Core-development endowment.
Founded in November 2020 by John Newbery and Mike Schmidt with seed capital from
John Pfeffer and Wences Casares, it operates on a fellowship model: long-running
stipends for engineers working specifically on protocol code. Its donor base is
the broadest in the ecosystem — Pfeffer, Casares, Dorsey (~14.2% of donations),
Gemini, Bitfinex, Kraken, Coinbase (which gave a one-time $3.6M in February 2024
when GiveCrypto wound down
([The Block, February 2024](https://www.theblock.co/post/277882/coinbase-donates-3-6-million-to-support-bitcoin-developer-funding-through-brink)))
and now VanEck, which in January 2024 pledged 5% of its spot Bitcoin ETF profits
to Brink for at least ten years. Brink also commissioned the first public
third-party security audit of Bitcoin Core, coordinated through OSTIF and
executed by Quarkslab between May and September 2025
([Quarkslab, November 2025](https://blog.quarkslab.com/bitcoin-core-audit.html)).
Brink supports eight engineers as of its 2025 impact report; donations fell
roughly **58% year-on-year** in 2022 with the bear market — a data point that
more than any other illustrates how thin the buffer is between
protocol-development funding and the cycle.

**OpenSats** is the largest non-profit in the ecosystem by dollar volume, but
also the most concentrated. Incorporated in 2020 as a 501(c)(3) and
operationally active from 2022, it has by end-2024 allocated approximately
**$27.4M to 319 grantees in 32+ countries**
([OpenSats 2024 year-in-review](https://opensats.org/blog/2024-year-in-review)).
In 2024 alone it received $23.6M in donations, of which a single gift — Jack
Dorsey's December 2023 #startsmall donation of $21M ($15M to the General Fund,
$5M to the Nostr Fund, $1M to operations) — accounted for roughly **90.5%**
([TFTC, December 2023](https://www.tftc.io/jack-dorseys-startsmall-donates-21-million-opensats/)).
OpenSats sends about $1M/month to grantees and runs a Long-Term Support
programme aimed at Core engineers; the current LTS roster includes Marco Falke,
Josi Baker, Sjors Provoost, Vasil Dimov, Will Clark, 0xB10C and Bruno Garcia.
The recent Tether donation of $250K in October 2025 — which Dorsey publicly
mocked as inadequate — is a useful indicator of how heavy the dependency on the
top donor still is.

**Btrust** sits structurally apart from the others. The 500 BTC ($21.5M at the
time) committed by Dorsey and Jay-Z in February 2021 constitute a blind
irrevocable trust governed by an independent African board — Obi Nwosu, Ojoma
Ochai, Abubakar Nur Khalil and Carla Kirk-Cohen — selected from over 7,000
applicants. In September 2023 it acquired Qala, a Nigerian Bitcoin-developer
training firm, folding it into the Btrust Builders Programme; in September 2024
Khalil, a Nigerian Bitcoin Core contributor, became interim CEO. Btrust's
strategic role is geographic and developmental: it is the only one of the
thirteen with an explicit mandate to grow the non-Western contributor base.

**Vinteum** plays the Brazilian counterpart role. Founded in August 2022 by
Lucas Ferreira (ex-Lightning Labs) and André Neves (Zebedee co-founder), it
operates with sponsorship from Pfeffer, Casares, Sebastian Serrano of Ripio,
Okcoin and HRF. Its first grantee was Bruno Garcia, who has since become a
productive Core contributor. Vinteum's curriculum is built on translated
Chaincode Seminars material, which makes it a structural client of the New York
institution as well as an independent organisation.

**Maelstrom**, Arthur Hayes's family office, entered the field in 2024 with a
grant programme administered by Jonathan Bier — who had previously run BitMEX's
open-source grants. Grants run **$50K to $150K** over twelve months in BTC, USDC
or USDT
([The Block, 2024](https://www.theblock.co/post/305798/arthur-hayes-maelstrom-bitcoin-developer-grant-program)).
Recipients to date include rkrux, Ben Allen (a $100K grant in 2024 for the
Payjoin Dev Kit
([Cointelegraph, 2024](https://cointelegraph.com/news/bitcoin-payjoin-privacy-grant-maelstrom))),
and "macgyver13" / Ron, who works on Silent Payments under BIP 352. Maelstrom's
mandate is the most privacy-explicit of the thirteen.

**The 2140 Foundation** is the youngest of the employer-type organisations.
Launched in 2025 in Amsterdam by Bitcoin Core contributors Josie Baker and Ruben
Somsen on a multi-year OKX seed grant, it offers something closer to a European
Chaincode: a physical office, employment that "enables developers to think in
years rather than months," and structured mentorship for incoming contributors
([nobsbitcoin, 2025](https://www.nobsbitcoin.com/2140-foundation-launched-to-support-open-source-bitcoin-development/)).
Its strategic role is geographic redundancy — putting a senior employer presence
in Europe to balance the New York and Bay-Area weight of Chaincode, Spiral, MIT
DCI and Brink.

**B4OS** — Bitcoin 4 Open Source — closes the list. Run via Librería de Satoshi
with Btrust backing, it is a senior-developer training programme for the
Spanish-speaking Latin American and Caribbean cohort. Its 21 micro-grants in the
most recent cycle do not directly fund Core merges; the pipeline justification
is upstream.

## Where the power actually sits

The funding map is broad enough to look healthy at first glance. The maintainer
map is not. From early 2023 through January 2026 the trusted-keys file in the
Bitcoin Core repository named exactly five people: Marco Falke (fanquake),
Hennadii Stepanov (hebasto), Ava Chow (achow101), Gloria Zhao (glozow) and Ryan
Ofsky (ryanofsky). Wladimir van der Laan, who had been lead maintainer since
April 2014, removed his own merge privileges in February 2023, completing a
delegation he had announced in January 2021. That left five individuals — none
of them with the "lead" honorific — sharing a merge authority that had been one
person's for nearly a decade.

Within those five, the distribution is sharper. fanquake handles about **65% of
all merges**
([Bitcoin Magazine maintainer history](https://bitcoinmagazine.com/print/the-core-issue-the-role-and-history-of-bitcoin-core-maintainers)).
This is the number that the 1A1z report and several follow-on analyses elevate
to a structural risk: if fanquake departs, merge throughput falls by
approximately that fraction overnight. The remaining four maintainers each carry
less than ten percent of merge volume individually, and they are distributed
across domain specialisations — wallet (achow101), networking, UI, build — which
means that the lost capacity is not interchangeable.

The first new maintainer in three years was added on 8 January 2026, when
sedited (operating publicly as TheCharlatan) was nominated by Gloria Zhao during
a regular bitcoin-core-dev IRC meeting and added to the trusted-keys file the
following day
([insider.btcpp.dev, January 2026](https://insider.btcpp.dev/p/bitcoin-core-adds-new-maintainer)).
TheCharlatan, a University of Zurich CS graduate from South Africa, focuses on
reproducibility and validation logic. The addition takes the cohort to six. It
also marks a small geographic widening — the first maintainer drawn primarily
from a non-US, non-UK, non-Dutch node of the ecosystem.

The economic point under this is that all four of the most recent maintainer
promotions traced back to just four sponsoring organisations: Chaincode Labs,
Brink, Blockstream-adjacent contract work, and OpenSats-backed long-term
support. That is not capture in any operational sense — these are people who
would be paid for their work regardless of which non-profit cut the cheque — but
the pipeline is narrow. The structural fact reads: a payroll problem at two or
three organisations during a bear-market quarter could plausibly arrive at a
maintainer's calendar before it reaches the press release.

## Donor concentration and the Dorsey problem

Behind the thirteen organisations sits a much smaller set of donors. Of those,
one — Jack Dorsey — is in a class by himself. The 1A1z report quantifies the
Dorsey footprint with unusual precision: **90.5%** of OpenSats donations
originate with Dorsey's #startsmall vehicle; **14.2%** of Brink's donations come
from Dorsey; **100%** of Btrust's endowment was put up by Dorsey and Jay-Z;
Spiral is a fully owned subsidiary of Block, of which Dorsey is CEO. By the
report's accounting, one individual directly or indirectly influences more than
half of the dollars flowing to Bitcoin Core development.

The qualifying observation is important and easy to misread. By every reported
account — and Dorsey himself is on record on this — the funding does not come
with technical conditions. OpenSats grant selection runs through its own
committee. Btrust is structured as a blind irrevocable trust, with the board
explicitly insulated from the original donors. Brink's selection process is run
by Newbery and Schmidt. Spiral's choice of LDK/BDK/Bitcoin Design priorities is
internal to the subsidiary. The Dorsey Problem is not a governance-capture
problem in the literal sense; it is a counterparty-risk problem. If a single
donor's commercial circumstances, regulatory exposure, personal calendar or
strategic priorities shift, the funding rails do not have an obvious redundancy
layer.

That this is more than a thought experiment is visible in the 2022 data. During
the bear market that year, Brink donations dropped roughly **58% year-on-year**
and MIT DCI's 2021 multi-year commitment shrank materially per the 1A1z
accounting. Dorsey's #startsmall flows are pegged to BTC-denominated assets;
when those prices halve, the dollar-equivalent grant capacity halves too. The
Tether donation in October 2025 — $250K to OpenSats, which Dorsey publicly
prodded Tether for being too small — captures the dynamic exactly. The runway is
large enough to absorb single drawdowns but thin enough that one of the most
prominent donors feels comfortable naming the second-largest stablecoin issuer
in public for the size of its cheque.

## The geographic question

A funding map that is dominated by US capital but produces output from Europe is
a structurally interesting object. The 1A1z report's counts, drawn from public
location disclosure for 33 of the 41 active developers, give: **11 in the US, 7
in the UK, 2 in the Netherlands, 2 in Switzerland, 1 in India, 1 in Nigeria, 0
in China**. On commit share — a more direct measure of actual code shipped — the
picture inverts: **Europe writes 56% of merged commits, the US 25%, the UK alone
30%, and the entire combined contribution of Asia, Africa and Australia stays
below 10%**. A single Swedish contributor accounts for roughly half of all US
contributions combined.

This is not the result of US developers being less productive. It is the result
of the most prolific contributors in the cohort happening to live in Europe —
and of European contributors being relatively under-employed by US-based
employer organisations, which means more of their hours go to the open-source
path of least resistance. The Chaincode/Spiral/Brink-employed contingent tends
to spend cycle-time on review, mentorship and infrastructure work that does not
show up neatly in commit counts. European contributors funded through grants are
closer to the merge front line.

The Asian gap is the most consequential structural fact in this distribution.
There are zero Bitcoin Core contributors based in China, and only one in India.
For a protocol whose mining hash rate spent a decade in China and whose retail
user base is heavily East Asian, the absence of native contributor capacity in
the region is a single-point-of-failure that no funding organisation has so far
been positioned to address. Btrust's mandate covers India and Africa, but its
dev-training output has been weighted toward African capacity. Vinteum covers
Latin America. There is no equivalent for Mandarin- or Japanese-speaking
developers, and the 2017 PRC ICO ban and subsequent crypto restrictions have
made it politically expensive for any organisation to try.

## The 2024–2026 shift

The two years since the 1A1z report have visibly hardened the funding base. The
most consequential single event is the January 2024 VanEck pledge: 5% of net
profits from a spot Bitcoin ETF, running for at least ten years, paid to Brink
([CoinDesk, January 2024](https://www.coindesk.com/business/2024/01/05/vaneck-to-donate-5-of-profits-from-btc-etf-to-bitcoin-core-developers)).
VanEck's spot ETF was approved with the rest of the cohort on 10 January 2024.
The pledge structure — a percentage of an ongoing revenue stream rather than a
one-off endowment — is the first time the development funding base has been
linked to a recurring financial product rather than to discretionary
philanthropy. If ETF inflows continue at the pace seen since 2024, the eventual
dollar flow could exceed the entire 2023 ecosystem budget by itself. None of the
other ETF issuers — BlackRock, Fidelity, Ark/21Shares, Bitwise, Franklin
Templeton, Invesco, Valkyrie, WisdomTree, Hashdex — has matched the pledge.

Coinbase's $3.6M GiveCrypto wind-down to Brink in February 2024 was a one-off
transfer rather than a recurring commitment, but it funded the most substantive
operational year Brink has had to date — including the Quarkslab security audit
announced in November 2025
([Brink, November 2025](https://brink.dev/blog/2025/11/19/bitcoin-core-security-audit/)).
That audit deserves its own line. It was the first public third-party security
review of Bitcoin Core in the project's history, ran 100 person-days between May
and September 2025, covered the peer-to-peer networking layer, mempool,
peer/chain management and consensus/policy validation logic, and produced
exactly two low-severity findings and thirteen informational recommendations —
no critical, high or medium-severity issues. That a $1.7T network was operating
its first public audit only in 2025 is itself a structural fact about the
funding model. That the audit returned a clean result is one of the better
arguments for the model the funding organisations had been operating under.

The Maelstrom Bitcoin Grant Program, in its third or fourth quarter of 2025, has
now disbursed grants to rkrux, Ben Allen, Ron / macgyver13 and a fourth
recipient. The Payjoin Foundation became a 501(c)(3) on 23 July 2025
([Bitcoin Magazine, July 2025](https://bitcoinmagazine.com/business/payjoin-foundation-gains-501c3-status-enabling-tax-deductible-donations-for-bitcoin-privacy-development)),
which makes it the first privacy-dedicated funding entity in the ecosystem and
the only organisation explicitly trying to bypass the "Bitcoin Grant Purgatory"
of routing privacy-feature work through general-purpose grant pipelines. The
2140 Foundation in Amsterdam, OKX-seeded, has begun hiring. Tether's $250K to
OpenSats in October 2025 — Bitfinex's parent organisation — is a small but
symbolically important first cheque from the issuer that controls the largest
stablecoin in the ecosystem.

The question worth asking is whether all of this is hardening the structure or
just making the existing fragility more visible. Both, plausibly. The donor base
has broadened — ETF issuers, an exchange wind-down, a stablecoin issuer, a
derivatives-exchange family office — without displacing Dorsey's structural
position. The maintainer cohort has expanded — from five to six — without
materially diluting fanquake's share of merges. The geographic reach has widened
— Brazil, Amsterdam, Latin America, the African Btrust Builders cohort — without
changing the European/US weight of actual merged code.

## A note on privacy funding

A structural feature of this map deserves a separate analytical treatment, which
we will defer to a follow-up piece. Bitcoin's privacy work is funded as a
scattered set of grants across the existing thirteen, not as a vertical of its
own. Maelstrom funds Payjoin (Ben Allen) and Silent Payments (Ron / macgyver13)
under an explicit privacy mandate. HRF funds privacy work through the
human-rights lens — dissident tooling, geographies under capital controls.
Spiral funds Lightning-adjacent privacy via the LDK pipeline. OpenSats funds
dispersed privacy work via its general Bitcoin Fund. Until July 2025 there was
no Bitcoin equivalent of Shielded Labs, the Electric Coin Company or the Zcash
Foundation — no organisation whose mandate was, specifically and only, the
privacy properties of the protocol.

The Payjoin Foundation's 501(c)(3) designation in July 2025 changes that,
modestly. The Foundation's mandate is narrow — the Payjoin Dev Kit and
async-Payjoin protocols — but its 501(c)(3) status enables tax-deductible giving
and, structurally, gives the ecosystem its first standalone privacy fundee. The
mismatch between Bitcoin's actual privacy properties and the funding allocated
to improving them is the cleanest example in this map of where the structure of
money has shaped what the protocol actually offers users. It will get a
dedicated treatment in the next piece in this series.

## What the model says

The funding architecture described above is, in the strict engineering sense,
fragile. Six maintainers, one of whom merges two thirds of all changes.
Forty-one active developers running on roughly $8M a year. Thirteen
organisations, with one donor indirectly responsible for more than half of all
flows. Geographic representation that holds in two regions and largely fails in
three. Donations that move with the market cycle, with one documented year of a
58% drawdown at the largest dedicated non-profit.

What this same architecture also is — and the analytical mistake would be to
miss this — is a deliberately distributed structure that has so far refused, at
every juncture, to recentralise. The Bitcoin Foundation collapsed in 2015 and no
equivalent has been attempted since. The MIT DCI arrangement could have hardened
into a single institutional home and did not. Blockstream's early commit share
approached a fraction that, in another project, would have produced a contested
protocol; in Bitcoin Core's governance model it did not. The Dorsey footprint is
large enough to be a counterparty risk and has so far not been a governance
risk. The maintainer cohort is small enough to be a bus-factor risk and has so
far executed a clean security audit and a measured maintainer addition.

Two readings are available, and both are correct. The first is that Bitcoin's
anti-fragility thesis works at the funding layer exactly the way it claims to
work at the protocol layer: no single point of capture, no central treasury, no
entity whose failure necessarily kills the project. The 2015 Foundation
collapse, which would have ended most open-source projects of comparable
ambition, was absorbed by an academic refuge nobody had planned; the 2022 bear
market, which cut donations 58% at the largest dedicated non-profit, did not
interrupt protocol releases. The distributed funding structure is in fact a
structural answer to the question the thesis poses.

The second reading is that the system has been chronically under-funded for its
actual surface area, and that the surface area is growing faster than the
funding base. A network of Bitcoin's market capitalisation, transaction volume
and adversarial environment ought, on any standard accounting, to be running a
security budget at least an order of magnitude larger than the 2023 figure.
Every other comparable project — Ethereum at $32M+, Polkadot at $16.8M for a
network with one percent of Bitcoin's market cap — operates that way. The reason
Bitcoin does not is not a virtue of the protocol; it is a consequence of the
historical absence of a treasury mechanism and the political allergy to creating
one. The clean Quarkslab audit result is the strongest data point against the
under-funding case. The fact that a $1.7T network's first public third-party
audit happened only in late 2025, paid for by a wind-down gift from an exchange,
is the strongest data point for it.

The most useful thing a senior engineer can do with this architecture is hold
both readings simultaneously. Bitcoin's funding model is not a problem to be
solved; it is a configuration that has so far functioned and continues to be
load-bearing under visible strain. The 2024–2026 window has hardened it —
VanEck's ten-year pledge, Coinbase's $3.6M wind-down, the Payjoin Foundation
501(c)(3), the 2140 Foundation's European employer presence, the Maelstrom
mandate on privacy, the first public security audit, the sixth maintainer. None
of these resolves the structural facts: the $8M budget, the 65% merge share, the
Dorsey footprint, the absent Asian developer base. They make it survivable, year
by year, in a project that has spent its entire history surviving year by year.

A protocol designed to avoid single points of failure has produced a funding
apparatus that contains them, and a community that appears willing to keep
operating under that contradiction so long as no single point actually fails.
Whether that bet continues to hold over the next decade is the most interesting
open question about Bitcoin's development model — and the one most worth
revisiting in a follow-up.

---

## Sources

Primary source for the structural numbers:

- Dan O'Prey and Mas Nakachi,
  ["Building Bitcoin: Funding a $1.2 Trillion Dollar Project" (Part 1)](https://1a1z.com/fund.html),
  1A1z, October 2024.
  [Twitter announcement](https://x.com/1A1zBTC/status/1848845545714098311).
- [nobsbitcoin, October 2024 — Bitcoin Core development funded with $8.4M in 2023](https://www.nobsbitcoin.com/bitcoin-core-development-funded-with-8-4m-in-2023-report/).

Historical funding:

- [Wikipedia — Bitcoin Foundation](https://en.wikipedia.org/wiki/Bitcoin_Foundation).
- [weusecoins — Wladimir van der Laan profile](https://www.weusecoins.com/wladimir-van-der-laan/).
- [Genfinity, February 2026 — Newly released Epstein documents reveal Bitcoin Core funding connection](https://genfinity.io/2026/02/02/epstein-documents-bitcoin-core-mit-funding/).
- [DL News, 2026 — Epstein files and Bitcoin development](https://www.dlnews.com/articles/people-culture/epstein-files-reveal-desire-to-steer-bitcoin-via-its-developers/).
- [Wikipedia — Blockstream](https://en.wikipedia.org/wiki/Blockstream).
- [Chaincode Labs — About](https://chaincode.com/about).

Organisations and grants:

- [CoinDesk, November 2020 — Square, HRF back new Bitcoin OSS developer fund](https://www.coindesk.com/tech/2020/11/24/square-human-rights-foundation-back-new-bitcoin-open-source-developer-fund).
- [HRF — Bitcoin Development Fund](https://hrf.org/program/financial-freedom/bitcoin-development-fund/).
- [Spiral — Square Crypto grants for everybody](https://spiral.xyz/blog/square-crypto-grants-for-everybody/).
- [OpenSats — 2024 Year in Review](https://opensats.org/blog/2024-year-in-review).
- [OpenSats — Long-Term Support program](https://opensats.org/blog/announcing-lts-grant-program-to-support-bitcoin-core-contributors).
- [TFTC, December 2023 — Dorsey's #startsmall donates $21M to OpenSats](https://www.tftc.io/jack-dorseys-startsmall-donates-21-million-opensats/).
- [Bitcoin Magazine, 2022 — Vinteum to fund Bitcoin developers in Brazil](https://bitcoinmagazine.com/business/vinteum-to-fund-bitcoin-developers-in-brazil).
- [The Block, 2024 — Arthur Hayes' Maelstrom Bitcoin developer grant program](https://www.theblock.co/post/305798/arthur-hayes-maelstrom-bitcoin-developer-grant-program).
- [Cointelegraph, 2024 — Bitcoin Payjoin privacy grant from Maelstrom](https://cointelegraph.com/news/bitcoin-payjoin-privacy-grant-maelstrom).
- [nobsbitcoin, 2025 — 2140 Foundation launched](https://www.nobsbitcoin.com/2140-foundation-launched-to-support-open-source-bitcoin-development/).
- [OKX, 2022 — OKX joins Okcoin Developer Grant Program; Dusty Daemon co-sponsorship](https://www.okx.com/learn/okx-okcoin-developer-grant-program-award-bitcoin-developer-dusty-daemon).

Recent funding events:

- [CoinDesk, January 2024 — VanEck to donate 5% of BTC ETF profits to Bitcoin Core developers](https://www.coindesk.com/business/2024/01/05/vaneck-to-donate-5-of-profits-from-btc-etf-to-bitcoin-core-developers).
- [The Block, February 2024 — Coinbase donates $3.6M to Brink](https://www.theblock.co/post/277882/coinbase-donates-3-6-million-to-support-bitcoin-developer-funding-through-brink).
- [Bitcoin Magazine, July 2025 — Payjoin Foundation gains 501(c)(3) status](https://bitcoinmagazine.com/business/payjoin-foundation-gains-501c3-status-enabling-tax-deductible-donations-for-bitcoin-privacy-development).
- [Tether, October 2025 — Tether donates $250,000 to OpenSats](https://tether.io/news/tether-donates-250000-to-opensats-to-strengthen-free-and-open-source-ecosystems-supporting-bitcoin-and-freedom-tech/).
- [Quarkslab blog, November 2025 — Bitcoin Core audit](https://blog.quarkslab.com/bitcoin-core-audit.html).
- [Brink, November 2025 — Independent security audit of Bitcoin Core](https://brink.dev/blog/2025/11/19/bitcoin-core-security-audit/).

Maintainer and governance:

- [insider.btcpp.dev, January 2026 — Bitcoin Core adds new maintainer: sedited](https://insider.btcpp.dev/p/bitcoin-core-adds-new-maintainer).
- [Bitcoin Magazine — The Core Issue: the role and history of Bitcoin Core maintainers](https://bitcoinmagazine.com/print/the-core-issue-the-role-and-history-of-bitcoin-core-maintainers).

Comparison numbers:

- [Cointelegraph, August 2024 — Vitalik Buterin breaks down 2023 Ethereum Foundation spending](https://cointelegraph.com/news/vitalik-buterin-breakdown-2023-ethereum-foundation-spending).
- [Web3 Foundation, November 2023 — $45M Decentralised Futures Program](https://web3.foundation/press/w3f-launches-decentralized-futures-program/).
