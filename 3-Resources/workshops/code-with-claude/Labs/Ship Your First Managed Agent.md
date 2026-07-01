---
type: exercise
lab: 1
module: ship-your-first-managed-agent
stack: [Python, Streamlit, Managed Agents API]
level: beginner
duration: ~45 min
tags:
  - "#cwc"
  - "#lab"
  - "#managed-agents"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Lab 1 — Ship Your First Managed Agent

## Summary

> [!abstract]
> Bring an offline "SRE Agent" chat panel online by implementing **seven small functions** — each a single Managed Agents API call. When it works, you ask *"what caused the latency spike?"* and it greps a 70,000-line log in its own cloud sandbox, calls tools on your laptop, correlates timestamps, and names the bad commit.

## Learning objective

Feel the **[[The Four CMA Resources|four Managed Agents resources]]** — Agent → Environment → Session → Events — by building each one. This is the foundation the rest of the workshop stands on.

## Tech stack

- **Language:** Python 3.10+
- **SDK:** `anthropic` (Managed Agents beta)
- **UI:** Streamlit incident dashboard (provided)
- **Scenario:** a fictional e-commerce outage; `data/` ships a 70k-line log + metrics + deploys + the offending diff.

## How to run

**Prerequisites:** Python 3.10+ and an [Anthropic API key](https://console.anthropic.com/settings/keys). See [[Setup]].

```bash
git clone https://github.com/anthropics/cwc-workshops
cd cwc-workshops/ship-your-first-managed-agent

python -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env                                  # add ANTHROPIC_API_KEY
streamlit run app.py                                  # dashboard at localhost:8501
```

The dashboard opens with the SRE Agent panel saying *"agent offline — implement `setup_agent()`."* That's your cue.

## What you build

Open **`agent.py`** — seven functions, each `raise NotImplementedError`. Fill them in and the panel comes online one step at a time (~34 lines total):

| # | Function | API call | Lines |
|---|----------|----------|-------|
| 1 | `setup_agent()` | `client.beta.agents.create` | 3 |
| 2 | `setup_environment()` | `client.beta.environments.create` | 4 |
| 3 | `upload_log()` | `client.beta.files.upload` | 2 |
| 4 | `start_session()` | `client.beta.sessions.create` | 5 |
| 5 | `stream_reply()` | `sessions.events.stream` + `.send` | 12 |
| 6 | `handle_tool()` | runs **locally** — reads `data/*.json` | 7 |
| 7 | `delete_session()` | `client.beta.sessions.delete` | 1 |

Everything else — system prompt, tool schemas, chat UI, session picker — is in `provided.py`. Stuck? `agent_complete.py` has the finished versions, and `e2e.py` runs the whole path headless.

## Expected result

Ask the panel *"what caused the latency spike?"* It greps `app.log` in its sandbox, calls `get_metrics` / `get_recent_deploys` / `get_diff` (which run on **your** machine), correlates the timeline, and names commit **`a3f9c21`** — an N+1 query shipped to checkout at 14:31:18 UTC. The session dropdown replays any past run via `sessions.list()` / `events.list()` — no database of your own.

> [!tip] The teaching moment
> Step 6 is the "aha": the agent reasons in the cloud, but its tool calls are fulfilled on your laptop over the event stream. Swap the mock JSON for a Datadog client and the same agent is production.

## Key files

- `agent.py` — the only file you edit
- `agent_complete.py` — reference implementation
- `provided.py` — system prompt, tool schemas, chat UI, session picker
- `data/` — `app.log` (70k lines) + `metrics.json` / `deploys.json` / `diff.txt`

## Concepts demonstrated

- [[The Four CMA Resources]]
- [[Managed Agents]] — sandboxed code execution + custom tools bridging to your machine

## Related

- Next: [[Agent Battle]] — now tune an agent's config instead of building one.
- Facilitator notes: [[Facilitator Guide]]
