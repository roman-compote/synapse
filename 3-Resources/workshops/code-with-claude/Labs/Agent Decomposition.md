---
type: exercise
lab: 3
module: agent-decomposition
stack: [Python, uv, Managed Agents API, Skills]
level: advanced
duration: ~45 min
tags:
  - "#cwc"
  - "#lab"
  - "#managed-agents"
  - "#architecture"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Lab 3 — Agent Decomposition

## Summary

> [!abstract]
> You inherit **StockPilot**, an inventory agent that grew to 12 tools, 3 hardcoded subagents, and a 402-line system prompt. Decompose it with skills + code execution + one well-placed subagent, running evals after each change to watch the score climb from **71% → 92%**.

## Learning objective

Internalise the **[[Tool vs Skill vs Subagent|tool → skill → subagent decision framework]]** by applying it to a realistic mess — and prove each move with [[Eval-Driven Development|evals]] instead of guessing.

## Tech stack

- **Language:** Python 3.10+ with `uv`
- **Platform:** Managed Agents (deploy, sessions, sandbox code execution)
- **Data:** simulated 250-SKU inventory CSVs (mounted in the sandbox)
- **Evals:** a 12-task suite (R1–R9, F1–F3) with an LLM-as-judge grader

## How to run

**Prerequisites:** Python 3.10+, `uv`, `ANTHROPIC_API_KEY`. See [[Setup]].

```bash
git clone https://github.com/anthropics/cwc-workshops
cd cwc-workshops/agent-decomposition
uv sync
cp .env.example .env                      # add ANTHROPIC_API_KEY
uv run seed                               # generate 250-SKU inventory data
uv run evals --agent before               # full baseline — ~9 min, runs locally, no deploy
```

The baseline lands ~71% (F1/F2 fail, F3 pass-slow). Then the iteration loop:

```bash
uv run deploy starter                                   # push agents/starter/agent.py to CMA (~15-20s)
uv run stockpilot --agent starter "stock for SKU-0042 at WH-EAST?"   # one session; inspect it in the Console
uv run evals --agent starter --task F3                  # run a subset before/after each edit
uv run evals --compare starter                          # before vs starter, side by side
```

**After every edit to `agents/starter/agent.py`, `uv run deploy starter` before re-running evals** — the config lives on CMA's servers. The eval CLI tells you PASS/FAIL; the **Console shows you why** (full transcript: every tool call, every Bash command, every skill file loaded).

## The three decomposition cycles

The TODO comments in `agent.py` are **questions, not instructions** — for each of the 12 legacy tools decide: keep / code-exec / skill / delete.

| Cycle | Diagnose | Decide | Verify |
|---|---|---|---|
| 1 | Where does `LEGACY_PROMPT` duplicate the skill files? | Swap to `SHORT_PROMPT`; enable `notify-templates` + `weekly-report` | `--task F3` |
| 2 | Count tool calls in the slow F1 transcript | Drop the data-dump tools; let the agent use Bash over the CSVs | `--task F1` |
| 3 | Where does the forecast's confidence number get lost? | Enable `forecasting`; decide if/how a subagent is involved | `--task F2,R7` |

## Expected result

| | Before | After |
|---|---|---|
| Score | 71% | **92%** |
| F1 daily sweep | 488s · **102 tool calls** | ~100s · **3 scripts** |
| System prompt | 402 lines | 15 lines (+400 lines of skills, loaded on demand) |
| Hardcoded subagents | 3 | 0 (delegation is now a runtime decision) |

The knowledge didn't shrink — it moved. 402 prompt lines became ~400 skill lines; the difference is *when* they're in context. (LLM variance is ±8pt/run.)

## Reference solution

> [!success] Roman's decomposed config (`agents/starter/agent.py`)
> - `LEGACY_TOOLS = []` — **all 12 legacy tools removed**; the agent computes over the CSVs in its sandbox instead.
> - **All 5 skills enabled:** `notify-templates`, `weekly-report`, `reorder-policy`, `supplier-selection`, `forecasting`.
> - Swapped `LEGACY_PROMPT` (402 lines) → `SHORT_PROMPT` (15 lines).
> - `wants_forecaster = True` — delegates the genuinely open-ended forecast to a subagent, while the template/sort "subagents" became skills or code.

## Key files

- `agents/starter/agent.py` — YOUR working copy (the CMA config you edit)
- `agents/before/` — the original, read-only, runs on the raw Messages API
- `.claude/skills/*/SKILL.md` — the 5 skills (~400 lines total)
- `evals/` — 12 tasks + graders + CLI; transcripts in `evals/reports/<timestamp>/`

## Concepts demonstrated

- [[Tool vs Skill vs Subagent]]
- [[Eval-Driven Development]]
- [[Managed Agents]] — CMA vs the raw Messages API, side by side

## Related

- Previous: [[Agent Battle]]
- Next: [[Eval-Driven Agent Development]] — go deeper on the graders themselves.
- Facilitator notes: [[Facilitator Guide]]
