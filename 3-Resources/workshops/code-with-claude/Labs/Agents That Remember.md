---
type: exercise
lab: 5
module: agents-that-remember
stack: [Shell, ant CLI, Managed Agents API, Console]
level: intermediate
duration: ~45 min
preview: dreaming (research preview)
tags:
  - "#cwc"
  - "#lab"
  - "#managed-agents"
  - "#memory"
  - "#dreaming"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Lab 5 — Agents That Remember (Memory & Dreaming)

## Summary

> [!abstract]
> Take a Managed Agent from **goldfish to colleague** in three acts. Start with an agent that visibly forgets across sessions, attach a **memory store** so it remembers, then run **Dreaming** — a batch job that reads past transcripts and writes a *new, consolidated* store — until the agent can recall facts from sessions it never took part in. This is the hands-on companion to the [[Memory and Dreaming]] concept.

> [!warning] Research-preview access required
> **Dreaming is a research preview.** Your org must be opted in ([request access](https://claude.com/form/claude-managed-agents)). Acts 1–2 (memory stores) work on the standard Managed Agents beta; **Act 3 (Dreaming)** needs the preview. If `ant beta:dreams --help` errors, you're not opted in yet.

## Learning objective

Feel the three points on the persistence spectrum and know which lever to reach for when *your* agent forgets:

```
   cheap, live  ◀──────────────────────────────────────▶  batch, distilled

   SESSION                 MEMORY STORE              DREAMING
   isolated context,       persistent FS the         reads transcripts,
   nothing persists        agent reads/writes        writes a NEW store —
   (the "goldfish")        across sessions           consolidated recall
```

## How it works

- **Session isolation** — every Managed Agent session starts clean. That's a feature (predictable, no leakage), but a useful colleague remembers last week. You can't just append history forever — it's a context-window problem.
- **Memory store** — a persistent, filesystem-like store you *mount into* a session at creation (`--resource '{"type":"memory_store",...}'`). The agent reads it at the start of a run and writes notes during it; the next session that mounts the same store sees them. A `prompt` field on the resource steers **how** the agent uses it (when to read, what to write, how to organize) — that's the lever you iterate on. Cheap and live.
- **Dreaming** — an asynchronous batch job. It takes **one pre-existing memory store** + **1–100 past sessions**, runs a model over them, and emits a **brand-new output store**: duplicates merged, stale/contradicted entries replaced with the latest value, new insights surfaced. **The inputs are never modified** — you review the output and keep it or throw it away. Optional `instructions` steer the synthesis (focus areas, what to preserve, output conventions). Costlier and slower (minutes to tens of minutes) — reach for it to distill a lot of history, e.g. run it overnight.

**Dream lifecycle:** `pending → running → completed` (or `failed` / `canceled`). Once `running`, the dream's `session_id` points at the session executing the pipeline — stream it to watch what it reads and writes. On `completed`, the new store's id is in `outputs[]`.

> [!note] This is a Claude **Platform / Managed Agents** feature — not the Claude Code CLI
> Despite how it was reported ("Claude Code dreaming"), you drive Dreaming from the **Console**, the API, or the preview `ant` CLI — the same place you played with it at the conference. It is *not* a command inside the Claude Code coding tool.

## How to run

**Prerequisites:** research-preview access, `jq`, an `ANTHROPIC_API_KEY`. See [[Setup]].

```bash
git clone https://github.com/anthropics/cwc-workshops
cd cwc-workshops/agents-that-remember
cp .env.example .env            # add your ANTHROPIC_API_KEY
./scripts/bootstrap.sh          # downloads ./ant, creates agent + env, seeds 3 history sessions
source .bootstrap-vars          # exports PATH, AGENT, ENV, HIST1/2/3
```

The bootstrap is idempotent — re-running reuses the agent/env by name and just adds fresh history sessions (which gives Dreaming more to chew on).

Then either **walk the script** (recommended for a live demo) or drive the steps by hand.

### Option A — the guided walkthrough script (recommended for demos)

A paced, single-terminal script that runs all three acts with talking points and pauses between beats — built for a projector:

```bash
# from inside cwc-workshops/agents-that-remember (after sourcing .bootstrap-vars).
# Point at the script in this vault — copy the path from Obsidian (right-click the
# script note → Copy path) or use your vault location, e.g.:
~/code/synapse/3-Resources/workshops/code-with-claude/_assets/scripts/dreaming-walkthrough.sh
```

- Hit **Enter** between beats; set `AUTO=1` to run non-stop.
- Override the model with `DREAM_MODEL=claude-opus-4-8` (also valid: `claude-opus-4-7`, `claude-sonnet-4-6`).
- It streams each reply live, waits for the agent to go idle, and prints the IDs it created at the end.

> The script *is* the upstream lab's commands, just paced. Read it before demoing so nothing surprises you on screen: [`_assets/scripts/dreaming-walkthrough.sh`](_assets/scripts/dreaming-walkthrough.sh).

### Option B — by hand (CLI or Console)

Every step below has a Console equivalent in the upstream [`agents-that-remember/README.md`](https://github.com/anthropics/cwc-workshops/tree/main/agents-that-remember) — good if you'd rather click than type on stage.

## The step-by-step scenario

The whole demo hangs on one fact and one question:

- **Fact (tell it):** *"I attended the CMA talk yesterday at noon — multi-agent orchestration, outcomes, and memory are launching, and dreaming is launching to research preview. Notes at https://example.com/notes/cma."*
- **Question (ask it):** *"What features did they announce at the CMA talk? Give me the go link for my notes."*

**Act 1 · Amnesia.** Tell session A the fact; ask session B the question — no store attached. Session B has no idea. *Talking point: sessions are silos by design; nothing persists.*

**Act 2 · Memory store.** Create a store, mount it (`access: read_write`, with a steering `prompt`) into a new pair of sessions. Now the recall session answers correctly and returns the go-link. Inspect what the agent wrote:
```bash
ant beta:memory-stores:memories list --memory-store-id "$MEM"
```
*Talking point: change the `prompt`, rerun, and watch the file structure the agent writes change.*

**Act 3 · Dreaming.** Run a dream over the store + the three historical sessions + your two new ones:
```bash
DREAM=$(ant beta:dreams create --model claude-opus-4-7 \
  --input "{\"type\":\"memory_store\",\"memory_store_id\":\"$MEM\"}" \
  --input "{\"type\":\"sessions\",\"session_ids\":[\"$HIST1\",\"$HIST2\",\"$HIST3\",\"$SES_C\",\"$SES_D\"]}" \
  --instructions "I am attending CwC, and I want to remember what I've learned." \
  --format json | jq -r .id)
```
Poll until `completed`, then pull the **new** output store and swap *it* into a fresh session:
```bash
MEM_OUT=$(ant beta:dreams retrieve --dream-id "$DREAM" --format json \
  | jq -r '.outputs[] | select(.type=="memory_store") | .memory_store_id')
```
Ask that session for a recap. **The payoff:** it recalls facts from the historical sessions it never participated in — Dreaming consolidated those transcripts into the store it now reads. *Goldfish → colleague.*

## Dreaming API — quick reference

| Action | CLI |
|---|---|
| Create | `ant beta:dreams create --model <m> --input <memory_store> --input <sessions> [--instructions "…"]` |
| Track | `ant beta:dreams retrieve --dream-id "$DREAM"` — poll `.status` |
| Watch live | stream the dream's `session_id` (Console → Dreams, or events stream) |
| Cancel | `ant beta:dreams cancel --dream-id "$DREAM"` |
| Archive | `ant beta:dreams archive --dream-id "$DREAM"` (terminal state only) |
| List | `ant beta:dreams list --limit 20` |

- **Inputs:** exactly one `memory_store` + 1–100 `sessions`. No existing store? Create an empty one and pass it.
- **Models (preview):** `claude-opus-4-8`, `claude-opus-4-7`, `claude-sonnet-4-6`.
- **Limits:** 100 sessions/dream; `instructions` ≤ 4,096 chars.
- **Billing:** standard API token rates for the chosen model; cost scales ~linearly with session count/length. Start small.
- **Beta headers:** `managed-agents-2026-04-01` **and** `dreaming-2026-04-21` (the SDK/CLI set these for you).
- **Safety:** inputs are never modified; the output store persists even on `failed`/`canceled` so you can inspect partial results.

## Teaching moments

> [!tip] Where each lever fits
> **Memory store** = "carry state across sessions *right now*." **Dreaming** = "reorganize/distill a pile of transcripts into better memory." One is live and cheap; the other is batch and considered.

- The `prompt`/`instructions` fields are the whole game — they're *synthesis guidance*, not line editors. "Focus on coding-style preferences" works; "change sentence 3" doesn't (use the Memory Stores API for surgical edits).
- Because the input store is untouched, Dreaming is safe to experiment with live — run it twice with different `instructions` and diff the two output stores in the Console.

## Key files (upstream repo)

- `agents-that-remember/README.md` — the full lab, with a Console path for every CLI step
- `agents-that-remember/scripts/bootstrap.sh` — downloads `ant`, creates the agent/env, seeds `HIST1/2/3`
- `agents-that-remember/.env.example` — just your `ANTHROPIC_API_KEY`
- **This vault:** [`_assets/scripts/dreaming-walkthrough.sh`](_assets/scripts/dreaming-walkthrough.sh) — the paced demo wrapper

## Concepts demonstrated

- [[Memory and Dreaming]] — the theory this lab makes concrete
- [[Managed Agents]] — memory and Dreaming are CMA primitives
- [[The Four CMA Resources]] — this builds on Agent → Environment → Session → Events
- [[Long-Running Agents]] — a different, Claude-Code-layer take on persistence

## References

- [Dreams — Claude Platform docs](https://platform.claude.com/docs/en/managed-agents/dreams)
- [Memory stores — Claude Platform docs](https://platform.claude.com/docs/en/managed-agents/memory)
- Repo module: [`anthropics/cwc-workshops` → `agents-that-remember/`](https://github.com/anthropics/cwc-workshops/tree/main/agents-that-remember)
- [Request research-preview access](https://claude.com/form/claude-managed-agents)
- Briefing: [[CWC London — What Anthropic Presented]]

## Related

- Previous: [[Eval-Driven Agent Development]] · Bonus: [[Bonus — Long-Running Agents Harness]]
- Facilitator notes: [[Facilitator Guide]]
