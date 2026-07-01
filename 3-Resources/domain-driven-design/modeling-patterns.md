---
tags:
  - "#domain-driven-design"
  - "#ddd"
  - "#architecture"
  - "#patterns"
date: 2026-07-01
status: published
last_updated: 2026-07-01
---

# Reusable Modeling Patterns

Two domain-neutral modeling patterns extracted from a regulatory-governance platform. Both are useful well beyond that domain — the specifics were genericized; only the reusable structure is kept.

> Companion to [[3-Resources/domain-driven-design/ddd-evaluation-method|DDD Evaluation Method]] and [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]].

---

## Pattern 1 — Profile-based case-type stratification with decision gates

**Problem.** A multi-actor process must handle several case types of differing complexity/risk (full vs simplified vs exception vs record-only), each following a different step sequence and different obligations — without forking into N unrelated workflows.

**Structure.**
1. **Profiles stratify by complexity/risk.** Define a small set (typically 4–6) of case profiles: `Full → Simplified → Exception → …`. Each profile maps to a distinct step sequence and gate configuration.
2. **Roles are first-class, RACI-explicit.** A responsibility matrix names each role and the step-subset + decisions/outputs it owns (submitter, coordinator, analyst, reviewer/commission, approver, ex-post owner…). Roles are modeled, not implied.
3. **Gates are decision nodes.** Each gate has: a decision ID, a decision point (which step), an output domain (an enum of outcomes), and a downstream impact (which steps activate or skip). Gates are what *branch* the workflow between profiles.
4. **Escalation/SLA rules are versioned separately** from the step catalog, so timing policy evolves without touching the process spine.

**Where it applies.** Any regulated or compliance-heavy multi-actor process: permit/licence applications, tax filings, contract reviews, data-privacy / impact assessments, grant approvals, clinical or safety case reviews.

**Method to instantiate.** Enumerate profiles → define role/step mapping (RACI) → declare gates (decision point + output enum + downstream effect) → version escalation/SLA rules.

**DDD cautions (from the [[3-Resources/domain-driven-design/ddd-smells-catalog|smells catalog]]).**
- Don't fuse the **generic** case/workflow/task engine with the **core** gate governance in one bounded context — it over-invests generic machinery (smell #14). Split them, or explicitly tag the generic subdomain.
- Model each gate outcome enum with its **terminal/negative states** (reject, rework, dissent), not just a happy path — dropping the rejected terminal state is a recurring completeness gap.
- Give every gate decision a **command + event**; a gate whose outcome emits nothing can't be audited or reacted to (smell #8).

---

## Pattern 2 — Layered document decomposition with version-diff synchronization

**Problem.** One authoritative source document must be understood through several very different lenses at once (its facts, its normative content, its analytical implications), and those lenses must stay consistent as the document evolves.

**Structure — three synchronized lenses over one document:**
1. **Metadata layer** — machine-readable facts: authorship, dates, classification, external references/identifiers. (Anchors well to a legal-identifier ontology or a bibliographic metamodel — see [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]].)
2. **Normative / regulatory layer** — obligations extracted per section, cross-referenced to obligations elsewhere (the structural content).
3. **Analysis layer** — the impact/assessment structure (cost taxonomy, affected parties, benefits/costs per measure) aligned to methodology steps (the analytical view).

Each layer is a **separate but synchronized bounded context** over the same source. A change in one layer can trigger validation in others — e.g. if the normative text changes, the analysis layer's thresholds must be re-evaluated.

4. **Version-diff synchronization.** Compare layers across versions to detect *stale* derived content: if the normative text changed but the analysis wasn't updated, flag it. The diff is the mechanism that keeps the lenses honest.

**Where it applies.** Any regulated/structured document workflow: EU directives and their national transpositions, tax codes, contract templates, policy frameworks, GDPR privacy-impact assessments (legal obligations / technical controls / residual-risk), standards documents, SOPs.

**Method to instantiate.** Identify the lenses your stakeholders actually use → model each as a bounded context over the shared source → define which cross-layer changes trigger re-validation → implement version-diff to detect stale derived layers.

**DDD cautions.**
- Keep the lenses as **separate bounded contexts with by-identity references**, not one giant aggregate — a document + all its derived analyses loaded as a single consistency unit is an oversized-aggregate smell.
- The cross-layer "if normative changes, re-validate analysis" rule is a **cross-aggregate/cross-context** rule → enforce it with an **event + policy**, never a synchronous invariant (smell #3).

---

## Related Concepts

- [[3-Resources/domain-driven-design/ddd-evaluation-method|DDD Evaluation Method]]
- [[3-Resources/domain-driven-design/ddd-smells-catalog|DDD Smells Catalog]]
- [[3-Resources/domain-driven-design/reference-model-anchoring|Reference-Model Anchoring]]
- [[3-Resources/domain-driven-design/README|DDD Cluster Overview]]

---

**Last Updated:** 2026-07-01
**Status:** Published
**Part of:** AI/LLM Engineering Knowledge Vault
