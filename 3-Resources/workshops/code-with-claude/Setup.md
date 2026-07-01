---
type: guide
tags:
  - "#cwc"
  - "#setup"
status: published
date: 2026-07-01
last_updated: 2026-07-01
---

# Setup

> [!abstract]
> One-time prep before the workshop. Two parts: (A) view these notes properly in Obsidian, and (B) install the toolchain for whichever labs you'll run.

## A. View this vault (Obsidian plugins)

The diagrams are Excalidraw and the deck is Marp. Both need a one-time community-plugin install. In Obsidian:

1. **Settings → Community plugins → Turn on community plugins** (accept the safety notice).
2. **Browse** → install & enable **Excalidraw** (by zsviczian) — renders the `.excalidraw` files.
3. **Browse** → install & enable a **Marp** plugin (e.g. *Marp Slides* / *Obsidian Marp*) — previews [[Code with Claude — Workshop Deck|the deck]].
4. Reopen [[Start Here]] — the roadmap diagram should render inline.

> [!note] Reading without plugins
> The notes are plain Markdown and stay readable without any plugins — you just won't see the diagrams rendered, and the deck shows as Markdown. The plugins travel with the vault once installed, so colleagues who sync/open the vault get them too.
>
> **Alternative for the deck:** the Marp file is standard [Marp](https://marp.app) Markdown — you can also present/export it with the Marp CLI or the VS Code Marp extension (`marp deck.md --pdf`).

## B. Toolchain per lab

Everything runs against the public repo:

```bash
git clone https://github.com/anthropics/cwc-workshops
```

### Shared: Anthropic API key

Get a key from the [Anthropic Console](https://console.anthropic.com/settings/keys) and set `ANTHROPIC_API_KEY`.

> [!warning] Beta / preview access
> Managed Agents is a beta; the four labs need it enabled on your key. **[[Memory and Dreaming|Dreaming]]** (theory only here) is a **research preview** and needs your org opted in. If a deploy prints a `preview unavailable` note, that feature isn't enabled for your key — usually harmless for these labs.

### Per-lab requirements

| Lab | Needs |
|---|---|
| [[Ship Your First Managed Agent\|Lab 1]] | Python 3.10+, `pip`; port 8501 (Streamlit) |
| [[Agent Battle\|Lab 2]] | Python 3, Node.js, **Java 21+**, free ports 8088 & 3007; optional Claude Code for `/cwc-setup` |
| [[Agent Decomposition\|Lab 3]] | Python 3.10+, [`uv`](https://docs.astral.sh/uv/) |
| [[Eval-Driven Agent Development\|Lab 4]] | Node.js **≥22**, **Docker**, `ant` CLI (`brew install anthropics/tap/ant`), `jq` |
| [[Bonus — Long-Running Agents Harness\|Bonus]] | Claude Code |

### Quick verification

```bash
python --version     # 3.10+
node --version       # v22+ (Lab 4)
java -version        # 21+ (Lab 2)
uv --version         # Lab 3
docker ps            # Lab 4 — should not error
ant --version        # Lab 4
echo $ANTHROPIC_API_KEY   # set
```

## Recommended order

Do **Lab 1** first (it grounds [[The Four CMA Resources]]); the others are independent. If a colleague only has 90 minutes: Briefing → Lab 1 → Lab 2.

## Related

- [[Start Here]] · [[Facilitator Guide]]
