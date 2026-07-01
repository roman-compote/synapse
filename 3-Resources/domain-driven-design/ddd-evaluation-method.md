---
tags:
  - "#domain-driven-design"
  - "#ddd"
  - "#architecture"
  - "#evaluation"
  - "#method"
date: 2026-07-01
status: published
last_updated: 2026-07-01
---

# DDD Evaluation Method

A repeatable, well-founded method for evaluating the two highest-impact DDD artifact types — the **bounded-context set + context map** (strategic) and the **logical domain model** (tactical) — to produce prioritized, actionable, semantically valid feedback.

> This designs the *how* of a review; it is grounded in published DDD frameworks plus peer-reviewed conceptual-model-quality research. Companion notes: [[3-Resources/domain-driven-design/ddd-smells-catalog|DDD Smells Catalog]], [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]]. Operationalized as [[3-Resources/techniques/agents/adversarial-multi-stream-evaluation|Adversarial Multi-Stream Evaluation]].

---

## 1. Design principles for the method itself

These shape *how* you review, before *what* you review:

1. **Separate the two altitudes.** Bounded contexts + context map are *strategic* (boundaries, language, coupling). The domain model is *tactical* (aggregates, invariants, events). They fail differently and need different lenses — two distinct rubrics, then check the seam between them.
2. **Structural validation ≠ semantic validation.** A deterministic checker finds syntactic/referential defects only. The most valuable feedback is *semantic* — wrong boundary, mis-scoped invariant, missing concept — which only a domain-literate reviewer finds. In the source audit, the structural validator returned **0 violations while the semantic critic found defects in 10/10 bounded contexts.** Run both; never let the structural pass stand in for the semantic one.
3. **Adversarial verification.** Every load-bearing finding gets a second reviewer whose job is to *refute* it against the source files. A finding is "confirmed" only after an independent verifier checks it at line level. Default the verifier to skepticism.
4. **Score against named dimensions, not vibes.** Each dimension traces to an authoritative principle (§6). A 1–5 score with a one-line verifier-adjusted justification beats a prose impression.
5. **Right-sizing is a first-class dimension.** Over-modeling is as much a defect as under-modeling. Explicitly hunt for speculative/cuttable surface.
6. **Feedback must be actionable and prioritized.** Output = severity-ranked findings, each tied to a specific element ID and a concrete fix, split into quick-wins vs structural.

---

## 2. The toolkit (frameworks the method draws on)

**Strategic (bounded contexts / context map):**

| Framework | What it gives you |
|---|---|
| **Bounded Context Canvas v5** (DDD Crew) | Per-context review questions: naming coherence, interface too big, internals leaking, messages that belong elsewhere; *Open Questions = uncertainty signal*. |
| **Independent Service Heuristics** (Team Topologies) | Autonomy/cohesion checklist. The *Vocabulary* heuristic ("same word, different meaning → two services") and *Phases* heuristic (earlier/later phase of a neighbor → boundary candidate). |
| **Core Domain Charts** (DDD Crew) | Validate core/supporting/generic classification on complexity × differentiation. |
| **Context Mapper semantics** (Kapferer & Zimmermann) | 10 machine-checkable rules for invalid relationship-pattern combos (e.g. ACL+Conformist mutually exclusive; OHS/PL only upstream). |
| **Balanced Coupling** (Khononov) | Score each map edge by *integration strength × distance × volatility*; high-strength + high-distance = distributed-monolith smell. |
| **Domain Message Flow Modelling** (DDD Crew) | ~5–9 messages per scenario; excess = over-coupling. |
| **EventStorming** (Brandolini) | Hotspots & differing event wording as boundary/consensus lens. |
| **Team Topologies** | Cognitive-load sizing (≈2–3 simple or 1 complex domain per team). |

**Tactical (domain model):**

| Framework | What it gives you |
|---|---|
| **Vernon — Effective Aggregate Design** | The four rules: model true invariants in the consistency boundary; small aggregates; reference other aggregates by identity; one aggregate per transaction (cross-aggregate = eventual consistency). |
| **Aggregate Design Canvas** (DDD Crew) | 9-section per-aggregate checklist with built-in smells (too many state transitions/invariants → oversized; many corrective policies → logic pushed out; command↔event tracing → completeness). |
| **Anemic Domain Model** (Fowler) | Behaviour-with-data check; legitimate domain service vs anemia. |
| **Domain-event design discipline** (Microsoft/DDD ref) | Past-tense, single-emitter, focused payload, full lifecycle coverage. |

**Rigor layer (peer-reviewed conceptual-model quality — applies to both altitudes):**

- **SEQUAL** (Lindland/Sindre/Sølvberg; Krogstie) — syntactic / semantic (validity + completeness) / pragmatic / *social* (stakeholder agreement) quality.
- **Moody & Shanks** — completeness, correctness, integrity, flexibility, understandability, simplicity, integration, implementability.
- **Bunge-Wand-Weber (BWW)** — construct deficit / overload / redundancy / excess (the over/under-modeling lens).

---

## 3. The review process (phased)

A six-step pipeline. Steps 0–2 are setup; 3–4 are the two evaluations; 5 is the seam; 6 is synthesis.

**Step 0 — Freeze inputs & provenance.** Pin the exact artifact snapshot (file hashes, snapshot date). Living docs evolve externally — without a pin, findings drift and you chase stale elements.

**Step 1 — Deterministic structural pass** (cheap, automatable). Before any human reading:
- *Reference integrity:* every ID resolves; xref files mirror source 1:1; no dangling/`???` targets.
- *Count reconciliation:* recompute every headline count from source; fail on cross-document disagreement.
- *Context-map legality:* run the 10 Context Mapper rules over the relationships — flag illegal pattern combinations.
- Output a defects list that costs no reviewer judgement. **This pass cannot find semantic defects — say so explicitly, so a structural PASS is never read as a clean bill.**

**Step 2 — Domain calibration.** Reviewers load the domain: the business lifecycle, the statutory/regulatory gates, and the external reference standards ([[3-Resources/domain-driven-design/reference-model-anchoring|reference models]]). Without this, "completeness vs the domain" — the highest-value dimension — cannot be judged.

**Step 3 — Strategic evaluation** (bounded contexts + context map). Per §4.1 rubric + §5.1 checklist. One reviewer per small group of BCs; the context map reviewed as a whole.

**Step 4 — Tactical evaluation** (logical domain model). Per §4.2 rubric + §5.2 checklist. One reviewer per BC's domain model; deepest scrutiny on the core BCs.

**Step 5 — Seam & traceability check.** The strategic↔tactical seam is where high-impact defects hide:
- Does each aggregate sit in the right BC (no concept that "belongs elsewhere")?
- Does every context-map crossing have a corresponding domain element (event/service) and vice-versa?
- Requirement → BC → domain model → use-case traceability with no orphans.
- **A synchronous cross-aggregate invariant *across* a BC boundary is a top-severity contradiction.**

**Step 6 — Adversarial verification & synthesis.** Each finding → independent verifier (refute-by-default) → confirmed / softened / refuted. Confirmed findings synthesized into a severity-ranked plan (quick-wins vs structural), each tied to element IDs + a concrete fix.

---

## 4. The scoring rubric (dimensions)

Score each 1–5 with a verifier-adjusted one-line justification. Dimension → governing principle.

### 4.1 Bounded contexts & context map

| Dimension | What "good" looks like | Anchor |
|---|---|---|
| **Linguistic integrity** | One consistent ubiquitous language per context; polysemes split, not smoothed over | Evans/Vernon/Fowler; SEQUAL semantic |
| **Cohesion** | Things inside share a business name, the same people, the same domain expert | BC Canvas; Moody-Shanks simplicity |
| **Autonomy / coupling** | Few cross-context dependencies; edges justified by strength×distance×volatility; no distributed-monolith edge | ISH; Khononov |
| **Subdomain classification** | core/supporting/generic correct on complexity×differentiation; core gets the depth | Core Domain Charts; Evans |
| **Right-sizing / cognitive load** | ~1 complex or 2–3 simple domains per team; not too big (multi-language) nor too small (chatty) | Team Topologies |
| **Integration-pattern appropriateness** | Legal pattern combos; no over-applied Shared Kernel; no Conformist into the core; ACL where upstream is messy | Context Mapper rules |
| **Interface / message-flow health** | Not too many message types; ~5–9 messages per scenario | BC Canvas; Domain Message Flow |
| **Completeness** | All subdomains & relationships present; no missing context | SEQUAL completeness; BWW deficit |
| **Consistency / integration** | Maps agree across contexts; no contradictory ownership | Moody-Shanks integration |
| **Clarity (pragmatic)** | Small focused maps; coherent naming; readable | SEQUAL pragmatic |
| **Shared understanding** | Few unresolved open questions / contested hotspots | SEQUAL social; EventStorming |
| **Flexibility** | Boundaries absorb likely change without re-slicing | Moody-Shanks flexibility |

### 4.2 Logical domain model

| Dimension | What "good" looks like | Anchor |
|---|---|---|
| **Invariant & consistency-boundary correctness** | Only true atomic invariants inside an aggregate; cross-aggregate rules use eventual consistency/saga | Vernon rules 1 & 4 |
| **Aggregate sizing & coupling** | Small aggregates; reference others by identity; one aggregate per transaction | Vernon rules 2 & 3 |
| **Tactical-pattern correctness** | Deliberate entity-vs-VO; immutable typed VOs; no anemia; domain services only for genuine cross-object logic | Fowler; Evans/Vernon |
| **Behaviour / event completeness** | Every lifecycle state reachable; every command emits an event; single-emitter; past-tense focused payloads | Aggregate Design Canvas |
| **Semantic quality** | Valid + complete vs the domain and vs external standards | SEQUAL; Moody-Shanks |
| **Construct hygiene** | No undeclared types; no orphan/floating VOs; no duplication; no excess | BWW deficit/overload/redundancy/excess |
| **UL alignment & understandability** | Names match the business language; bidirectional ubiquitous-language↔model integrity | SEQUAL pragmatic/social |
| **Traceability & right-sizing** | Each element traces to a requirement/use case; speculative surface flagged as cuttable | Moody-Shanks; BWW excess |

---

## 5. Per-artifact reviewer checklists

### 5.1 Per bounded context (BC Canvas + ISH)
- **Naming:** are message/element names coherent with each other and the stated purpose?
- **Size:** is the interface too big (too many unique message types)? Is the context exposing too much of its internals?
- **Cohesion:** do any elements/messages seem like they belong to another context? (Run "move it elsewhere — how is the design affected?")
- **Vocabulary (ISH):** does any term mean something different here vs a neighbor? → split signal.
- **Autonomy (ISH):** could a team build & operate this independently most of the time? Can unavoidable dependencies be pulled inside?
- **Phases (ISH):** is this an earlier/later processing phase of a neighbor? → boundary candidate.
- **Classification:** does the Core Domain Chart position match the stated core/supporting/generic?
- **Open questions:** how many unresolved? (high count = high uncertainty = lower confidence, *not* a fail).

### 5.2 Per aggregate (Aggregate Design Canvas + Vernon)
- **Invariants:** for each, must it hold *atomically*? If not → it belongs to an eventual-consistency policy, not this aggregate. Flag any cross-aggregate invariant presented as synchronous.
- **State transitions:** too many → boundary may be misaligned; too few/trivial → possible anemia.
- **Corrective policies:** many → logic has leaked outside the aggregate.
- **Command↔event tracing:** does every handled command produce an event? Does every event trace to a command? Gaps = lifecycle under-coverage.
- **References:** are other aggregates referenced by identity (not object graph)?
- **Behaviour:** is logic on the aggregate, or drained into services (anemia)? Are VOs immutable, typed, self-validating?
- **Declared types:** does every return/attribute type exist as a declared element? (catches the *undeclared-type* defect class).

---

## 6. Running it — roles, cadence, outputs

- **Roles:** per-stream **Reviewer** (domain-literate) + independent **Verifier** (refute-by-default) + a **Synthesizer**.
- **Effort tiering:** deepest scrutiny on the core BCs and the context map; lighter touch on generic/supporting BCs — but still run the structural pass on all.
- **Tooling** (make structural checks cheap & repeatable): a docs-as-code traceability engine (e.g. Sphinx-Needs / mlx.traceability) over the ID scheme to make broken links/orphans/count-drift *build-time errors*; Context Mapper (CML) as a derived, machine-checkable view to auto-run the 10 relationship rules. Source logs stay system-of-record; these are generated *from* them.
- **Outputs:** (1) a scored scorecard (the §4 dimensions, verifier-adjusted); (2) per-stream appendices (summary, strengths/weaknesses/recommendations, verifier verdict); (3) a severity-ranked, ID-anchored improvement plan split quick-wins vs structural.
- **Gate vocabulary:** use **{PASS, PASS-WITH-DEFERRAL, WAIVED, FAIL}** — never a flat PASS that hides deferred blockers.

---

## 7. Sources

**Strategic DDD:** Evans *DDD* & DDD Reference 2015; Vernon *Implementing DDD*; Fowler "BoundedContext"; DDD Crew — Bounded Context Canvas v5, Core Domain Charts, Context Mapping, Domain Message Flow Modelling, DDD Starter Modelling Process; Team Topologies — Independent Service Heuristics & cognitive-load; Khononov *Balancing Coupling* / *Learning DDD*; Context Mapper (contextmapper.org); Richardson (microservices.io); Newman *Building Microservices*; Brandolini EventStorming.

**Tactical DDD:** Vernon "Effective Aggregate Design" (dddcommunity.org); DDD Crew Aggregate Design Canvas; Fowler "AnemicDomainModel"; Microsoft domain-events design guidance (learn.microsoft.com).

**Peer-reviewed quality frameworks:** SEQUAL — Lindland/Sindre/Sølvberg, *IEEE Software* 11(2), 1994, DOI 10.1109/52.268955; Krogstie, *Model-Based Development and Evolution of IS* (Springer). Moody & Shanks — ER'94 (LNCS 881) & *Data & Knowledge Engineering* 2003 (DOI 10.1016/S0169-023X(02)00043-X). Bunge-Wand-Weber — Wand & Weber, *IEEE TSE* 16(11), 1990 (DOI 10.1109/32.60316) & *Information Systems Journal* 3(4), 1993.

---

## Related Concepts

- [[3-Resources/domain-driven-design/ddd-smells-catalog|DDD Smells Catalog]] — the defects this method hunts for
- [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]] — Step 2 domain calibration input
- [[3-Resources/techniques/agents/adversarial-multi-stream-evaluation|Adversarial Multi-Stream Evaluation]] — the AI-assisted pipeline that runs this method
- [[3-Resources/domain-driven-design/README|DDD Cluster Overview]]
- [[5-Meta/MOCs/AI-Assisted-Architecture-MOC|AI-Assisted Architecture MOC]]

---

**Last Updated:** 2026-07-01
**Status:** Published
**Part of:** AI/LLM Engineering Knowledge Vault
