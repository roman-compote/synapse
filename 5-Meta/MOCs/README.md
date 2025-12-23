---
tags:
  - "#meta"
  - "#moc"
  - "#readme"
created: 2025-12-23
---

# Maps of Content (MOCs) - Navigation Hubs

## Purpose

Maps of Content (MOCs) are **high-level navigation hubs** that organize related notes around specific topics, themes, or domains.

**Key Principle:** MOCs enable non-linear navigation and show conceptual relationships that folder structures can't capture.

---

## What is a MOC?

A **Map of Content** is:
- A curated index of notes on a specific topic
- A hub that links to related concepts
- A high-level overview with context
- A navigation aid for complex topics
- A way to see relationships between ideas

**A MOC is NOT:**
- A comprehensive list of everything (that's a folder or tag)
- A rigid hierarchy or taxonomy
- A replacement for search
- Static (it evolves as content grows)

---

## When to Create a MOC

Create a MOC when:
- ✅ You have 10+ notes on a related topic
- ✅ A topic is complex with many sub-concepts
- ✅ You want to show learning progressions
- ✅ Multiple concepts interconnect in non-obvious ways
- ✅ You're regularly navigating to the same cluster of notes

**Don't create a MOC when:**
- ❌ You only have a few notes on a topic
- ❌ A simple folder or tag works fine
- ❌ The organization is already obvious
- ❌ You're just creating one for the sake of it

---

## Current MOCs

### [[5-Meta/MOCs/AI-Models-MOC|AI Models MOC]]
**Scope:** All AI/LLM models across categories
**Organizes:**
- Frontier models (Claude, GPT, Gemini)
- Production models
- Open source models
- Local deployment tools
- Model comparisons and selection guides

---

### [[5-Meta/MOCs/Coding-Assistants-MOC|Coding Assistants MOC]]
**Scope:** AI coding tools and assistants
**Organizes:**
- Agentic assistants (Claude Code, Cursor)
- Copilot-style tools
- Hybrid approaches
- Tool comparisons
- Use case mapping

---

### [[5-Meta/MOCs/Prompting-Techniques-MOC|Prompting Techniques MOC]]
**Scope:** Prompt engineering patterns and practices
**Organizes:**
- Basic techniques
- Advanced patterns
- Context engineering
- Chain-of-thought approaches
- Practical examples

---

### [[5-Meta/MOCs/Learning-Path-MOC|Learning Path MOC]]
**Scope:** Structured learning progressions for AI/LLM engineering
**Organizes:**
- Beginner → Intermediate → Advanced paths
- Prerequisites and foundations
- Exercises and workshops
- Practical projects
- Skill progressions

---

## MOC Structure

### Recommended Format

```markdown
---
tags: [#moc, #[topic]]
type: moc
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
---

# [Topic] - Map of Content

Brief 1-2 sentence overview of this topic area.

---

## Core Concepts

**Foundations:**
- [[Fundamental Concept 1]] - Brief context
- [[Fundamental Concept 2]] - Brief context

**Key Ideas:**
- [[Important Concept 1]] - How it relates
- [[Important Concept 2]] - How it relates

---

## Sub-Topics

### [Category 1]
- [[Note 1]]
- [[Note 2]]
- [[Note 3]]

### [Category 2]
- [[Note 4]]
- [[Note 5]]

---

## Learning Path

1. Start here: [[Beginner Note]]
2. Then: [[Intermediate Note]]
3. Advanced: [[Advanced Note]]

---

## Related MOCs

- [[Related MOC 1]]
- [[Related MOC 2]]

---

**Last Updated:** YYYY-MM-DD
```

---

## Creating a New MOC

### Step-by-Step Process

1. **Identify the Need**
   - Do you have enough related notes?
   - Is navigation becoming difficult?
   - Would grouping add value?

2. **Gather Related Notes**
   - Use search to find all notes on topic
   - Use tags to identify candidates
   - Review graph view for connections

3. **Find Natural Groupings**
   - What categories emerge?
   - What's the progression (beginner → advanced)?
   - How do concepts relate?

4. **Create Structure**
   - Start with core/fundamental concepts
   - Group by sub-topic or category
   - Show progression or relationship
   - Add context for each section

5. **Add Context**
   - Brief overview at top
   - Explain why each note matters
   - Show how concepts connect
   - Suggest navigation paths

6. **Link Bidirectionally**
   - Link from MOC to notes
   - Add link back to MOC from each note
   - Connect to related MOCs

7. **Maintain Over Time**
   - Add new notes as they're created
   - Refine categories as they evolve
   - Update learning paths
   - Keep it current

---

## MOC Best Practices

**DO:**
- ✅ Provide context for links (not just lists)
- ✅ Show relationships and progressions
- ✅ Update regularly as content grows
- ✅ Link to other related MOCs
- ✅ Keep it scannable and navigable
- ✅ Include a "last updated" date

**DON'T:**
- ❌ List every single related note (be selective)
- ❌ Create rigid hierarchies (allow flexibility)
- ❌ Let MOCs become outdated
- ❌ Duplicate content that exists in notes
- ❌ Make MOCs too long (consider splitting)

---

## MOC vs Other Organization Methods

| Method | Purpose | When to Use |
|--------|---------|-------------|
| **Folders** | Physical organization | Grouping files by type/category |
| **Tags** | Flexible categorization | Cross-cutting themes, filtering |
| **Links** | Connections between ideas | Relating specific concepts |
| **MOCs** | Curated navigation | Complex topics, learning paths |

**Use all four together!** They complement each other.

---

## Maintaining MOCs

**Weekly:**
- Add links to newly created notes
- Quick scan for relevance

**Monthly:**
- Review structure and organization
- Add context to new links
- Check for outdated content
- Refine categories

**Quarterly:**
- Major restructuring if needed
- Consider splitting if too large
- Update learning paths
- Review all links for relevance

---

## Advanced MOC Techniques

### Nested MOCs
- Create sub-MOCs for complex topics
- Link parent and child MOCs
- Example: AI-Models-MOC → Open-Source-Models-MOC

### Progressive Disclosure
- Start with high-level overview
- Link to deeper MOCs for detail
- Support both quick reference and deep dives

### Learning Sequences
- Number items to show progression
- Add "prerequisites" sections
- Create deliberate learning paths

### Integration MOCs
- Connect multiple topic areas
- Show interdisciplinary connections
- Example: "Agents + RAG" MOC

---

## Related

- [[5-Meta/README]] - Meta folder overview
- [[README]] - Main vault navigation
- [[5-Meta/Guidelines/Knowledge-Base-Guidelines]] - Content standards
- [[3-Resources/README]] - Where the actual content lives

---

**Remember:** MOCs are maps, not the territory. They point to knowledge, they don't contain it. Keep them lean, navigable, and current.
