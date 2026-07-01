#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Agents That Remember — Memory stores & Dreaming — live-demo walkthrough
# Code with Claude 2026 · Workshop W3 · companion to Labs/Agents That Remember.md
#
# A single-terminal, paced walkthrough of the three acts:
#   1. Amnesia   — two sessions, no memory → the agent forgets
#   2. Memory    — attach a memory store → it remembers across sessions
#   3. Dreaming  — consolidate transcripts into a NEW store → it recalls
#                  facts from sessions it never took part in
#
# This wraps the preview `ant` CLI. It does NOT replace the upstream lab —
# it drives the exact same commands, paced with talking points, so you can
# run it on a projector and hit Enter between beats.
#
# Prerequisites (see Setup.md):
#   - Research-preview access to Dreaming (org opted in)
#   - The upstream repo cloned and bootstrapped:
#       git clone https://github.com/anthropics/cwc-workshops
#       cd cwc-workshops/agents-that-remember
#       cp .env.example .env    # add ANTHROPIC_API_KEY
#       ./scripts/bootstrap.sh  # downloads ./ant, seeds AGENT/ENV/HIST1..3
#       source .bootstrap-vars  # exports PATH, AGENT, ENV, HIST1/2/3
#   - jq
#
# Then run this script from inside cwc-workshops/agents-that-remember:
#       /path/to/dreaming-walkthrough.sh
#
# Tips:
#   AUTO=1   ./dreaming-walkthrough.sh   # don't wait for Enter between beats
#   DREAM_MODEL=claude-opus-4-8 ./dreaming-walkthrough.sh   # override model
# ---------------------------------------------------------------------------
set -euo pipefail

DREAM_MODEL="${DREAM_MODEL:-claude-opus-4-7}"   # also valid: claude-opus-4-8, claude-sonnet-4-6

# --- pretty helpers --------------------------------------------------------
bold=$'\033[1m'; dim=$'\033[2m'; cyan=$'\033[36m'; green=$'\033[32m'; reset=$'\033[0m'

banner() { printf '\n%s\n%s%s%s\n%s\n' "════════════════════════════════════════════════════════════" "$bold" "$1" "$reset" "════════════════════════════════════════════════════════════"; }
note()   { printf '%s› %s%s\n' "$cyan" "$1" "$reset"; }
say()    { printf '%s  %s%s\n' "$dim" "$1" "$reset"; }        # talking point / narration
run()    { printf '%s$ %s%s\n' "$green" "$1" "$reset"; }      # echo the command we are about to run

pause() {
  [[ "${AUTO:-0}" == "1" ]] && return 0
  printf '\n%s   ⏎ Enter to continue…%s' "$dim" "$reset"; read -r _
}

# --- preflight -------------------------------------------------------------
command -v ant >/dev/null || { echo "ant CLI not on PATH — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'" >&2; exit 1; }
command -v jq  >/dev/null || { echo "jq not found — brew install jq (or apt-get install jq)" >&2; exit 1; }
: "${ANTHROPIC_API_KEY:?ANTHROPIC_API_KEY must be set (source .env or .bootstrap-vars)}"
: "${AGENT:?AGENT not set — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'}"
: "${ENV:?ENV not set — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'}"
: "${HIST1:?HIST1 not set — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'}"
: "${HIST2:?HIST2 not set — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'}"
: "${HIST3:?HIST3 not set — run ./scripts/bootstrap.sh then 'source .bootstrap-vars'}"
ant beta:dreams --help >/dev/null 2>&1 || { echo "this ant build lacks beta:dreams — are you opted into the research preview?" >&2; exit 1; }

# The two things we tell the agent, and the recall question we ask it.
FACT="I attended the CMA talk yesterday at noon — I learned that multi-agent orchestration, outcomes, memory are launching, and dreaming is launching to research preview. I took notes and uploaded them to https://example.com/notes/cma."
ASK="What features did they announce at the CMA talk? Give me the go link for my notes."

# --- primitives ------------------------------------------------------------
# Poll a session until it goes idle (finished replying).
wait_idle() {
  local ses="$1" i
  for i in $(seq 1 90); do
    [[ "$(ant beta:sessions retrieve --session-id "$ses" --format json | jq -r .status)" == "idle" ]] && return 0
    sleep 2
  done
  echo "  ! timed out waiting for $ses to go idle; continuing anyway" >&2
}

# Create a session (optional 3rd arg = --resource JSON) and echo its id.
new_session() {
  local title="$1" resource="${2:-}"
  if [[ -n "$resource" ]]; then
    ant beta:sessions create --agent "$AGENT" --environment-id "$ENV" \
      --title "$title" --resource "$resource" --format json | jq -r .id
  else
    ant beta:sessions create --agent "$AGENT" --environment-id "$ENV" \
      --title "$title" --format json | jq -r .id
  fi
}

# Ask a session something: live-stream the reply in the background, send the
# message, wait for idle, then stop the stream. Single-terminal friendly.
ask() {
  local ses="$1" text="$2"
  ant beta:sessions:events stream --session-id "$ses" --max-items -1 --format pretty &
  local stream_pid=$!
  ant beta:sessions:events send --session-id "$ses" \
    --event "$(jq -nc --arg t "$text" '{type:"user.message",content:[{type:"text",text:$t}]}')" >/dev/null
  wait_idle "$ses"
  sleep 1
  kill "$stream_pid" 2>/dev/null || true
  wait "$stream_pid" 2>/dev/null || true
}

# ===========================================================================
banner "ACT 0 · Setup check"
note "Agent:        $AGENT"
note "Environment:  $ENV"
note "History:      $HIST1  $HIST2  $HIST3"
note "Dream model:  $DREAM_MODEL"
say  "Open the Console alongside this terminal: https://platform.claude.com/"
say  "Three seeded 'historical' sessions already exist — Dreaming will mine them later."
pause

# ===========================================================================
banner "ACT 1 · Amnesia — sessions are isolated by design"
say "We tell session A a fact, then ask session B about it. No memory attached."
pause

note "Session A — tell the agent what we attended"
SES_A=$(new_session "Write test (no memory)")
run "ask \$SES_A  \"${FACT}\""
ask "$SES_A" "$FACT"
pause

note "Session B — a brand-new session asks about it"
SES_B=$(new_session "Recall test (no memory)")
run "ask \$SES_B  \"${ASK}\""
ask "$SES_B" "$ASK"
say "☝️  No idea. Sessions are silos — nothing persists. This is the 'goldfish' baseline."
pause

# ===========================================================================
banner "ACT 2 · Memory store — cross-session persistence"
say "A memory store is a persistent read/write filesystem we mount into sessions."
say "Attach the SAME store to two sessions → they share memory."
pause

note "Create the memory store"
run "ant beta:memory-stores create --name cwc-memory ..."
MEM=$(ant beta:memory-stores create --name "cwc-memory" \
  --description "My CwC attendance and resources" --format json | jq -r .id)
note "MEM=$MEM"
say "The 'prompt' field below steers HOW the agent uses the store — the lever you iterate on."
MEM_RESOURCE=$(jq -nc --arg id "$MEM" \
  '{type:"memory_store",memory_store_id:$id,prompt:"Track which CwC sessions I have attended, resource links I mention, and anything I flag to follow up on.",access:"read_write"}')
pause

note "Session C — tell it the fact, WITH the store attached (it writes a memory)"
SES_C=$(new_session "Attended — CMA talk (with memory)" "$MEM_RESOURCE")
ask "$SES_C" "$FACT"
pause

note "Session D — new session, SAME store attached, ask again"
SES_D=$(new_session "Recall test (with memory)" "$MEM_RESOURCE")
ask "$SES_D" "$ASK"
say "☝️  Now it remembers — and returns the go-link. Cross-session state, live and cheap."
pause

note "Peek at what the agent chose to write"
run "ant beta:memory-stores:memories list --memory-store-id \$MEM"
ant beta:memory-stores:memories list --memory-store-id "$MEM" || true
say "Try changing the 'prompt' and rerunning — the file structure the agent writes changes."
pause

# ===========================================================================
banner "ACT 3 · Dreaming — consolidate transcripts into a NEW store"
say "A dream reads an existing store + past session transcripts, runs a model over"
say "them, and writes a fresh, reorganized store: dupes merged, stale entries fixed,"
say "new insights surfaced. Inputs are never modified. Async — minutes to tens of minutes."
pause

note "Start the dream over the store + historical + recent sessions"
run "ant beta:dreams create --model $DREAM_MODEL --input {memory_store} --input {sessions} --instructions ..."
DREAM=$(ant beta:dreams create \
  --model "$DREAM_MODEL" \
  --input "$(jq -nc --arg id "$MEM" '{type:"memory_store",memory_store_id:$id}')" \
  --input "$(jq -nc --argjson s "[\"$HIST1\",\"$HIST2\",\"$HIST3\",\"$SES_C\",\"$SES_D\"]" '{type:"sessions",session_ids:$s}')" \
  --instructions "I am attending CwC, and I want to remember what I've learned." \
  --format json | jq -r .id)
note "DREAM=$DREAM"
say "Watch live in the Console → Dreams. Follow the dream's session_id to stream what"
say "it reads and writes in real time."
pause

note "Poll until the dream reaches a terminal state"
while :; do
  STATUS=$(ant beta:dreams retrieve --dream-id "$DREAM" --format json | jq -r .status)
  printf '   status=%s\n' "$STATUS"
  [[ "$STATUS" == "pending" || "$STATUS" == "running" ]] || break
  sleep 10
done
[[ "$STATUS" == "completed" ]] || { echo "dream ended as '$STATUS' — inspect with: ant beta:dreams retrieve --dream-id $DREAM --format json" >&2; exit 1; }
pause

note "Grab the NEW output store the dream produced"
MEM_OUT=$(ant beta:dreams retrieve --dream-id "$DREAM" --format json \
  | jq -r '.outputs[] | select(.type=="memory_store") | .memory_store_id')
note "MEM_OUT=$MEM_OUT"
run "ant beta:memory-stores:memories list --memory-store-id \$MEM_OUT"
ant beta:memory-stores:memories list --memory-store-id "$MEM_OUT" || true
say "Open both stores in the Console side by side — see how Dreaming reorganized things."
pause

note "Swap the dreamed store into a fresh session and ask for a recap"
SES_E=$(new_session "Post-dreaming recall" \
  "$(jq -nc --arg id "$MEM_OUT" '{type:"memory_store",memory_store_id:$id}')")
ask "$SES_E" "Give me a recap: which sessions have I attended, what resources do I have links for, and what follow-ups did I flag?"
say "☝️  THE PAYOFF: it recalls facts from the historical sessions it never took part in."
say "     Dreaming consolidated those transcripts into the store it now reads. Goldfish → colleague."
pause

# ===========================================================================
banner "Done · cleanup (optional)"
say "Retire the pre-dream store if you want the dreamed one to be canonical:"
run "ant beta:memory-stores archive --memory-store-id $MEM"
say "Archive the dream itself (keeps it readable by id, hides from default lists):"
run "ant beta:dreams archive --dream-id $DREAM"
printf '\n%sIDs from this run:%s\n  MEM=%s\n  MEM_OUT=%s\n  DREAM=%s\n' "$bold" "$reset" "$MEM" "$MEM_OUT" "$DREAM"
