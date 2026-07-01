---
type: exercise
lab: 2
module: agent-battle
stack: [Python, Node.js, Java, Managed Agents API, MCP]
level: intermediate
duration: ~45 min
tags:
  - "#cwc"
  - "#lab"
  - "#managed-agents"
  - "#mcp"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Lab 2 — Agent Battle

## Summary

> [!abstract]
> A 45-minute competition: configure a Managed Agent — model, system prompt, skills, MCP tools — that drives a local Minecraft bot to mine diamonds. Most diamonds in a 5-minute run wins; **fewest tokens breaks ties**. A fast `--eval` probe lets you test a config idea in ~30s before committing to a full run.

## Learning objective

Feel how the **configuration levers** interact — the same four things you'll set on any Managed Agent: `model`, `system`, `skills`, and MCP `mcp_servers`. The tiebreaker (tokens) teaches efficiency, not just capability.

## Tech stack

- **Config:** Python (`my_agent.py` — the `AGENT = dict(...)` block is your whole interface)
- **Infra (provided):** Node.js mineflayer bot + Java Minecraft server + a wiki MCP server + a live leaderboard
- **Platform:** Managed Agents + MCP

## How to run

**Prerequisites:** `ANTHROPIC_API_KEY`, Java 21+, Node.js, free ports 8088/3007. See [[Setup]]. (Not affiliated with / endorsed by Microsoft or Mojang.)

```bash
git clone https://github.com/anthropics/cwc-workshops
cd cwc-workshops/agent-battle

export ANTHROPIC_API_KEY="sk-ant-..."
export PARTICIPANT="<your-unique-name>"
export MINECRAFT_EULA=accept              # you've read https://www.minecraft.net/eula

claude --permission-mode acceptEdits      # then type /cwc-setup   (no Claude Code? run ./setup.sh)
```

`/cwc-setup` installs deps and starts the server + bot + tunnel, ending with `▸ ready` (~90s cold, ~25s warm). Then:

```bash
python3 my_agent.py            # a full 5-min run; posts to the leaderboard; watch localhost:8088/view
python3 my_agent.py --eval     # ~30-60s decision probes — the fast feedback loop
```

Only your **best** 5-minute run counts; runs don't sum. Iterate: edit `my_agent.py` → re-run. If anything breaks, `/cwc-fix` or `./setup.sh --restart && rm -f .agent_cache.json`.

## The levers (and their traps)

- **`model`** — Haiku is faster/cheaper → more turns in 300s; a bigger model reasons better per turn but costs more.
- **`system`** — a few targeted lines usually beat a long AI-written prompt (which loses on the token tiebreaker).
- **`skills`** — attaching `SKILL_MINING` adds knowledge every turn (costs tokens continuously).
- **MCP (`mcp_servers`)** — attaching the wiki MCP costs nothing until called — but the agent won't call `lookup()` unless your prompt nudges it. *Real lesson in agent composition.*

## Reference solution

> [!success] Roman's working config (`my_agent.py`)
> A minimal, token-efficient setup that scored well:
> ```python
> AGENT = dict(
>     model  = "claude-haiku-4-5",      # faster + cheaper → more turns in 300s
>     system = (
>         "Avoid lava; never dig straight down past y=-55. "
>         "If a tool call fails, try something different. "
>         "Use wiki.lookup for facts you don't know."
>     ),
>     skills      = [SKILL_MINING],
>     mcp_servers = [MCP_MINECRAFT_WIKI],
> )
> ALLOWED_TOOLS = ["mine_block", "place_block", "equip",
>                  "go_near", "craft_item", "get_state"]
> ```
> Note the prompt explicitly tells the agent to use `wiki.lookup` — without that nudge the MCP tool sits unused. Restricting `ALLOWED_TOOLS` trims token overhead. (Heads-up: the CMA API restricts a toolset by setting the toolset default to `enabled: false` and enabling named tools individually, not via a flat `allowed_tools` list — see Roman's `_build_spec` edit.)

## Key files

- `my_agent.py` — the `AGENT = dict(...)` block; the `# ===== EDIT THESE =====` section at ~line 50 is the whole control panel
- `skills/mining/SKILL.md` — the opt-in skill (editable if attached)
- `harness/probes.py` — what `--eval` actually tests (read-only)
- Out of bounds: `bot/`, `harness/`, `leaderboard/`, `wiki_mcp.py`, `setup.sh`

## Concepts demonstrated

- [[Managed Agents]] — the config surface
- [[Tool vs Skill vs Subagent]] — skill (always-on) vs MCP (pay-per-call)

## Related

- Previous: [[Ship Your First Managed Agent]]
- Next: [[Agent Decomposition]] — when a config grows too big, decompose it.
- Facilitator notes: [[Facilitator Guide]]
