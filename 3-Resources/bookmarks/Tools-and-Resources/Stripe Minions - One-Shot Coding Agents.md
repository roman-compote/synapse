---
tags:
  - "#coding-agents"
  - "#ai-coding"
  - "#stripe"
  - "#mcp"
  - "#agentic-coding"
  - "#bookmark"
type: bookmark
source: "https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents"
captured: 2026-03-26
status: processed
---

# Stripe Minions: One-Shot End-to-End Coding Agents

**URL:** [Read](https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents)
**Authors:** Stripe Engineering
**Date Published:** 2026-03 (approx)
**Captured:** 2026-03-26

---

## Summary

Stripe's proprietary unattended coding agent system. Over 1,000 PRs merged weekly that are entirely agent-produced (human-reviewed, zero human-written code). One-shot workflow: Slack message to pull request with zero human interaction during execution. Built on customized fork of Block's "goose" agent, operating in isolated devboxes with 400+ MCP tools.

---

## Key Points

1. **1,000+ PRs/week**: Entirely agent-produced, human-reviewed only
2. **One-shot workflow**: Slack message in, PR out, no human interaction during execution
3. **Architecture**: Custom fork of "goose" agent + isolated devboxes + 400+ MCP tools via "Toolshed"
4. **Scale**: Operates within hundreds of millions of LOC, handles $1T+ annual payment volume
5. **Limits**: Max two rounds of CI, human review mandatory, diminishing returns on iteration
6. **Meta-programming paradigm**: Engineers define intent and review output instead of writing code

---

## Relevance

Represents the bleeding edge of the agentic coding paradigm — fundamentally different from Copilot-style autocomplete. Key example in [[3-Resources/articles/Opinion/ai-developer-productivity-critical-analysis|AI Developer Productivity Critical Analysis]] demonstrating the shift from "AI-assisted coding" to "agent-orchestrated coding."

---

## Related Concepts

- [[3-Resources/articles/Opinion/ai-developer-productivity-critical-analysis]] - Referenced as paradigm shift example
- [[3-Resources/techniques/agents/building-coding-agents]] - Agent development patterns
- [[5-Meta/MOCs/Coding-Assistants-MOC]] - Coding assistant landscape

---

- **Category:** Tools and Resources
- **Priority:** High
- **Content Type:** Technical / Opinion

**Captured:** 2026-03-26
**Processed:** 2026-03-26
**Status:** Processed
