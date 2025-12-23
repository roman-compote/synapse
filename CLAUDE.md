# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Repository Overview

This is an **Obsidian knowledge vault** for AI/LLM Engineering education. It contains structured documentation, workshop materials, practical exercises, and reference content for learning and teaching AI development, coding assistants, and LLM engineering concepts.

**Primary Purpose:** Educational knowledge base maintained in Markdown with Obsidian-specific features (wiki-links, tags, frontmatter).

---

## Repository Structure

This vault uses **PARA Method + Zettelkasten** for organization:

```
.
├── 0-Inbox/                   # Quick capture landing zone (process weekly)
│   ├── web-clips/            # Articles clipped via Obsidian Web Clipper
│   ├── bookmarks/            # Browser bookmarks to process
│   ├── videos/               # YouTube videos and talks
│   └── quick-notes/          # Fleeting ideas and temporary notes
├── 1-Projects/               # Active, time-bound work with deadlines
│   └── README.md             # Project management guidelines
├── 2-Areas/                  # Ongoing responsibilities and interests
│   ├── AI-Learning/          # Continuous AI/LLM skill development
│   └── README.md             # Area management guidelines
├── 3-Resources/              # Reference material and knowledge repository
│   ├── models/               # LLM model documentation
│   │   ├── frontier/         # Latest cutting-edge models
│   │   ├── production/       # Stable production models
│   │   ├── open-source/      # Open source models
│   │   └── local deployment tools/ # Ollama, LM Studio, etc.
│   ├── tools/                # AI tools, frameworks, platforms
│   │   ├── coding-assistants/ # Claude Code, Cursor, etc.
│   │   ├── frameworks/       # LangChain, Fabric, etc.
│   │   └── protocols/        # MCP documentation
│   ├── techniques/           # AI engineering techniques
│   │   ├── prompting/        # Prompt engineering
│   │   ├── agents/           # Agent development
│   │   ├── context-engineering/ # Context optimization
│   │   └── RAG/              # Retrieval-Augmented Generation
│   ├── exercises/            # Hands-on coding exercises
│   ├── llm-engineering/      # Core LLM engineering concepts
│   ├── workshops/            # Workshop materials and plans
│   ├── bookmarks/            # Processed web bookmarks
│   │   ├── Documentation/
│   │   ├── Tutorials/
│   │   ├── Research-Papers/
│   │   └── Tools-and-Resources/
│   ├── videos/               # Processed video notes
│   │   ├── Tutorials/
│   │   ├── Conferences/
│   │   ├── Lectures/
│   │   └── Quick-Tips/
│   ├── articles/             # Processed article notes
│   │   ├── Technical/
│   │   ├── Opinion/
│   │   └── News/
│   └── resources/            # Meta resources
│       └── news/             # Latest AI/LLM developments
├── 4-Archives/               # Completed projects and outdated content
│   ├── projects/             # Completed projects by year
│   ├── areas/                # Inactive areas
│   └── outdated/             # Superseded documentation
├── 5-Meta/                   # Vault management and navigation
│   ├── Templates/            # Note templates for consistency
│   │   ├── project-template.md
│   │   ├── area-template.md
│   │   ├── bookmark-template.md
│   │   ├── video-template.md
│   │   ├── article-template.md
│   │   └── permanent-note-template.md
│   ├── MOCs/                 # Maps of Content (navigation hubs)
│   │   ├── AI-Models-MOC.md
│   │   ├── Coding-Assistants-MOC.md
│   │   ├── Prompting-Techniques-MOC.md
│   │   └── Learning-Path-MOC.md
│   ├── Guidelines/           # Vault standards and workflows
│   │   ├── Knowledge-Base-Guidelines.md
│   │   └── Processing-Workflow.md
│   └── Implementation-Planning/ # Historical planning documentation
├── README.md                 # Main navigation hub
└── CLAUDE.md                 # This file - AI assistant guidance
```

**Workflow:** Capture (0-Inbox) → Process (Weekly) → Organize (3-Resources) → Link (Zettelkasten)

---

## Content Standards

### File Format
- **Format:** Markdown (.md files)
- **Frontmatter:** YAML with tags, dates, status
- **Links:** Use `[[wiki-links]]` for internal references
- **Tags:** Hierarchical with `#` prefix (e.g., `#tool/coding-assistant`)

### Frontmatter Template
```yaml
---
tags:
  - "#category"
  - "#subcategory"
date: YYYY-MM-DD
status: draft|published|archived
last_updated: YYYY-MM-DD
---
```

### Content Structure
1. **Title (H1)** - Clear, descriptive
2. **Brief overview** - 1-2 sentence summary
3. **Main content** - Well-organized with H2/H3 headings
4. **Examples** - Practical demonstrations (when applicable)
5. **Resources** - Cited sources with URLs
6. **Related Concepts** - Wiki-links to related notes
7. **Metadata footer** - Last updated, version, status

### Documentation Guidelines

**Source Attribution (REQUIRED):**
- Always cite sources with markdown links
- Include "Last Updated" dates for time-sensitive content
- Note API version numbers, model versions, tool versions
- Use this format for resources sections:

```markdown
## Resources

**Official Documentation:**
- [Page Title](https://example.com) - Brief description

**Research & Articles:**
- [Article Title](https://example.com) - Author, Date

**Last Accessed:** YYYY-MM-DD
```

**Time-Sensitive Content:**
- Models, tools, pricing, benchmarks change frequently
- Always include `date` and `last_updated` in frontmatter
- Add notes like "Current as of December 2025"
- Archive outdated content rather than deleting

**Content Quality:**
- Be accurate and fact-check claims
- Provide practical, actionable information
- Include real examples where helpful
- Maintain consistency with existing notes
- Follow [[5-Meta/Guidelines/Knowledge-Base-Guidelines|Knowledge Base Guidelines]] (read this file for full standards)

---

## Common Tasks

### Capturing New Content

**When you encounter valuable content:**

1. **Quick Capture to Inbox:**
   - Articles/web pages → `0-Inbox/web-clips/` (use Web Clipper)
   - Bookmarks → `0-Inbox/bookmarks/` (use bookmark template)
   - Videos → `0-Inbox/videos/` (use video template)
   - Quick ideas → `0-Inbox/quick-notes/` (minimal or no template)

2. **Use Appropriate Template:**
   - Find templates in `5-Meta/Templates/`
   - Fill in only essential fields initially
   - Add just enough context to remember why it's valuable

3. **Don't overthink:**
   - Trust the weekly processing workflow
   - Capture first, organize later
   - Goal: Low friction, high capture rate

### Processing Inbox Content

**Follow the weekly workflow** ([[5-Meta/Guidelines/Processing-Workflow|Processing Workflow]]):

1. **Review each item** in `0-Inbox/`
2. **Extract key points** and insights
3. **Add proper tags** and metadata
4. **Link to 3+ related concepts**
5. **Move to permanent location:**
   - Articles → `3-Resources/articles/`
   - Bookmarks → `3-Resources/bookmarks/`
   - Videos → `3-Resources/videos/`
   - Concepts → Appropriate folder in `3-Resources/`
   - Or delete if no longer valuable

### Adding New Model Documentation

1. **Capture quickly** to `0-Inbox/` first (if urgent, go direct to step 2)
2. **Determine category:** `3-Resources/models/frontier/`, `production/`, or `open-source/`
3. **Use permanent-note-template** or follow existing model note structure
4. Create file with standard frontmatter:
```yaml
---
tags:
  - "#model"
  - "#ai"
  - "#[category]"
date: YYYY-MM-DD
status: published
last_updated: YYYY-MM-DD
---
```
5. Include sections: Overview, Key Features, Use Cases, Pricing, Resources
6. Update `models/README.md` comparison tables
7. Link from relevant MOCs (e.g., [[5-Meta/MOCs/AI-Models-MOC|AI Models MOC]])
8. Link from main `README.md` if significant

### Adding Tool/Framework Documentation

1. **Capture to Inbox** or create directly in `3-Resources/tools/`
2. Place in appropriate subdirectory: `coding-assistants/`, `frameworks/`, or `protocols/`
3. Use permanent-note-template for consistency
4. Include: Overview, Setup, Usage Examples, Comparison with alternatives
5. Cross-reference related concepts
6. Update relevant MOCs (e.g., [[5-Meta/MOCs/Coding-Assistants-MOC|Coding Assistants MOC]])
7. Update relevant README files

### Updating Time-Sensitive Content

1. Read existing file to understand current state
2. Update content with new information
3. Update `last_updated` field in frontmatter
4. Note what changed in the content (e.g., "Updated as of December 2025")
5. If drastically outdated:
   - Move to `4-Archives/outdated/`
   - Create new version in `3-Resources/`
   - Add redirect note or link to new version

### Creating Projects

1. Use [[5-Meta/Templates/project-template|project template]]
2. Create in `1-Projects/[Project-Name]/`
3. Define objective, outcomes, and tasks
4. Set deadline
5. Link to related areas (e.g., [[2-Areas/AI-Learning/AI-Learning|AI Learning]])
6. Link to relevant resources from `3-Resources/`
7. When complete:
   - Document outcomes and learnings
   - Move to `4-Archives/projects/[year]/`

### Creating Areas

1. Use [[5-Meta/Templates/area-template|area template]]
2. Create in `2-Areas/[Area-Name]/`
3. Define purpose, standards, and current focus
4. Set review schedule (weekly, monthly, quarterly)
5. Link to related projects and resources
6. Review regularly according to schedule

### Creating Workshop Materials

1. **Capture ideas** to `0-Inbox/quick-notes/` first
2. When ready, create **project** in `1-Projects/Workshop-[Name]/`
3. Place deliverables in `workshops/` directory (for backward compatibility)
4. Follow structured format: Overview, Prerequisites, Schedule, Exercises, Resources
5. Link to relevant concept documentation from `3-Resources/`
6. Cross-reference exercises from `3-Resources/exercises/`
7. When complete, archive to `4-Archives/projects/[year]/`

### Adding Exercises

1. Place notebook files and documentation in `3-Resources/exercises/`
2. Update `exercises/README.md` with new exercise entry
3. Include: Level, Duration, Technologies, Learning Outcomes
4. Provide clear setup instructions
5. Link to related concept documentation
6. Add to [[5-Meta/MOCs/Learning-Path-MOC|Learning Path MOC]]

### Creating Maps of Content (MOCs)

1. When you have 10+ related notes on a topic
2. Create MOC in `5-Meta/MOCs/[Topic]-MOC.md`
3. Structure: Overview, Core Concepts, Sub-Topics, Learning Path
4. Link to all relevant notes
5. Add context for each link (not just lists)
6. Link from main README if major topic
7. Update regularly as content grows

---

## Navigation & Discovery

### Main Entry Points

**Primary Navigation:**
- `README.md` - Main vault navigation hub with quick capture, structure overview, and content links
- `5-Meta/README.md` - Templates, MOCs, and guidelines
- `0-Inbox/README.md` - Capture workflow and processing instructions

**Content Organization:**
- `1-Projects/README.md` - Active projects and time-bound work
- `2-Areas/README.md` - Ongoing areas of responsibility
- `3-Resources/README.md` - Reference material (models, tools, techniques, exercises)
- `4-Archives/README.md` - Completed and outdated content

**Maps of Content (MOCs):**
- `5-Meta/MOCs/AI-Models-MOC.md` - Complete model landscape
- `5-Meta/MOCs/Coding-Assistants-MOC.md` - Tool comparisons
- `5-Meta/MOCs/Prompting-Techniques-MOC.md` - Prompt engineering
- `5-Meta/MOCs/Learning-Path-MOC.md` - Structured learning progressions

**Detailed Guides:**
- `3-Resources/models/README.md` - Comprehensive model comparison and selection
- `3-Resources/exercises/README.md` - Exercise progression paths and setup
- `3-Resources/tools/coding-assistants/README.md` - Coding assistant comparisons

### Finding Content

**Search Strategies:**
- **Obsidian search** for keywords
- **MOCs** for topic-based navigation (start here for overview)
- **Tags** to find related content (e.g., `#workshop`, `#reference`, `#model`)
- **Graph view** to discover connections
- **README files** in each directory for overviews

**Follow the Workflow:**
1. New content → `0-Inbox/` (appropriate subfolder)
2. Weekly processing → Extract, tag, link
3. Permanent home → `3-Resources/` or relevant area
4. Discovery → MOCs, links, search

### Link Patterns

**Zettelkasten Principles:**
- First mention of concept → link to definition
- "Related Concepts" section at end of documents
- Bidirectional linking (use Obsidian backlinks)
- **Minimum 3-5 links per note** (more is better)
- Link to MOCs for topic overviews
- Link to templates when referencing workflows

**Wiki-Link Syntax:**
- Prefer relative wiki-links: `[[folder/Note Name]]`
- Display text: `[[folder/Note Name|Display Text]]`
- Link to sections: `[[Note Name#Section]]`

---

## Working with This Repository

### Reading/Understanding Code
- This is a **documentation-only** repository (no executable code)
- Exercise documentation references separate `.ipynb` notebook files
- Focus on Markdown structure, links, and organization

### Making Changes
- **Read existing content first** to match style and standards
- **Use appropriate templates** from `5-Meta/Templates/`
- Maintain consistency with existing frontmatter and structure
- Follow guidelines in [[5-Meta/Guidelines/Knowledge-Base-Guidelines|Knowledge Base Guidelines]]
- Follow workflow in [[5-Meta/Guidelines/Processing-Workflow|Processing Workflow]]
- Update cross-references when moving or renaming files
- Update relevant MOCs when adding new content

### Git Workflow
- Descriptive commit messages following conventional commits
- Commit types: `add:`, `update:`, `fix:`, `refactor:`, `docs:`
- Small, focused commits
- Check for broken links before committing

### Quality Checks Before Committing
- [ ] Frontmatter complete and properly formatted
- [ ] Sources cited with working URLs
- [ ] Internal wiki-links valid
- [ ] Appropriate tags applied
- [ ] Last updated date current
- [ ] Spelling and grammar checked
- [ ] Technical accuracy verified
- [ ] Consistent with existing content style

---

## Special Considerations

### Obsidian-Specific Features
- **Wiki-links:** `[[Note Name]]` or `[[Note Name|Display Text]]`
- **Tags:** Hierarchical, e.g., `#tool/coding-assistant/claude-code`
- **Frontmatter:** YAML block for metadata
- **Graph view:** Link structure matters for visualization
- **No execution:** This is pure documentation, not executable code

### Educational Context
- Content is designed for **teaching and workshops**
- Balance depth with accessibility
- Include practical examples where possible
- Assume readers are learning AI/LLM concepts

### Version Control of Knowledge
- **Archive, don't delete:** Outdated content has historical value
- Mark deprecated content clearly
- Provide migration paths to current information
- Track when information becomes outdated

---

## Key Files to Reference

**Essential Documentation:**
- **[[README|README.md]]** - Main navigation hub and quick reference
- **[[5-Meta/Guidelines/Knowledge-Base-Guidelines|Knowledge Base Guidelines]]** - Comprehensive content standards
- **[[5-Meta/Guidelines/Processing-Workflow|Processing Workflow]]** - Capture → Process → Link workflow
- **[[5-Meta/README|5-Meta/README.md]]** - Templates, MOCs, and vault management

**Templates:**
- **[[5-Meta/Templates/README|Templates Overview]]** - All available templates
- **[[5-Meta/Templates/project-template|Project Template]]** - For time-bound work
- **[[5-Meta/Templates/area-template|Area Template]]** - For ongoing responsibilities
- **[[5-Meta/Templates/permanent-note-template|Permanent Note Template]]** - For evergreen concepts

**Maps of Content:**
- **[[5-Meta/MOCs/README|MOCs Overview]]** - Navigation hub concepts
- **[[5-Meta/MOCs/AI-Models-MOC|AI Models MOC]]** - Model landscape
- **[[5-Meta/MOCs/Learning-Path-MOC|Learning Path MOC]]** - Structured learning

**Folder Guidelines:**
- **[[0-Inbox/README|0-Inbox/README.md]]** - Capture and processing workflow
- **[[1-Projects/README|1-Projects/README.md]]** - Project management
- **[[2-Areas/README|2-Areas/README.md]]** - Area management
- **[[4-Archives/README|4-Archives/README.md]]** - Archiving guidelines

**Content Guides:**
- **[[3-Resources/models/README|3-Resources/models/README.md]]** - Model selection and comparison framework
- **[[3-Resources/exercises/README|3-Resources/exercises/README.md]]** - Exercise structure and learning paths
- **[[3-Resources/tools/coding-assistants/Claude Code Best Practices|Claude Code Best Practices]]** - Claude-specific guidance

---

## Anti-Patterns (Avoid These)

**Content Creation:**
- ❌ Creating files without proper frontmatter
- ❌ Failing to cite sources
- ❌ Missing "Last Updated" dates on time-sensitive content
- ❌ Vague or unclear file names
- ❌ Repeating information that exists elsewhere (link instead)

**Organization:**
- ❌ Skipping Inbox - creating directly in final location without processing
- ❌ Letting Inbox grow beyond 50 unprocessed items
- ❌ Creating files without using appropriate templates
- ❌ Orphaned files with no links to/from them (< 3 links)
- ❌ Deleting outdated content instead of archiving to `4-Archives/`

**Linking:**
- ❌ Breaking existing wiki-links when renaming files
- ❌ Not updating MOCs when adding new content
- ❌ Creating notes with fewer than 3 related links
- ❌ Not linking to relevant templates in documentation

**Workflow:**
- ❌ Not following the Processing Workflow for weekly reviews
- ❌ Over-engineering during capture (keep it simple!)
- ❌ Perfectionism blocking content creation (done > perfect)
- ❌ Inconsistent tag usage across similar content

---

**Maintained by:** Roman
**Repository Type:** Obsidian Vault (Educational Knowledge Base)
**Structure:** PARA Method + Zettelkasten
**Last Updated:** 2025-12-23
