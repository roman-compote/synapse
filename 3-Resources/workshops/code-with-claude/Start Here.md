---
type: landing
title: "Code with Claude — Start Here"
audience: colleagues
tags:
  - "#cwc"
  - "#landing"
  - "#workshop"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Code with Claude — Start Here

> [!abstract]
> A practical workshop on **building agents with Claude**, distilled from Anthropic's *Code with Claude* conference (London, May 2026). Light on theory, heavy on hands-on: a short briefing, five labs you can run yourself, and a bonus on long-running agents — all cross-linked so you can wander or follow the path.

> [!tip] Pin this tab
> Right-click the tab → **Pin**. It's your home base. New to Obsidian? Everything here is a note; click any `[[link]]` to follow a thread.

![[workshop-roadmap.excalidraw]]

## What you'll be able to do

- **Build a Managed Agent** from the four core resources (Agent → Environment → Session → Events).
- **Tune an agent's config** — model, system prompt, skills, MCP — and feel each lever.
- **Decompose a bloated agent** into skills + code execution + subagents, and prove it with evals.
- **Measure every change** with a two-layer grader instead of guessing.
- **Give an agent memory** — a live memory store, then **Dreaming** to consolidate transcripts into recall.
- **Recognise the shape** of long-running agents that work unattended and stay trustworthy.

## The 5-minute tour

1. Read the **[[CWC London — What Anthropic Presented|briefing]]** — what Anthropic announced and why it matters (5 min).
2. Skim **[[Managed Agents]]** and **[[The Four CMA Resources]]** — the only theory you need to start.
3. Do **[[Ship Your First Managed Agent|Lab 1]]** — build your first agent in ~34 lines.
4. Pick the next lab that interests you from the table below.
5. Come back and skim the concepts that each lab links to.

## Agenda

| # | Session | Essence | Time |
|---|---------|---------|------|
| 0 | [[CWC London — What Anthropic Presented|Briefing]] | The news from CWC London | 15 min |
| 1 | [[Ship Your First Managed Agent]] | The four CMA resources, 7 functions | ~45 min |
| 2 | [[Agent Battle]] | Config levers: prompt · skills · MCP · model | ~45 min |
| 3 | [[Agent Decomposition]] | tool → skill → subagent (71% → 92%) | ~45 min |
| 4 | [[Eval-Driven Agent Development]] | Two-layer grading; measure every change | variable |
| 5 | [[Agents That Remember]] | Memory stores + Dreaming (goldfish → colleague) · *research preview* | ~45 min |
| ★ | [[Bonus — Long-Running Agents Harness]] | Agents that run for hours, honestly | self-paced |

> A comfortable format is **briefing + Lab 1 live together**, then Labs 2–4 as guided demos with take-home guides. See [[Facilitator Guide]].

## The theory (light)

- [[Managed Agents]] — what a hosted agent is
- [[The Four CMA Resources]] — Agent → Environment → Session → Events
- [[Tool vs Skill vs Subagent]] — the decomposition framework
- [[Eval-Driven Development]] — measure, don't vibe
- [[Memory and Dreaming]] — cross-session persistence
- [[Long-Running Agents]] — unattended, trustworthy loops

## Before you start

- **[[Setup]]** — API keys, beta access, and the per-lab toolchain. Do this first.
- All labs run against the public repo: [anthropics/cwc-workshops](https://github.com/anthropics/cwc-workshops).

## Where to find things

| If you want to… | Look in… |
|---|---|
| Get the news | [[CWC London — What Anthropic Presented]] |
| Look up a concept | `Concepts/` |
| Run something hands-on | `Labs/` |
| Present it | [[Code with Claude — Workshop Deck]] (`Presentation/`) |
| Run the session | [[Facilitator Guide]] |
| See the diagrams | `_assets/diagrams/` (embedded in notes) |

## How this vault works (30 seconds)

- Every concept and lab is its own note; follow `[[links]]`.
- Diagrams are **Excalidraw**; the deck is **Marp** — both need a one-time plugin install (see [[Setup]]).
- This lives in `3-Resources/workshops/code-with-claude/` in the [[README|Synapse]] vault.
