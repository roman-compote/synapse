---
type: concept
category: agents
tags:
  - "#cwc"
  - "#agents"
  - "#memory"
  - "#concept"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Memory and Dreaming

## Summary

> [!abstract]
> Managed Agent sessions are amnesiac by design — nothing carries across them. Two primitives fix that: a **memory store** (a persistent filesystem the agent reads/writes, for cross-session state *now*) and **Dreaming** (a batch job that consolidates past transcripts into structured recall). "Goldfish to colleague."

## Description

Session isolation is a feature, not a bug — each run starts clean. But a useful colleague remembers what happened last week. This is a *context-window* problem: you can't just keep appending history forever. Memory and Dreaming are the two answers, and they trade off along a live-vs-batch axis.

> [!note] Not a hands-on lab in this workshop
> This concept comes from Anthropic's *Agents That Remember* station at CWC London. We cover it as **theory** so the [[CWC London — What Anthropic Presented|briefing]] makes sense — Dreaming was one of the headline announcements — but there's no lab here. Note that **Dreaming is a research-preview feature** and needs your org opted in.

## How it works

- **Memory store** — a persistent read/write filesystem, attached to a session at creation. The agent writes notes during a run; the next session mounts the store and reads them. Cheap, live, and you steer *how* it's used with a prompt (what to write, how to organise). Reach for this when the agent needs cross-session state right now.
- **Dreaming** — a batch service that reads a set of past transcripts plus the old store and emits a **new, consolidated store**. The agent effectively "sleeps on" its history and wakes up able to recall things from sessions it never participated in. Costlier and asynchronous — reach for it when you want structured recall distilled from a lot of past runs (e.g. run it overnight).

The progression Anthropic demos: tell an agent facts in session A → ask in session B → it has no idea (amnesia). Add a memory store → it remembers. Run Dreaming over the history → it recalls from transcripts it wasn't part of.

## Examples

- **Cross-session state** — a support agent that remembers a customer's earlier tickets via a memory store.
- **Overnight consolidation** — Dreaming inspects yesterday's sessions, notices what it missed, and writes better memories for tomorrow.

## Related Concepts

- [[Managed Agents]] — memory and Dreaming are CMA primitives.
- [[Long-Running Agents]] — a different take on persistence, at the Claude Code layer (agent-maintained `PROGRESS.md` + git).

## References

- Briefing: [[CWC London — What Anthropic Presented]]
- CWC module: `agents-that-remember` in the [cwc-workshops repo](https://github.com/anthropics/cwc-workshops)
