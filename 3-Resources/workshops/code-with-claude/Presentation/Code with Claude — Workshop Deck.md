---
type: presentation
title: "Code with Claude — Workshop"
description: "Building agents with Claude — workshop deck"
tags:
  - "#cwc"
  - "#presentation"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Code with Claude

### Building agents with Claude — a practical workshop

From Anthropic's developer conference · London, May 2026

---

## The shift

Write the agent loop yourself  →  **Anthropic hosts it**

Guess if a change helped  →  **measure it**

One prompt does everything  →  **skills + code + subagents**

One request, one reply  →  **agents that plan, remember, run for hours**

---

![[workshop-roadmap.excalidraw|1000]]

Briefing → 4 labs → bonus.

---

## The news from CWC London

- **Managed Agents** grew up: multi-agent **orchestration**, **Outcomes**, **Dreaming**
- Sandboxes **you control** + **private MCP** servers
- Memory · evals · multi-agent systems
- Claude Code **at scale** + **long-running agents**

*The unit of work moved from "a model call" to "an agent you configure and trust."*

---

## What is a Managed Agent?

You declare **what** the agent is and **where** it runs.

Anthropic runs the loop, the sandbox, and the state.

Every lab today is mostly **configuration**, not plumbing.

---

![[cma-resources.excalidraw|1000]]

---

## Lab 1 — Ship Your First Managed Agent

Seven functions. ~34 lines.

Ask *"what caused the latency spike?"* → it greps a **70k-line log** in its sandbox, calls **your** tools, names the commit.

**Lever: the four resources.**

---

## Lab 2 — Agent Battle

Configure an agent to mine diamonds. Most diamonds win; **fewest tokens** breaks ties.

`--eval` gives feedback in ~30s.

**Levers: model · system · skills · MCP.**

---

![[tool-skill-subagent.excalidraw|900]]

Lab 3 — decompose the monolith. **71% → 92%.**

---

![[eval-loop.excalidraw|850]]

Lab 4 — measure every change, don't vibe.

---

![[long-running-quality-loop.excalidraw|1000]]

Bonus — agents that run for hours, honestly.

---

## Go build

- **Briefing:** [[CWC London — What Anthropic Presented]]
- **Start:** [[Ship Your First Managed Agent|Lab 1]]
- **Setup:** [[Setup]]
- Repos: `anthropics/cwc-workshops` · `anthropics/cwc-long-running-agents`

*Questions?*
