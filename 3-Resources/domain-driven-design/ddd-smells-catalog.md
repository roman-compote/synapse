---
tags:
  - "#domain-driven-design"
  - "#ddd"
  - "#architecture"
  - "#anti-patterns"
  - "#reference"
date: 2026-07-01
status: published
last_updated: 2026-07-01
---

# DDD Smells Catalog

The concrete strategic and tactical defects that recur in real bounded-context sets and domain models — each with the **signal** (how to spot it), **why it's wrong**, and the **fix**. These are the defect classes a semantic review ([[3-Resources/domain-driven-design/ddd-evaluation-method|DDD Evaluation Method]]) is designed to surface; a structural/syntactic checker will pass right over all of them.

> Derived from a verified multi-stream DDD audit. Ordered roughly by how often they show up and how much damage they do.

---

## Tactical smells (domain model)

### 1. Single-emitter violation — *the most pervasive tactical defect*
**Signal:** the same domain event is declared as emitted by an aggregate root **and** by an entity contained inside it (sometimes a third emitter too — e.g. a service or a sibling aggregate).
**Why wrong:** an event is a fact about one aggregate's state change. Multiple emitters mean ambiguous ownership, duplicate publication, and unclear which handler is authoritative. Contained entities should raise events *internally*; only the root publishes.
**Fix:** one root emitter per event; contained entities raise internally and let the root republish.
**Note:** this is the single highest-frequency confirmed defect class and the cheapest to fix mechanically.

### 2. Undeclared load-bearing type — *hollows out the core*
**Signal:** a type is the return value of several services and the type of a key attribute, is even referenced by an invariant ("must be typed, never raw JSON") — yet it is **never declared** as a model element (0 grep hits). The input side is often equally undeclared, so *both ends* of every compute operation are untyped.
**Why wrong:** the most precision-critical surface of the model — usually inside the analytical/computational core — is opaque. Nothing constrains it, nothing can validate it.
**Fix:** declare the type with its typed sub-structure; compose orphan VOs into it or cut them.

### 3. Synchronous cross-aggregate invariant with no saga — *top-severity per rubric*
**Signal:** an invariant reads or gates on state in a *different* aggregate ("X may finalize only if all related Y are finalized") and is declared as an atomic, synchronous rule — with no eventual-consistency policy to enforce it. Frequently compounded: the carrier event (`YFinalized`) is *also* missing, so the rule is unenforceable as modeled.
**Why wrong:** violates Vernon rule 4 (one aggregate per transaction). Atomic cross-aggregate consistency forces distributed locking or silently doesn't hold.
**Fix:** add the eventual-consistency carrier events + a policy that enforces the rule by subscription rather than synchronous read. A cross-aggregate invariant *across a bounded-context boundary* is the highest-severity form.

### 4. Cross-aggregate write / reference by non-root identity
**Signal:** an entity inside aggregate A exposes a method that creates or mutates entities owned by a separate aggregate B; or a reference is keyed on a *contained non-root* entity's identity.
**Why wrong:** breaks the consistency boundary (Vernon rule 4) and reference-by-root-identity (rule 3).
**Fix:** route the write through B's root via a command/event; reference other aggregates only by root identity.

### 5. Anemia / logic drained into services
**Signal:** aggregates are bare data holders (bare `String`s, no behaviour); business rules live entirely in services. Or: many *corrective policies* around one aggregate (logic has leaked out).
**Why wrong:** Fowler's anemic domain model — the domain layer carries data but no behaviour, so rules scatter and drift.
**Fix:** put behaviour on the aggregate; reserve domain services for genuine cross-object logic; make VOs immutable, typed, and self-validating.

### 6. Root-less reference holder modeled as an entity
**Signal:** a behaviour-free thing that only holds references to other aggregates (a directory, an external bill/record) is modeled as an entity with no root and no lifecycle.
**Why wrong:** it's really a value object or an external read-model; modeling it as an entity implies an identity and lifecycle it doesn't have, and invites mis-scoped invariants.
**Fix:** re-type as a VO / external read-model; re-express its "invariants" accordingly.

### 7. Duplicate event for the same fact
**Signal:** two events describe the same state change (`AnalysisPlanCompiled` vs `AnalysisPlanCompiledEvent`), one on the root, one on a contained entity.
**Fix:** collapse to a single event on the root.

### 8. Unreachable lifecycle state / silent transition
**Signal:** a state exists in the state machine that no command ever reaches; or a transition (`active→dissolved`, `closed`, `superseded`) happens but emits no event, so it's unobservable. Sometimes a corrective policy keys off a transition that can never fire.
**Why wrong:** dead states inflate the model; unobservable transitions can't be reacted to or audited.
**Fix:** wire a command to every reachable state; emit an event on every meaningful transition; delete truly dead states.

### 9. Mis-scoped invariant tag
**Signal:** an invariant tagged *intra-aggregate* while it reads across a boundary (or vice-versa); an invariant that is actually a *strategic ownership statement*, not a tactical rule; an invariant declared on an immutable domain **event**.
**Why wrong:** mis-tagging hides real cross-aggregate coupling and pollutes events (which are facts and must carry no invariants).
**Fix:** re-tag to the true scope; move ownership statements to boundary notes; strip invariants off events and relocate genuine rules to the emitting aggregate.

### 10. Construct overload / excess (BWW)
**Signal:** a `Kind=service` element that carries stateful attributes + an arithmetic invariant; orphan/floating VOs carrying invariants while belonging to no aggregate; speculative surface referenced nowhere.
**Fix:** split the overloaded construct; home or cut the orphans; flag speculative surface as cuttable (right-sizing).

---

## Strategic smells (bounded contexts & context map)

### 11. Over-applied Shared Kernel → distributed-monolith
**Signal:** Shared Kernel is a large share of all edges and concentrates into hub contexts with many SK partners (e.g. two 5-partner SK hubs on the core orchestrator and the data foundation). Often these describe *infrastructure access* (security/audit/integration endpoints), not a shared domain kernel.
**Why wrong:** Khononov high-strength × high-distance coupling forces lock-step releases across most of the platform — the map's modular intent is defeated.
**Fix:** re-classify infrastructure edges to Open-Host-Service / Published-Language; cap Shared Kernel to ≤2 partners per context, especially on core BCs.

### 12. Inverted / contradictory context-map direction
**Signal:** ACL edges label the ACL-*installing* consumer as *upstream*, while their own notes describe that context reading/querying *from* the other side. A relationship's pair-arrow contradicts its own stated Direction/supplier note.
**Why wrong:** an ACL is a downstream/consumer-side pattern; inverted labels misstate ownership and make pattern legality unverifiable.
**Fix:** flip labels to the consuming side; make the pair-arrow agree with the stated supplier.

### 13. Illegal / stacked relationship-pattern combination
**Signal:** one edge simultaneously carries contradictory patterns (e.g. Shared Kernel + Customer-Supplier + ACL at once); a symmetric pattern carrying OHS/PL/ACL/CF; ACL + Conformist together.
**Why wrong:** violates Context Mapper's 10 relationship rules — the combination is semantically impossible.
**Fix:** pick the single correct pattern per edge; run the 10 rules as a build check.

### 14. Bloated / under-sized context (right-sizing)
**Signal:** a context bundles a **generic** engine (case/workflow/task machinery) with a genuinely **core** subdomain, exceeding a single team's complex-domain budget — so the generic half consumes core-domain investment. Or the opposite: a context so thin (few elements, ~2 terms, no exclusive concepts) it shouldn't stand alone.
**Fix:** split generic from core, or explicitly tag the generic subdomain so it isn't over-invested; merge over-thin contexts into their natural owner.

### 15. Homonym / polyseme left un-namespaced
**Signal:** the same code symbol names two materially different concepts across contexts ("Regulation" = a legal act in one BC, an extracted behavioural rule in another), left as a tagged homonym instead of namespaced.
**Why wrong:** breaks per-context ubiquitous language; the ISH Vocabulary heuristic firing = a split/rename signal ignored.
**Fix:** namespace the divergent names (e.g. `ExtractedRule`, `SemanticDecompositionEditing`).

### 16. Duplicated phase-keyed vocabulary
**Signal:** near-identical terms distinguished only by process phase (`ConsultationCommentDispositioned` pre-gate vs `CommentDispositioned` at a later gate) — the ISH *Phases* heuristic firing on a self-declared split candidate.
**Fix:** one polymorphic concept with a phase attribute, or action the phase split with recorded evidence.

### 17. Non-dereferenceable boundary signal
**Signal:** a "boundary signals" / context-map-feed layer mixes resolvable element-ID references with quoted free-text labels that resolve to nothing in their named target context.
**Fix:** point refs at real IDs, or explicitly mark them as informal.

---

## Cross-cutting themes

1. **Single-emitter discipline** is the most pervasive tactical defect and the cheapest to fix.
2. **Undeclared load-bearing types** hollow out precisely the core that most needs precision.
3. **Cross-aggregate invariants asserted as synchronous gates with no saga** — and often the carrier event is missing too.
4. **Self-flagged seams retained without resolution** — honesty is a strength, but a documented-then-deferred split candidate is a standing cohesion cost.
5. **An over-coupled context map fights an otherwise clean modular intent** — SK hubs + inverted ACL direction mean the *encoded* ownership doesn't match the prose.
6. **A model can be honest and well-traced yet under-reconciled with its own ground truth** — strong ID/xref hygiene coexisting with verified-absent domain constructs the source explicitly requires.

---

## Related Concepts

- [[3-Resources/domain-driven-design/ddd-evaluation-method|DDD Evaluation Method]] — the review that finds these
- [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]] — how "verified-absent vs ground truth" gaps get benchmarked
- [[3-Resources/techniques/agents/adversarial-multi-stream-evaluation|Adversarial Multi-Stream Evaluation]]
- [[3-Resources/domain-driven-design/README|DDD Cluster Overview]]

---

**Last Updated:** 2026-07-01
**Status:** Published
**Part of:** AI/LLM Engineering Knowledge Vault
