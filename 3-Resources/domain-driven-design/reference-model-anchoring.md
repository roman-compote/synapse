---
tags:
  - "#domain-driven-design"
  - "#ddd"
  - "#architecture"
  - "#technique"
date: 2026-07-01
status: published
last_updated: 2026-07-01
---

# Reference-Model Anchoring

Before designing a domain model from scratch, search for **externally-existing, widely-accepted reference models and standards** that already define part of your domain. Anchoring to them buys correctness, shared vocabulary, interoperability, and evaluator/regulator alignment — and tells you exactly which parts of your *core* you genuinely have to invent.

> A generalized technique. The worked example below comes from a regulatory-governance platform, but the *method* — categorize external material by how you consume it, then anchor per bounded context — applies to any domain.

---

## Why do this

- **Don't reinvent a standard.** If a near-formal model already exists for a subdomain (cost taxonomies, party/place vocabularies, document versioning), lifting it is faster and more correct than inventing one.
- **Find the gaps in your own model.** Benchmarking against an external standard surfaces *verified-absent* constructs — things the domain requires that your model silently omits (see [[3-Resources/domain-driven-design/ddd-smells-catalog|smell #2, undeclared/missing core]]).
- **Interoperability & compliance are often mandatory.** Some vocabularies are effectively required by law or by a gateway/registry; discovering that early is an architecture constraint, not a nice-to-have.
- **It scopes your core domain.** When the search returns *nothing* off-the-shelf, that absence is the signal: this is genuinely your core and must be designed in-house with the most care.

---

## The three consumption categories

The key move is to classify each external artifact by **how you consume it**, not by topic:

### Category A — Adopt (lift into the model)
Reference models concrete enough to become aggregates / entities / value objects nearly verbatim.
- **What qualifies:** a near-formal metamodel with defined entities and relationships (RDF/OWL ontologies, formal cost models, document metamodels).
- **How to use:** map it directly to a bounded context or aggregate; adopt its vocabulary as ubiquitous language.
- *Example anchors:* a formal cost/burden model → a `BurdenMeasurement` aggregate; a criterion/evidence vocabulary → the backbone of an assessment context; a Work→Expression→Manifestation→Item bibliographic metamodel → versioning aggregate for documents; a legal-identifier ontology → identity value objects.

### Category B — Align to (impose structure, ship no schema)
Standards/methodologies with high authority but low implementability — prose, not a machine-readable file.
- **What qualifies:** best-practice guidelines, process frameworks, appraisal methodologies, decision/case notations used as *design vocabulary*.
- **How to use:** transcribe their structure into a state machine, an aggregate skeleton, or a ubiquitous language; they jointly *determine the value objects you're missing* even though they hand you no schema.
- **Caution — vocabulary vs runtime:** a notation can be an excellent *design vocabulary* while being a poor *runtime dependency*. (E.g. use a case-management notation to name your case/stage/gate concepts, but hand-roll an auditable state machine rather than depend on a declining engine.)

### Category C — Mine, don't adopt (learn from precedents)
Existing products/architectures and academic standards that are the closest real siblings but too thin, bespoke, or low-adoption to lift.
- **What qualifies:** open-source products in the same space, reference implementations, academic/normative standards with low adoption.
- **How to use:** study their decomposition and pitfalls; do materially better. Note them as *future* contexts, not now.

Plus a fourth, orthogonal band: **architecture/compliance frameworks** (EA metamodels, national registry obligations) that carry no domain entities but govern ADRs, conformance, and registration.

---

## The process

1. **Decompose the domain into subdomains** first (you need the bounded-context map to know what to search *for*).
2. **For each subdomain, search** authoritative bodies (standards orgs, EU/OECD/ISO/OMG/OASIS, national reference architectures) and the open-source landscape.
3. **Classify each hit** A / B / C (+ compliance band).
4. **Record a headline finding** — including the *negative* one: "there is no off-the-shelf model for the core; it must be designed in-house."
5. **Produce an adoption recommendation per bounded context** — a table saying, for each context, what to adopt / align to / mine.
6. **Feed the gaps back into the evaluation** as benchmark dimensions: the model's completeness is now judged *against these external standards*, not just internal consistency.
7. **Flag caveats to verify** — e.g. "confirm how deep the external ontology actually goes before hard-depending on it"; "the detailed spec lives in a doc not yet retrieved."

---

## Worked example — adoption recommendation by bounded context

The output shape (domain-neutralized from the source work):

| Context (role) | Adopt / align |
|---|---|
| Analytical core (core) | Design in-house; anchor on a **criterion/evidence vocabulary** + appraisal **value objects**; ubiquitous language from a **best-practice toolbox**; add a formal **cost-model** aggregate; close the discounting/NPV/sensitivity gaps a benchmark reveals. |
| Administrative-burden sub-area | **Adopt** the formal cost model nearly verbatim; add a configurable ledger on top. |
| Document/versioning context | **Bibliographic metamodel** backbone + a **document-XML standard** for serialization + a **legal-identifier ontology** for identity; mine existing editor/amendment tools. |
| Case-orchestration context | Case-management notation **as vocabulary**; hand-rolled auditable state machine as runtime; decision-table standard for gate decisions; a BPMN engine only for fixed lawful sub-flows. |
| Supporting contexts | Shared **party / place / public-service** core vocabularies. |
| Architecture / compliance | EA metamodel for ADRs; national registry **registration** is an obligation, not a design input. |

The *lesson*, not the specific standards, is the transferable artifact: **anchor the supporting contexts and specific aggregates to standards; reserve in-house design for the true core; and let the standards define the completeness bar you evaluate against.**

---

## Related Concepts

- [[3-Resources/domain-driven-design/ddd-evaluation-method|DDD Evaluation Method]] — Step 2 (domain calibration) consumes these; the completeness dimension benchmarks against them
- [[3-Resources/domain-driven-design/ddd-smells-catalog|DDD Smells Catalog]] — "verified-absent core construct" is the gap this technique catches
- [[3-Resources/domain-driven-design/modeling-patterns|Reusable Modeling Patterns]]
- [[3-Resources/domain-driven-design/README|DDD Cluster Overview]]

---

**Last Updated:** 2026-07-01
**Status:** Published
**Part of:** AI/LLM Engineering Knowledge Vault
