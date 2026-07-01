---
type: briefing
category: agents
tags:
  - "#cwc"
  - "#briefing"
  - "#news"
  - "#agents"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# CWC London — What Anthropic Presented

> [!abstract]
> A quick briefing on **Code with Claude London (19–20 May 2026)** — Anthropic's developer conference — delivered news-style. The point is context: these are the themes the labs in this workshop drill into. If you only read one note before the session, read this one.

## The three tracks

Anthropic organised London around three tracks:

- **Research** — where model capability is heading.
- **Claude Platform** — the API, Managed Agents, memory, MCP, evals.
- **Claude Code** — agentic coding at scale, harnesses, long-running agents.

The through-line across all three: **the unit of work is shifting from "a model call" to "an agent you configure and trust."**

## Headline announcements

### Managed Agents grew up
[[Managed Agents]] — where Anthropic hosts the agent loop, sandbox, and state — got three notable capabilities:

- **Multi-agent orchestration** — spin up *fleets* of agents to tackle a complex task in parallel, coordinated by a lead agent.
- **Outcomes** — declare *what success looks like* and let Claude iterate toward it, instead of hand-holding each step.
- **[[Memory and Dreaming|Dreaming]]** — an agent inspects its previous sessions (e.g. overnight), figures out what it missed, and self-improves by writing better memories.

> **Why it matters:** these turn a single request-response agent into something closer to a colleague that plans, parallelises, and learns from its own history.

### Enterprise-grade boundaries
Managed Agents can run in **a sandbox you control** and reach **your private MCP servers** — both the execution environment and the services it touches stay inside your enterprise boundary.

> **Why it matters:** it's the difference between a demo and something you can point at real, private data.

### Memory, evals, and multi-agent systems
Recurring platform themes: **memory stores** for cross-session persistence ([[Memory and Dreaming]]), **[[Eval-Driven Development|eval-driven development]]** ("measure every change, don't vibe"), and composing **multi-agent systems** from skills + MCP ([[Tool vs Skill vs Subagent]]).

### Claude Code at scale & long-running agents
On the Claude Code side: running Claude Code across large teams, and **[[Long-Running Agents|long-running agents]]** — harness patterns (default-FAIL contracts, fresh-context evaluators, agent-maintained handoff) that let an agent grind on a task for hours and still produce trustworthy work.

## The stations (workshops) at CWC

The conference ran eight hands-on stations. This workshop distils **the four Roman worked through**, plus a spotlight:

| Station | What it teaches | In this workshop? |
|---|---|---|
| Ship Your First Managed Agent | The four CMA resources | **[[Ship Your First Managed Agent|Lab 1]]** |
| Agent Battle | Config levers (prompt/skills/MCP/model) | **[[Agent Battle|Lab 2]]** |
| Compose Multi-Agent Systems (StockPilot) | tool → skill → subagent | **[[Agent Decomposition|Lab 3]]** |
| Eval-Driven Agent Development | Two-layer grading | **[[Eval-Driven Agent Development|Lab 4]]** |
| Agents That Remember | Memory stores + Dreaming | **[[Agents That Remember|Lab 5]]** (+ theory: [[Memory and Dreaming]]) |
| Long-Running Agents | Harness patterns | **[[Bonus — Long-Running Agents Harness|Bonus]]** |
| Picking the Right Model | Eval-audit + model sweep | Mentioned (out of scope v1) |
| The Research Desk / Deal Desk | Production multi-agent apps | Mentioned (out of scope v1) |

## The four topics we go deep on today

Fundamentals → the levers → architecture → measurement:

1. **[[Ship Your First Managed Agent]]** — build the four resources.
2. **[[Agent Battle]]** — tune the config.
3. **[[Agent Decomposition]]** — compose skills + code + subagents.
4. **[[Eval-Driven Agent Development]]** — measure every change.

Then a bonus on **[[Bonus — Long-Running Agents Harness|long-running agents]]**.

## Watch / read

- [Code with Claude — official site & session recordings](https://claude.com/code-with-claude)
- [Code w/ Claude London 2026 — recap blog](https://claude.com/blog/code-w-claude-london-2026-rethinking-how-we-build)
- Repos: [anthropics/cwc-workshops](https://github.com/anthropics/cwc-workshops) · [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents)

## Related

- [[Start Here]] · [[Managed Agents]] · [[Memory and Dreaming]] · [[Long-Running Agents]]
