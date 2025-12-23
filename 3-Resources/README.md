---
tags:
  - "#meta"
  - "#readme"
  - "#resources"
created: 2025-12-23
---

# 3-Resources - Reference Material & Knowledge Repository

## Purpose

Resources is your **permanent knowledge library** - reference material, documentation, and educational content that you return to repeatedly. This is where processed content from [[../0-Inbox/README|Inbox]] lives permanently.

**Key Principle:** Resources are reference material, not actionable items. They support your [[../1-Projects/README|Projects]] and [[../2-Areas/README|Areas]].

---

## Structure Overview

```
3-Resources/
├── models/              # AI/LLM Models
├── tools/               # AI Tools & Frameworks
├── techniques/          # AI Engineering Techniques
├── exercises/           # Hands-on Coding Exercises
├── llm-engineering/     # Core LLM Concepts
├── workshops/           # Workshop Materials
├── bookmarks/           # Web Resources (processed)
├── videos/              # Video Content (processed)
├── articles/            # Articles (processed)
└── resources/           # Meta Resources & News
```

---

## Core Knowledge Areas

### AI Models (`models/`)

Comprehensive documentation of AI/LLM models across all categories.

**Structure:**
- `frontier/` - Latest cutting-edge models (Claude 4, GPT-o1, Gemini, etc.)
- `production/` - Stable production models (Claude 3.5, GPT-4o, etc.)
- `open-source/` - Open source models (Llama, Mistral, Qwen, etc.)
- `local deployment tools/` - Local deployment (Ollama, LM Studio, Open WebUI)

**Navigation:**
- [[../5-Meta/MOCs/AI-Models-MOC|AI Models MOC]] - Complete model landscape
- `models/README.md` - Model selection guide

**Content Types:**
- Model specifications and features
- Pricing and context limits
- Use case recommendations
- Benchmark comparisons
- Setup and configuration guides

---

### Tools & Frameworks (`tools/`)

AI tools, frameworks, coding assistants, and platforms.

**Structure:**
- `coding-assistants/` - Claude Code, Cursor, Aider, Copilot, Windsurf, Amp
- `frameworks/` - LangChain, Fabric, agent frameworks (CrewAI, AutoGen)
- `protocols/` - MCP (Model Context Protocol) and standards

**Navigation:**
- [[../5-Meta/MOCs/Coding-Assistants-MOC|Coding Assistants MOC]] - Tool comparisons
- `tools/coding-assistants/README.md` - Detailed tool comparison

**Content Types:**
- Tool documentation and guides
- Setup instructions
- Best practices
- Feature comparisons
- Use case mapping

---

### Techniques (`techniques/`)

AI engineering methods, patterns, and best practices.

**Structure:**
- `prompting/` - Prompt engineering patterns
- `agents/` - Agent design and development
- `context-engineering/` - Context window optimization
- `RAG/` - Retrieval-Augmented Generation

**Navigation:**
- [[../5-Meta/MOCs/Prompting-Techniques-MOC|Prompting Techniques MOC]]
- `techniques/README.md` - Techniques overview

**Content Types:**
- Technique explanations
- Implementation patterns
- Code examples
- Best practices
- Common pitfalls

---

### Exercises (`exercises/`)

Hands-on coding exercises and implementations with Jupyter notebooks.

**Structure:**
- LLM Engineering exercises (Basics, Gradio, Tools, Code Generation)
- Advanced topics (RAG implementation)
- Agent frameworks (OpenAI SDK, LangGraph, LangChain)

**Navigation:**
- [[../5-Meta/MOCs/Learning-Path-MOC|Learning Path MOC]] - Structured progressions
- `exercises/README.md` - Exercise guide and setup

**Content Types:**
- Jupyter notebooks (.ipynb)
- Exercise documentation
- Setup instructions
- Learning outcomes
- Solutions and explanations

---

### LLM Engineering (`llm-engineering/`)

Core LLM engineering concepts and fundamentals.

**Content:**
- LLM Engineering overview
- Model fundamentals
- Tools overview
- Techniques overview

**Purpose:** High-level conceptual understanding before diving into specific areas.

---

### Workshops (`workshops/`)

Workshop materials, plans, and teaching content.

**Current Workshops:**
- Building Coding Agents Workshop
- Coding Assistants Workshop

**Content Types:**
- Workshop plans and agendas
- Prerequisites and setup
- Exercise sequences
- Learning objectives
- Teaching notes

---

## Captured Content (Processed from Inbox)

### Bookmarks (`bookmarks/`)

Web resources and links that have been processed from [[../0-Inbox/bookmarks/|Inbox]].

**Structure:**
- `Documentation/` - Official docs, API references
- `Tutorials/` - How-to guides and tutorials
- `Research-Papers/` - Academic papers and research
- `Tools-and-Resources/` - Useful online tools and resources

**Template:** [[../5-Meta/Templates/bookmark-template|bookmark-template.md]]

**Processing:** See [[../5-Meta/Guidelines/Processing-Workflow|Processing Workflow]]

---

### Videos (`videos/`)

YouTube videos, conference talks, and lectures that have been processed.

**Structure:**
- `Tutorials/` - Tutorial videos and how-tos
- `Conferences/` - Conference talks and presentations
- `Lectures/` - Educational lectures and courses
- `Quick-Tips/` - Short-form educational content

**Template:** [[../5-Meta/Templates/video-template|video-template.md]]

**Content Includes:**
- Video metadata (channel, duration, URL)
- Key takeaways with timestamps
- Detailed notes
- Action items

---

### Articles (`articles/`)

Articles, blog posts, and written content that has been processed.

**Structure:**
- `Technical/` - Technical articles and deep dives
- `Opinion/` - Opinion pieces and thought leadership
- `News/` - Industry news and announcements

**Template:** [[../5-Meta/Templates/article-template|article-template.md]]

**Content Includes:**
- Article summaries
- Key points and insights
- Notable quotes
- Personal reflections
- Action items

---

### Meta Resources (`resources/`)

Meta resources about the AI/LLM ecosystem.

**Structure:**
- `news/` - Latest AI/LLM developments and updates

**Content:**
- Industry news
- Model releases
- Tool announcements
- Ecosystem updates

---

## Content Standards

### For All Resources

**Required:**
- ✅ Proper frontmatter (tags, dates, status)
- ✅ Clear, descriptive title
- ✅ Source attribution with URLs
- ✅ Last updated date (for time-sensitive content)
- ✅ At least 3-5 relevant links to related concepts
- ✅ "Related Concepts" section

**Encouraged:**
- Examples and practical applications
- Visual aids (diagrams, screenshots)
- Code samples where relevant
- Cross-references to exercises or workshops

### Time-Sensitive Content

Models, tools, pricing, and features change frequently:
- Include `last_updated` in frontmatter
- Note what changed in updates
- Archive outdated versions to [[../4-Archives/README|4-Archives]]
- Link to current version from archived content

See [[../5-Meta/Guidelines/Knowledge-Base-Guidelines|Knowledge Base Guidelines]] for full standards.

---

## Adding New Resources

### From Inbox (Recommended Workflow)

1. **Capture** content to [[../0-Inbox/README|0-Inbox]] using appropriate subfolder
2. **Process** during weekly review:
   - Extract key points
   - Add proper tags
   - Link to 3+ related concepts
   - Use appropriate template
3. **Move** to permanent location in `3-Resources/`
4. **Link** from relevant [[../5-Meta/MOCs/README|MOCs]]

### Direct Creation (For Urgent Content)

1. Create file in appropriate subfolder
2. Use [[../5-Meta/Templates/permanent-note-template|permanent-note-template]]
3. Fill in all required fields
4. Link to existing related content
5. Add to relevant MOCs
6. Update any README files

---

## Navigation Tips

**Finding Content:**
- Use [[../5-Meta/MOCs/README|MOCs]] for topic overviews
- Use Obsidian search for keywords
- Use tags for filtering
- Use graph view for connections
- Check README files in each folder

**Staying Current:**
- Review `models/` monthly for new releases
- Review `tools/` monthly for updates
- Check `resources/news/` weekly
- Update `last_updated` dates when content changes

---

## Relationship to Other Folders

**0-Inbox → 3-Resources:**
- Inbox is temporary capture
- Resources is permanent home
- Process weekly to move content

**3-Resources → 1-Projects:**
- Resources inform and support projects
- Projects reference resources
- Completed projects archive, resources stay

**3-Resources → 2-Areas:**
- Resources support area standards
- Areas link to relevant resources
- Areas define what resources to prioritize

**3-Resources → 5-Meta:**
- MOCs organize and navigate resources
- Templates ensure consistent resource quality
- Guidelines define resource standards

---

## Maintenance

**Weekly:**
- Process new content from Inbox
- Add to appropriate subfolders
- Link to related concepts

**Monthly:**
- Update time-sensitive content (models, tools)
- Add new content to MOCs
- Check for outdated information

**Quarterly:**
- Major content audit
- Archive outdated content to [[../4-Archives/README|4-Archives]]
- Reorganize if needed
- Update navigation and READMEs

---

## Related

- [[../0-Inbox/README|0-Inbox]] - Where content enters
- [[../5-Meta/MOCs/README|MOCs]] - Navigation hubs
- [[../5-Meta/Templates/README|Templates]] - Content templates
- [[../5-Meta/Guidelines/Processing-Workflow|Processing Workflow]] - How to maintain
- [[../README|Main README]] - Vault overview

---

**Remember:** Resources are your knowledge library. Keep it organized, up-to-date, and well-linked. Quality over quantity - every resource should earn its place by being genuinely useful.
