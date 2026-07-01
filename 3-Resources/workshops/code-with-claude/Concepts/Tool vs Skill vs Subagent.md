---
type: concept
category: agents
tags:
  - "#cwc"
  - "#agents"
  - "#architecture"
  - "#concept"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Tool vs Skill vs Subagent

## Summary

> [!abstract]
> When an agent grows, the question is rarely "which model" — it's *at which altitude does this capability belong*: a **tool** (one function), a **skill** (a written policy read on demand), or a **subagent** (a separate agent with its own context). They form a cost/power spectrum, and picking wrong is what turns a clean agent into a 400-line prompt.

## Description

Every capability you add sits somewhere on a spectrum from cheap-and-weak to powerful-and-expensive. The trap in [[Agent Decomposition|StockPilot]] is that *each individual choice was reasonable* — a tool here, a subagent there — but the aggregate is a 402-line prompt, 12 tools, and 3 hardcoded subagents that nobody can reason about.

## Diagram

![[tool-skill-subagent.excalidraw]]

## How it works

| | **Tool** | **Skill** | **Subagent** |
|---|---|---|---|
| What | one function, stateless | a written policy file | a separate agent, own context + goal |
| Cost | tokens on every call | free until relevant, then loaded on demand | highest — a whole extra context window |
| Reach for it when | a clean, deterministic contract | "always do X before Y" knowledge | a genuinely open-ended sub-outcome |

**Smell tests** (from the StockPilot workshop):

- A tool returns **> 2k tokens**? → don't dump data into context; let the agent **compute** the answer in code (Bash over the CSVs).
- You're writing **"always do X before Y"** in the system prompt? → that's a **skill**, not a prompt paragraph.
- A subagent's output is **one number** (or a sort, or a filled-in template)? → it shouldn't be a subagent.

The deep point: decomposing didn't *shrink the knowledge*. In StockPilot, 402 prompt lines became ~400 skill lines. What changed is **when** that knowledge is in context — always vs. only-when-relevant. And delegation stopped being hardcoded; it became a runtime decision the agent makes.

## Examples

- **Data-dump tool → code execution.** `list_low_stock` returned ~400 rows into context on every call. Deleting it and letting the agent `grep`/aggregate the CSV cut the F1 daily sweep from **488s · 102 tool calls** to **~100s · 3 scripts**.
- **Prompt paragraph → skill.** The reorder policy lived in both the prompt *and* a skill file; enabling the `reorder-policy` skill and switching to the short prompt removed the duplication.
- **Template subagent → skill.** `send_slack_alert` called a *writing* subagent to fill what was essentially a template — a classic "shouldn't be a subagent."

## Related Concepts

- [[Managed Agents]]
- [[Eval-Driven Development]] — how you *prove* a decomposition helped instead of guessing.

## References

- Lab: [[Agent Decomposition]]
- Docs: [Programmatic tool calling](https://platform.claude.com/docs/en/agents-and-tools/tool-use/programmatic-tool-calling)
