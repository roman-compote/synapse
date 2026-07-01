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

# Managed Agents

## Summary

> [!abstract]
> A **Claude Managed Agent (CMA)** is an agent that Anthropic hosts and runs for you — the model loop, a code-execution sandbox, and all session state live on Anthropic's servers, so you configure the agent instead of operating the infrastructure.

## Description

If you've built an agent with the raw Messages API, you wrote the loop yourself: send a message, get a tool call back, run the tool, append the result, send again — plus you owned the sandbox, the retries, and wherever the conversation history was stored.

**Managed Agents move that loop into Anthropic's cloud.** You declare *what the agent is* (a model, a system prompt, a set of tools/skills) and *where it runs* (an environment with a sandbox and mounted resources). Anthropic runs the turns, executes the agent's code in a container it provisions, and keeps the transcript. You talk to it through an event stream.

The practical upshot for the workshop: every lab is mostly **configuration**, not plumbing. That's why an agent that greps a 70k-line log ([[Ship Your First Managed Agent|Lab 1]]) is ~34 lines of your code.

## Why it matters

- **Less to operate.** No loop, no sandbox to secure, no session database — the boundary is production-grade out of the box.
- **The levers are the point.** When infra is handled, the interesting decisions become model choice, prompt, and [[Tool vs Skill vs Subagent|how you compose tools/skills/subagents]].
- **It's the substrate for the newer capabilities** shown at CWC London — multi-agent orchestration, Outcomes, and [[Memory and Dreaming|Dreaming]] all sit on top of Managed Agents (see [[CWC London — What Anthropic Presented]]).

## How it works

You create four resources in dependency order — see **[[The Four CMA Resources]]**:

1. **Agent** — the config: model + system prompt + tools.
2. **Environment** — the sandbox and any files/resources mounted into it.
3. **Session** — one run of the agent inside an environment.
4. **Events** — the messages and tool calls streaming in and out of that session.

Custom tools are interesting: the agent runs in the cloud, but a tool call can be fulfilled by **your** machine over the event stream. Swap the mock handler for a real client and the same agent is production.

## Examples

- **CMA vs Messages API** — [[Agent Decomposition|Lab 3]] runs the *before* agent on the raw Messages API and the decomposed agent on CMA, so you can feel the difference.
- **Custom tools bridging to your laptop** — [[Ship Your First Managed Agent|Lab 1]]'s `handle_tool()` reads local JSON while the agent reasons in the cloud.

## Related Concepts

- [[The Four CMA Resources]]
- [[Tool vs Skill vs Subagent]]
- [[Eval-Driven Development]]
- [[Memory and Dreaming]]

## References

- Briefing: [[CWC London — What Anthropic Presented]]
- Labs: [[Ship Your First Managed Agent]] · [[Agent Battle]] · [[Agent Decomposition]] · [[Eval-Driven Agent Development]]
- Docs: [Managed Agents overview](https://platform.claude.com/docs/en/managed-agents/overview)
