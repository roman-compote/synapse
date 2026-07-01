---
type: guide
tags:
  - "#cwc"
  - "#facilitator"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Facilitator Guide

> [!abstract]
> How to run this for colleagues. The format is **guided demo + take-home labs**: you drive the screen, they watch and ask questions, and everyone gets self-contained lab guides to run afterward on their own keys. No one needs a working API key *during* the session.

## Run-of-show (half day, ~3 hrs)

| Time | Segment | You do | They do |
|---|---|---|---|
| 0:00 | **Briefing** (15 min) | Walk [[CWC London — What Anthropic Presented]] + the deck's first slides | Watch; ask what's changed |
| 0:15 | **Theory** (15 min) | [[Managed Agents]] + [[The Four CMA Resources]] with the `cma-resources` diagram | — |
| 0:30 | **Lab 1 live** (45 min) | Live-code [[Ship Your First Managed Agent]] — the 7 functions | Follow along *or* watch; run later |
| 1:15 | **Lab 2 demo** (30 min) | Demo [[Agent Battle]] `--eval` loop; show Roman's config | Suggest prompt tweaks live |
| 1:45 | break (10) | | |
| 1:55 | **Lab 3 demo** (35 min) | Demo [[Agent Decomposition]] cycle 1–2; show 71%→92% | Debate keep/skill/delete calls |
| 2:30 | **Lab 4 demo** (20 min) | Show [[Eval-Driven Agent Development]] two-layer grader on rendered slides | — |
| 2:50 | **Bonus + wrap** (10 min) | [[Bonus — Long-Running Agents Harness]] + `/goal`; point to take-home | Q&A |

**Shorter (90 min):** Briefing → theory → Lab 1 live → Lab 2 demo. Labs 3–4 as take-home.

## What to demo live vs. leave as take-home

- **Live (highest payoff on screen):** Lab 1 (the "aha" when the panel comes online), Lab 2's `--eval` (~30s feedback is great live), Lab 3's before/after eval numbers.
- **Take-home (setup-heavy):** Lab 4 (Docker image build ~5 min), the Bonus (needs their own repo).

## Pre-flight (day before)

- Run each lab you'll demo end-to-end once on your machine — API/beta access, versions, ports.
- Lab 4: build the Docker image ahead of time (`docker build -t cwc-pptx-render .`).
- Lab 2: pre-run `/cwc-setup` so the Minecraft server/tunnel is warm; have `localhost:8088/view` open.
- Have the [[Code with Claude — Workshop Deck|deck]] open in Marp preview on a second screen.

## Known gotchas

- **Beta access:** confirm your key has Managed Agents enabled; Dreaming needs research preview (it's theory-only here anyway).
- **Ports:** Lab 1 → 8501, Lab 2 → 8088 & 3007. Kill stragglers before demoing.
- **Lab 2 on corporate VPN:** VPN DNS can block `*.trycloudflare.com` tunnel URLs — the agent still runs, but the browser cast view won't load. Disconnect VPN for the demo.
- **Lab 3:** after every edit to `agent.py`, `uv run deploy starter` before evals — the config lives on CMA's servers.
- **Lab 4:** paste the `ant create` resource IDs into `src/create-slides.ts`, or `create-slides` 404s.

## Sharing with colleagues

Sync/share the whole [[README|Synapse]] vault, or export just this folder (`3-Resources/workshops/code-with-claude/`). Remind them to do [[Setup]] part A (plugins) so diagrams render. The deck also exports to PDF/HTML via Marp for anyone not in Obsidian.

## Related

- [[Start Here]] · [[Setup]] · [[Code with Claude — Workshop Deck]]
