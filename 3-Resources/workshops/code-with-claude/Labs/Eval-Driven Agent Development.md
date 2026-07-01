---
type: exercise
lab: 4
module: eval-driven-agent-development
stack: [Node.js, TypeScript, Docker, ant CLI, Managed Agents API]
level: advanced
duration: variable
tags:
  - "#cwc"
  - "#lab"
  - "#managed-agents"
  - "#evals"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Lab 4 — Eval-Driven Development

## Summary

> [!abstract]
> Build an eval for a Managed Agent that generates slide decks, then iterate the agent against it. A **two-layer grader** — programmatic `.pptx` XML metrics + LLM-as-judge on the *rendered* slides — turns "this deck looks better" into a scorecard you can trust.

## Learning objective

Make **[[Eval-Driven Development|eval-driven development]]** concrete: design graders, record a baseline, change one thing, and read what the eval reveals (including regressions a glance would miss).

## Tech stack

- **Language:** Node.js ≥22 + TypeScript
- **CLI:** `ant` (Managed Agents)
- **Rendering:** Docker (LibreOffice in a container) → per-slide JPGs
- **Grading:** declarative graders (structural metrics + LLM judge)

## How to run

**Prerequisites:** Node ≥22, `ant` CLI, Docker, `ANTHROPIC_API_KEY`. See [[Setup]].

```bash
git clone https://github.com/anthropics/cwc-workshops
cd cwc-workshops/eval-driven-agent-development
npm install
export ANTHROPIC_API_KEY=sk-ant-...
docker build -t cwc-pptx-render .          # LibreOffice image for the grader (run early; ~5 min)
```

Create the cloud resources, then paste the returned IDs into `src/create-slides.ts` (`ENVIRONMENT_ID`, `AGENT_ID`):

```bash
ant beta:environments create < resources/workshop-pptx.environment.yaml
ant beta:agents create        < resources/agent.yaml
```

The iteration loop (per task, e.g. `technology`):

```bash
npm run create-slides -- technology        # agent runs, downloads the .pptx  (~30s)
npm run render        -- technology        # .pptx → per-slide JPGs via Docker
npm run eval          -- technology        # programmatic checks + LLM judge
npm run eval          -- --all --baseline  # first time: record the baseline
npm run show-baseline                       # show stored baseline anytime
```

## The two layers

1. **Programmatic** (`src/parse-pptx.ts` → `src/graders.ts`): parse the `.pptx` XML for emoji count, image coverage, shape density, text density. Deterministic, free, objective.
2. **LLM-as-judge**: score overall design quality on the *rendered* image — the stuff code can't see.

Record a **baseline** first; every later run shows a delta. Iterate the agent through variants (naive → visual → typography → palette → density → QA-loop) and watch specific metrics move:

- **naive** — ~13 emojis, no images, dense layout
- **remove emojis** — emoji metric → 0, but "dense" unchanged
- **add diagrams** — image coverage → 100%, image score jumps, shapes normalise
- **model swap** — Opus scores highest on text/layout/colour but worst on structure at ~5× cost — exactly the tradeoff evals exist to surface

## Reference solution

> [!success] Roman's setup
> Deployed the baseline PPTX agent from `resources/agent.yaml` with `model: claude-sonnet-4-6` (agent id + `version` pasted back into the YAML and into `src/create-slides.ts`, per the workshop's `ant create` → paste-id flow). This is the "naive" round — the starting point you iterate *away* from using the scorecard. The evolved variants live in `solutions/` (don't peek unless stuck; copy prompt changes into `resources/agent.yaml` and iterate there).

## Key files

- `resources/agent.yaml` — the agent config you iterate
- `src/graders.ts` — declarative grader definitions (the eval rubric; add graders here)
- `src/parse-pptx.ts` — structural metrics extractor
- `src/eval-runner.ts` — the harness (don't modify during the workshop)
- `tasks.json` — the task prompts; `runs/` — outputs per task

## Concepts demonstrated

- [[Eval-Driven Development]]
- [[Managed Agents]]

## Related

- Previous: [[Agent Decomposition]]
- Bonus: [[Bonus — Long-Running Agents Harness]]
- Facilitator notes: [[Facilitator Guide]]
