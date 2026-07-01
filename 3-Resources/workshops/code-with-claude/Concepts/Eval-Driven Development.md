---
type: concept
category: agents
tags:
  - "#cwc"
  - "#agents"
  - "#evals"
  - "#concept"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Eval-Driven Development

## Summary

> [!abstract]
> Prompt changes feel like progress and often aren't. **Eval-driven development** puts a scorecard behind every change — a task suite plus a two-layer grader — so "this is better" becomes a number instead of a vibe.

## Description

Agents are non-deterministic, so intuition is a bad optimiser: a prompt tweak that looks smarter can quietly regress three other tasks. The fix is the same discipline as test-driven development, adapted for fuzzy outputs — a **held-out task suite** and a **grader** that scores each run, with a **baseline** you measure deltas against.

## Diagram

![[eval-loop.excalidraw]]

## How it works

**Two-layer grading** is the key idea — combine what's cheap and exact with what's fuzzy but human-like:

1. **Programmatic metrics** — deterministic checks on the artifact. For the [[Eval-Driven Agent Development|slide-deck agent]]: parse the `.pptx` XML for emoji count, image coverage, shape density, text density. Fast, free, objective.
2. **LLM-as-judge** — a model scores the things code can't, e.g. "is this slide actually well-designed?" over the *rendered* image. Captures quality; costs a call.

Then:

- **Baseline first.** Record the starting score; every later run shows a delta, not just an absolute.
- **Change one thing.** Isolate the variable so the scorecard tells you what moved.
- **Read the failures, not just the number.** The *why* column is where the signal is — a passing average can hide a task that fell off a cliff.

## Examples

- **Slide-deck agent** ([[Eval-Driven Agent Development|Lab 4]]): iterate a PPTX generator through variants (naive → visual → typography → palette → density → QA-loop); the programmatic grader catches "13 emojis, no images," the judge catches "dense and ugly."
- **StockPilot** ([[Agent Decomposition|Lab 3]]): the 12-task suite is what makes the decomposition claim real — score **71% → 92%**, and you can point at *which* tasks flipped (F1, F2) rather than asserting "it feels better."
- **Model selection**: the same discipline underlies picking a model — not "which is fastest" but "which passes my eval at my cost/latency target."

## Related Concepts

- [[Tool vs Skill vs Subagent]] — evals are how you verify each decomposition step.
- [[Managed Agents]]

## References

- Labs: [[Eval-Driven Agent Development]] · [[Agent Decomposition]]
