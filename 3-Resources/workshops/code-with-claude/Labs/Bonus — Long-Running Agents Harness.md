---
type: exercise
lab: bonus
module: cwc-long-running-agents
stack: [Shell, Claude Code, hooks, subagents]
level: intermediate
duration: self-paced
tags:
  - "#cwc"
  - "#lab"
  - "#long-running"
  - "#claude-code"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Bonus — Long-Running Agents Harness

## Summary

> [!abstract]
> A spotlight on [`anthropics/cwc-long-running-agents`](https://github.com/anthropics/cwc-long-running-agents) — example primitives for letting a **Claude Code** agent grind on a big task for hours and still produce trustworthy work. Not a Managed Agents lab: this is hooks + subagents + git in your own repo. Cherry-pick the ingredients; it's not a turnkey harness.

## Why it's here

The four main labs are about **Managed Agents**. This one is adjacent but was one of the most interesting stations at CWC London, because it answers a question the labs don't: *how do I trust an agent that works unattended overnight?* See the theory note **[[Long-Running Agents]]** first.

## Learning objective

Understand the three failure modes of long-running agents and the three primitives that counter them — then copy the config into a repo and drive a build → evaluate → rebuild loop.

## The three primitives

![[long-running-quality-loop.excalidraw]]

1. **Default-FAIL contract** — `test-results.json` where every criterion starts `false`; a `PreToolUse` hook (`track-read.sh` + `verify-gate.sh`) blocks marking anything passing until the agent has opened the evidence.
2. **Fresh-context evaluator** — `agents/evaluator.md`, a subagent with **no Write/Edit tools**, reviews diffs/screenshots from a clean context and returns `PASS` / `NEEDS_WORK` with findings. The builder can't grade itself.
3. **Agent-maintained handoff** — the agent keeps `PROGRESS.md` and a `commit-on-stop.sh` hook commits at session end; the next session resumes cleanly.

**Operator hooks:** `kill-switch.sh` (halt while an `AGENT_STOP` file exists) and `steer.sh` (inject redirects from `STEER.md` mid-run).

## How to try it

**Prerequisites:** Claude Code. See [[Setup]].

```bash
git clone https://github.com/anthropics/cwc-long-running-agents
cd cwc-long-running-agents
cp -r claude-code-config/.claude /path/to/your/project/
chmod +x /path/to/your/project/.claude/hooks/*.sh
```

Adapt `RESULTS_FILE` and the evidence-file patterns in `track-read.sh` to your project, then run Claude Code from the directory containing `.claude/`.

**Two ways to run the loop:**

- **Built-in `/goal`** (simplest, no contract file):
  ```
  /goal every feature in PROGRESS.md is implemented, committed, and its tests pass
  ```
  Works interactive, headless (`claude -p`), and via Remote Control.
- **Custom evaluator gate** — pair the default-FAIL contract with your own `evaluator.md`:
  ```bash
  while grep -q '"passes": false' test-results.json; do
    claude -p "Read PROGRESS.md and build the next unfinished feature"
    VERDICT=$(claude --agent evaluator -p "Review the most recent commit")
    [ "$(echo "$VERDICT" | head -1)" = "PASS" ] || echo "$VERDICT" > NEXT_FINDINGS.md
  done
  ```

## Going further

Patterns from the linked engineering posts: unattended loop (cap session length, outer script starts the next), a planner agent that expands a one-liner into `BUILD_PLAN.md`, sprint contracts, grading rubrics, a browser-verified evaluator (Playwright MCP), and re-simplifying the harness as models improve.

## Key files (in the repo)

- `claude-code-config/.claude/CLAUDE.md` — conventions
- `.../agents/evaluator.md` — the fresh-context evaluator subagent
- `.../hooks/` — `track-read.sh`, `verify-gate.sh`, `commit-on-stop.sh`, `kill-switch.sh`, `steer.sh`
- `.../test-results.json` — the default-FAIL contract

## Concepts demonstrated

- [[Long-Running Agents]]
- [[Eval-Driven Development]] — the same "measure, don't trust" instinct

## References

- Repo: [anthropics/cwc-long-running-agents](https://github.com/anthropics/cwc-long-running-agents)
- [Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Claude Code `/goal` docs](https://code.claude.com/docs/en/goal)
