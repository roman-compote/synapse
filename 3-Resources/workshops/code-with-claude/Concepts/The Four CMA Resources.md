---
type: concept
category: agents
tags:
  - "#cwc"
  - "#agents"
  - "#managed-agents"
  - "#concept"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# The Four CMA Resources

## Summary

> [!abstract]
> Every Managed Agent is assembled from four resources in a fixed dependency order — **Agent → Environment → Session → Events** — and once you can name them, the whole API stops looking like magic.

## Description

The four resources map one-to-one onto the API calls you make. They build on each other: you can't start a Session without an Agent and an Environment, and Events only exist inside a Session.

## Diagram

![[cma-resources.excalidraw]]

## How it works

| # | Resource | What it is | The call |
|---|----------|-----------|----------|
| 1 | **Agent** | The config: `model`, `system` prompt, `tools`/skills | `client.beta.agents.create` |
| 2 | **Environment** | The sandbox definition + any resources (files) mounted into it | `client.beta.environments.create` |
| 3 | **Session** | One run of the agent in an environment | `client.beta.sessions.create` |
| 4 | **Events** | Messages + tool calls streaming in and out | `sessions.events.stream` / `.send` |

Two things worth internalising:

- **State is hosted.** `sessions.list()` and `events.list()` replay any past run — there's no database on your side. Pick an old session from a dropdown and the whole transcript reloads.
- **The sandbox is real compute.** The agent writes and runs Python/Bash in a container you never provisioned. That's how it greps a 70k-line log without you streaming the log through the model.

## Examples

- **[[Ship Your First Managed Agent|Lab 1]]** builds exactly these four, one function per call — `setup_agent()`, `setup_environment()`, `start_session()`, `stream_reply()` — plus `upload_log()` (a resource for the environment) and `delete_session()` (cleanup).
- **[[Agent Decomposition|Lab 3]]**'s `uv run deploy` creates/updates the Agent + Environment; every `stockpilot` command opens a Session you can then inspect in the Console.

## Related Concepts

- [[Managed Agents]]
- [[Tool vs Skill vs Subagent]]

## References

- Lab: [[Ship Your First Managed Agent]]
- Docs: [Managed Agents quickstart](https://platform.claude.com/docs/en/managed-agents/quickstart)
