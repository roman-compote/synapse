---
tags:
  - "#plan"
  - "#architecture"
  - "#structure"
date: 2025-12-23
status: published
---

# Proposed Architecture - Enhanced Knowledge Base Structure

Detailed design for integrating PARA method, Zettelkasten principles, and resource management into the existing vault.

---

## Design Philosophy

### Core Principles

1. **Build on Existing Foundation** - Preserve current excellent structure
2. **Hybrid Methodology** - Combine PARA (execution) + Zettelkasten (insight)
3. **Minimal Disruption** - Enhance, don't replace
4. **Progressive Enhancement** - Implement incrementally
5. **Maintain Quality** - Keep current high standards

### Strategic Approach

**PARA as Execution Engine:**
- Organize by actionability
- Clear what needs attention now
- Support project completion

**Zettelkasten as Insight Engine:**
- Develop interconnected knowledge
- Emerge understanding through links
- Long-term knowledge compounding

**Existing Structure as Resource Library:**
- Keep current organization for reference material
- Enhance with better capture and linking
- Maintain educational focus

---

## Enhanced Folder Structure

### Proposed Top-Level Organization

```
📁 Obsidian Vault Root
├── 📂 0-Inbox/                    # NEW: Quick capture
├── 📂 1-Projects/                 # NEW: Active work
├── 📂 2-Areas/                    # NEW: Ongoing responsibilities
├── 📂 3-Resources/                # ENHANCED: Reference material
│   ├── models/                    # EXISTING - keep as-is
│   ├── tools/                     # EXISTING - keep as-is
│   ├── techniques/                # EXISTING - keep as-is
│   ├── exercises/                 # EXISTING - keep as-is
│   ├── llm engineering/           # EXISTING - keep as-is
│   ├── workshops/                 # MOVE to Projects or Archives
│   ├── resources/                 # EXISTING - keep as-is
│   ├── bookmarks/                 # NEW: Web resources
│   ├── videos/                    # NEW: YouTube & video notes
│   └── articles/                  # NEW: Saved articles
├── 📂 4-Archives/                 # NEW: Inactive content
├── 📂 5-Meta/                     # NEW: Vault management
│   ├── Templates/                 # NEW: Note templates
│   ├── MOCs/                      # NEW: Maps of Content
│   └── Guidelines/                # EXISTING Knowledge Base Guidelines
├── 📂 attachments/                # NEW: Images, PDFs, etc.
└── 📄 README.md                   # EXISTING - update with new structure
```

### Rationale for Changes

**Why 0-Inbox?**
- Central landing for all quick captures
- Process later into appropriate locations
- Low friction for adding content
- Numbered to appear first in file list

**Why 1-Projects?**
- Active workshops move here
- Current learning projects
- Time-bound efforts
- Clear what needs attention

**Why 2-Areas?**
- Ongoing learning tracks
- Maintenance responsibilities
- Standards to maintain
- No completion date

**Why 3-Resources?**
- Keep existing excellent organization
- Add subcategories for new content types
- Reference material grouped logically
- Maintains educational structure

**Why numbered folders?**
- Forces top-to-bottom flow (Inbox → Projects → Areas → Resources)
- Makes PARA workflow explicit
- Obsidian sorts alphabetically

---

## Detailed Structure Design

### 0-Inbox/

**Purpose:** Quick capture landing zone

**Structure:**
```
0-Inbox/
├── README.md           # Processing guidelines
├── web-clips/          # From Obsidian Web Clipper
├── quick-notes/        # Fleeting thoughts
├── bookmarks/          # Unprocessed bookmarks
└── videos/             # Unprocessed video notes
```

**Processing Workflow:**
1. Content lands here from capture tools
2. Weekly review processes inbox
3. Items moved to permanent locations
4. Inbox kept clean (< 50 items)

**Template Variables:**
- Date captured
- Source URL
- Initial tags
- Processing status

---

### 1-Projects/

**Purpose:** Active, time-bound efforts

**Structure:**
```
1-Projects/
├── README.md                      # Active projects overview
├── 2025-Q1-RAG-Implementation/   # Project folders
│   ├── Project Overview.md
│   ├── Tasks.md
│   ├── Notes/
│   └── Resources/
├── Build-Agent-Framework/
└── Workshop-Preparation-2026/
```

**Characteristics:**
- Has clear outcome/goal
- Has deadline or timeline
- Currently active
- Contains tasks and next actions

**When to Archive:**
- Project completed
- Project abandoned
- Inactive for 3+ months

**Template Structure:**
```markdown
---
tags: [#project, #active, #topic]
status: active
start_date: YYYY-MM-DD
deadline: YYYY-MM-DD
---

# Project Name

## Objective
What you're trying to achieve

## Outcomes
- Specific deliverable 1
- Specific deliverable 2

## Tasks
- [ ] Task 1
- [ ] Task 2

## Resources
- [[Related Resource 1]]
- [[Related Resource 2]]

## Notes
Project-specific notes and insights
```

---

### 2-Areas/

**Purpose:** Ongoing responsibilities and interests

**Structure:**
```
2-Areas/
├── README.md                   # Areas overview
├── AI-Learning/               # Ongoing areas
│   ├── Area Overview.md
│   ├── Standards.md
│   ├── Learning Path.md
│   └── Progress Tracking.md
├── Professional-Development/
├── Team-Knowledge-Sharing/
└── Personal-Research/
```

**Characteristics:**
- No end date
- Standards to maintain
- Ongoing attention required
- Contains multiple related projects

**Example Areas for AI KB:**
- AI/LLM Engineering Learning
- Professional Development
- Team Knowledge Sharing
- Tool Evaluation
- Industry Trends Monitoring

**Template Structure:**
```markdown
---
tags: [#area, #ongoing, #topic]
status: active
created: YYYY-MM-DD
---

# Area Name

## Purpose
Why this area matters

## Standards
What "good" looks like in this area

## Current Focus
What needs attention now

## Related Projects
- [[Project 1]]
- [[Project 2]]

## Resources
Key resources for this area
- [[Resource 1]]
- [[Resource 2]]

## Review Schedule
- Weekly: X
- Monthly: Y
- Quarterly: Z
```

---

### 3-Resources/

**Purpose:** Reference material and knowledge repository

**Enhanced Structure:**
```
3-Resources/
├── README.md                    # Resource navigation
│
├── models/                      # EXISTING - AI models
│   ├── frontier/
│   ├── production/
│   ├── open-source/
│   └── local deployment tools/
│
├── tools/                       # EXISTING - AI tools
│   ├── coding-assistants/
│   ├── frameworks/
│   └── protocols/
│
├── techniques/                  # EXISTING - Methods
│   ├── prompting/
│   ├── agents/
│   ├── context-engineering/
│   └── RAG/
│
├── exercises/                   # EXISTING - Hands-on
│
├── llm engineering/            # EXISTING - Core concepts
│
├── bookmarks/                  # NEW - Web resources
│   ├── README.md
│   ├── Documentation/
│   ├── Tutorials/
│   ├── Research-Papers/
│   └── Tools-and-Resources/
│
├── videos/                     # NEW - Video content
│   ├── README.md
│   ├── Tutorials/
│   ├── Conferences/
│   ├── Lectures/
│   └── Quick-Tips/
│
├── articles/                   # NEW - Saved articles
│   ├── README.md
│   ├── Technical/
│   ├── Opinion/
│   └── News/
│
└── resources/                  # EXISTING - Meta resources
    ├── news/
    └── Knowledge Base Guidelines.md
```

**Key Enhancement:**
- Keep all existing excellent organization
- Add new subcategories for captured content
- Maintain hierarchical structure
- Cross-link between sections

---

### 4-Archives/

**Purpose:** Inactive but potentially useful content

**Structure:**
```
4-Archives/
├── README.md
├── projects/                   # Completed/abandoned projects
│   ├── 2024/
│   └── 2025/
├── areas/                      # No longer maintained
├── deprecated-tools/           # Outdated technology
├── old-workshops/             # Past workshop materials
└── superseded-content/        # Replaced by newer versions
```

**Archive Criteria:**
- Projects: Completed or inactive 3+ months
- Areas: No longer relevant
- Resources: Deprecated or replaced
- Keep for reference, clearly marked

**Template Addition:**
```yaml
---
status: archived
archived_date: YYYY-MM-DD
reason: "Completed" | "Deprecated" | "Superseded"
replacement: "[[New Version]]" (if applicable)
---

> **⚠️ ARCHIVED:** [Reason]. See [[Replacement]] for current information.
```

---

### 5-Meta/

**Purpose:** Vault management and navigation

**Structure:**
```
5-Meta/
├── README.md
│
├── Templates/                  # Note templates
│   ├── project-template.md
│   ├── area-template.md
│   ├── resource-template.md
│   ├── bookmark-template.md
│   ├── video-template.md
│   └── article-template.md
│
├── MOCs/                       # Maps of Content
│   ├── AI-Models-MOC.md
│   ├── Coding-Assistants-MOC.md
│   ├── Prompting-Techniques-MOC.md
│   └── Learning-Path-MOC.md
│
└── Guidelines/
    ├── Knowledge Base Guidelines.md  # MOVED from resources/
    ├── Contribution Guidelines.md    # NEW
    ├── Processing Workflow.md        # NEW
    └── Review Checklist.md           # NEW
```

---

## Maps of Content (MOCs)

### What are MOCs?

Maps of Content are **hub notes** that provide:
- Overview of a topic area
- Links to all related notes
- Context and relationships
- Navigation structure
- Progressive complexity

### MOC Structure Template

```markdown
---
tags: [#moc, #topic]
type: map-of-content
created: YYYY-MM-DD
---

# Topic MOC

## Overview
Brief introduction to this topic area

## Core Concepts (Start Here)
- [[Foundational Concept 1]]
- [[Foundational Concept 2]]

## Intermediate Topics
- [[Intermediate Concept 1]]
- [[Intermediate Concept 2]]

## Advanced Topics
- [[Advanced Concept 1]]
- [[Advanced Concept 2]]

## Practical Applications
- [[Exercise 1]]
- [[Project 1]]

## Tools & Resources
- [[Tool 1]]
- [[Resource 1]]

## Related MOCs
- [[Related MOC 1]]
- [[Related MOC 2]]

---

**Total Notes:** X
**Last Updated:** YYYY-MM-DD
```

### Recommended MOCs

**Create These First:**
1. **AI Models MOC** - All model documentation
2. **Coding Assistants MOC** - Tool comparisons
3. **Prompting Techniques MOC** - All prompting methods
4. **Agent Development MOC** - Agent-related content
5. **Learning Paths MOC** - Educational journeys

**Create Later:**
6. Context Engineering MOC
7. RAG Implementation MOC
8. Open Source Models MOC
9. Deployment Tools MOC
10. Workshops & Exercises MOC

---

## Zettelkasten Integration

### Atomic Note Principles

**What Makes a Note Atomic?**
- Focuses on ONE concept/idea
- Self-contained (readable alone)
- Densely linked to related notes
- Has clear title describing content
- Typically 100-500 words

**Implementation Strategy:**

**Phase 1 - New Content:**
- All new notes follow atomic principle
- Template enforces single-concept focus
- Immediate linking to related notes

**Phase 2 - Existing Content:**
- Don't rewrite everything
- Split overly large notes gradually
- Enhance linking over time
- Focus on most-used notes first

### Linking Strategy

**Types of Links:**

1. **Direct References** - Explicit mentions
   - "See [[Note]] for details"
   - "Based on [[Concept]]"

2. **Related Concepts** - Thematic connections
   - "Related: [[Note 1]], [[Note 2]]"
   - Section at note end

3. **Backlinks** - Automatic (Obsidian feature)
   - View what links to current note
   - Discover unexpected connections

4. **MOC Links** - Navigation hubs
   - Index notes link to many notes
   - Notes link back to relevant MOCs

**Linking Density Goal:**
- Minimum: 3-5 links per note
- Optimal: 5-10 links per note
- Maximum: 15+ for hub/MOC notes

### Unique Identifiers (Optional)

**Zettelkasten ID Format:**
- `YYYYMMDDHHMMSS` (timestamp)
- Example: `20251223143022`
- Prepend to filename: `20251223143022-note-title.md`

**Recommendation:**
- **Don't implement initially** - adds complexity
- Consider after 6-12 months if needed
- Obsidian's wiki-links work without IDs
- Can always add later without breaking links

---

## Content Type Definitions

### 1. Fleeting Notes
- **Location:** 0-Inbox/quick-notes/
- **Purpose:** Quick capture, temporary
- **Lifetime:** Process within 1 week
- **Template:** Minimal (date, source, content)

### 2. Literature Notes
- **Location:** 0-Inbox/articles/ → 3-Resources/articles/
- **Purpose:** Summarize external sources
- **Lifetime:** Permanent after processing
- **Template:** Source, summary, key points, quotes

### 3. Permanent Notes
- **Location:** 3-Resources/ (various subcategories)
- **Purpose:** Atomic knowledge units
- **Lifetime:** Permanent, evergreen
- **Template:** Full frontmatter, atomic, linked

### 4. Project Notes
- **Location:** 1-Projects/[project-name]/
- **Purpose:** Project-specific content
- **Lifetime:** Until project archives
- **Template:** Project context, tasks, resources

### 5. Area Notes
- **Location:** 2-Areas/[area-name]/
- **Purpose:** Ongoing standards and tracking
- **Lifetime:** Ongoing, reviewed regularly
- **Template:** Standards, current focus, resources

### 6. Index/MOC Notes
- **Location:** 5-Meta/MOCs/
- **Purpose:** Navigation and context
- **Lifetime:** Permanent, regularly updated
- **Template:** MOC template (see above)

---

## Migration Strategy

### Phase 1: Add New Structure (Week 1)

**Actions:**
1. Create new folders (0-Inbox, 1-Projects, 2-Areas, 4-Archives, 5-Meta)
2. Don't move existing content yet
3. Start using new structure for new content
4. Set up templates

**Result:** Parallel structure exists, no disruption

### Phase 2: Gradual Migration (Weeks 2-4)

**Actions:**
1. Move workshops/ to 1-Projects/ or 4-Archives/
2. Create initial Areas (AI Learning, etc.)
3. Keep 3-Resources/ largely unchanged
4. Add bookmarks/, videos/, articles/ subdirectories

**Result:** PARA structure active, resources intact

### Phase 3: Enhancement (Weeks 5-8)

**Actions:**
1. Create first MOCs
2. Increase linking density
3. Split overly large notes (gradually)
4. Enhance atomic note discipline for new content

**Result:** Zettelkasten principles active

### Phase 4: Optimization (Ongoing)

**Actions:**
1. Regular link gardening
2. MOC expansion
3. Continuous improvement
4. Feedback integration

**Result:** Fully integrated system

---

## Navigation Enhancements

### Enhanced README.md Structure

```markdown
# AI & LLM Engineering Knowledge Base

## Quick Access

**Active Work:**
- [[1-Projects/README|Current Projects]]
- [[0-Inbox/README|Inbox (Process This)]]

**Learn & Explore:**
- [[5-Meta/MOCs/AI-Models-MOC|AI Models Overview]]
- [[5-Meta/MOCs/Learning-Path-MOC|Learning Paths]]

**Reference:**
- [[3-Resources/models/README|Models]]
- [[3-Resources/tools/README|Tools]]
- [[3-Resources/techniques/README|Techniques]]

**Capture:**
- [[0-Inbox/README|Add New Content]]
- [[5-Meta/Templates/README|Templates]]

## Structure
- 0️⃣ Inbox - Quick capture
- 1️⃣ Projects - Active work
- 2️⃣ Areas - Ongoing interests
- 3️⃣ Resources - Reference library
- 4️⃣ Archives - Completed/inactive
- 5️⃣ Meta - Vault management

[Existing content preserved below...]
```

### Hotkeys & Quick Access

**Obsidian Hotkeys (Configure):**
- `Ctrl+N` - New note from template
- `Ctrl+I` - Create inbox note
- `Ctrl+O` - Open quick switcher
- `Ctrl+G` - Open graph view
- `Ctrl+F` - Search vault

**Bookmarks (Obsidian Core Plugin):**
- Bookmark Inbox README
- Bookmark current projects
- Bookmark frequently used MOCs
- Bookmark processing checklist

---

## Quality Standards for New Content

### Frontmatter Requirements

```yaml
---
tags:
  - "#primary-category"
  - "#secondary-category"
type: "project" | "area" | "resource" | "moc" | "note"
status: "active" | "draft" | "published" | "archived"
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source: "URL" (if applicable)
---
```

### Content Requirements

**All Notes Must Have:**
1. Clear, descriptive title (H1)
2. Brief overview/summary (1-2 sentences)
3. Proper frontmatter
4. At least 3 relevant links
5. Source attribution (if external content)

**Resource Notes Should Have:**
6. Main content with structure
7. Examples or applications
8. Resources/sources section
9. Related concepts section

**Project/Area Notes Should Have:**
10. Clear objective or purpose
11. Next actions or tasks
12. Relevant resources linked

---

## Success Metrics

### Structural Health

- ✅ Inbox < 50 items
- ✅ All notes have frontmatter
- ✅ All notes have 3+ links
- ✅ No orphan notes (unlinked)
- ✅ MOCs updated monthly

### Content Quality

- ✅ Sources cited with URLs
- ✅ Atomic notes (one concept)
- ✅ Clear, descriptive titles
- ✅ Last updated dates current

### Usage Patterns

- ✅ Daily inbox additions
- ✅ Weekly inbox processing
- ✅ Monthly MOC reviews
- ✅ Quarterly archive reviews

---

## Conclusion

This architecture:
- ✅ Preserves excellent existing structure
- ✅ Adds PARA for actionability
- ✅ Integrates Zettelkasten for knowledge development
- ✅ Provides clear workflows
- ✅ Supports collaboration
- ✅ Scales with growth

**Next Step:** Review [Implementation Tasks](04-Implementation-Tasks.md) for step-by-step execution.

---

**Architecture Version:** 1.0
**Created:** 2025-12-23
**Status:** Ready for Implementation
