---
type: concept
category: agents
tags:
  - "#cwc"
  - "#agents"
  - "#long-running"
  - "#concept"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Long-Running Agents

## Summary

> [!abstract]
> An agent asked to work for hours will happily declare victory it hasn't earned, grade its own homework, and lose the thread across sessions. **Long-running agents** is a set of harness patterns — structural quality gates, a fresh-context evaluator, and agent-maintained handoff — that keep a build → evaluate → rebuild loop honest without a human watching every turn.

## Description

This is the **Claude Code** layer, not [[Managed Agents]] — it's built from hooks, subagents, and git in your own repo. It answers a different question than the labs: *how do I let an agent grind on a big task overnight and trust the result?* The failure modes are specific and recurring:

- Agents mark work "done" without evidence.
- Agents that build *and* grade their own work suffer confirmation bias.
- Context and progress evaporate across sessions.

## Diagram

![[long-running-quality-loop.excalidraw]]

## How it works — three core primitives

1. **Default-FAIL contract.** Every completion criterion starts `false` in a `test-results.json`. A `PreToolUse` hook won't let the agent flip a criterion to passing until it has *opened the evidence* first. Structure enforces honesty instead of trusting the prompt.
2. **Fresh-context evaluator.** A separate subagent with **no Write/Edit tools** reviews the diff (and screenshots) from a clean context window and returns `PASS` or `NEEDS_WORK` with specific findings. The builder can't grade itself.
3. **Agent-maintained handoff.** The agent keeps a structured `PROGRESS.md` and commits at checkpoints (a `commit-on-stop` hook). The next session reads `PROGRESS.md` and picks up cleanly — persistence via git, not memory.

**Operator control** rides alongside: a `kill-switch` hook halts all tool calls while an `AGENT_STOP` file exists, and a `steer` hook injects mid-run redirects from a `STEER.md`.

The simplest entry point is Claude Code's built-in **`/goal`** command:

```
/goal every feature in PROGRESS.md is implemented, committed, and its tests pass
```

It works interactively, headless (`claude -p`), and via Remote Control — no contract file required.

## Examples

- **Unattended build loop** — an outer script caps session length and starts the next session; the agent rebuilds the next unfinished feature from `PROGRESS.md` each time.
- **Browser-verified evaluator** — the fresh-context evaluator opens the running app via Playwright MCP and checks it actually works, not just that the code compiles.

## Related Concepts

- [[Eval-Driven Development]] — same "measure, don't trust" instinct, applied to a single agent's own output.
- [[Memory and Dreaming]] — persistence at the Managed Agents layer; this is persistence at the Claude Code layer.

## References

- Bonus lab: [[Bonus — Long-Running Agents Harness]]
- Repo: [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents)
- Anthropic engineering: [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) · [Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
