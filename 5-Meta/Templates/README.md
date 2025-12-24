---
tags:
  - "#meta"
  - "#templates"
  - "#readme"
created: 2025-12-23
---

# Templates - Consistent Structure for All Content

## Purpose

Templates provide **consistent structure and quality** across all notes in the vault. They ensure proper metadata, clear organization, and complete information capture.

---

## Available Templates

### Core Templates

#### [[5-Meta/Templates/project-template|project-template.md]]
**Use for:** Time-bound projects with specific outcomes and deadlines

**Includes:**
- Objective and outcomes
- Task tracking
- Resource links
- Status tracking
- Timeline

**Example uses:**
- Workshop preparation
- Learning goals with deadlines
- Specific development projects

---

#### [[5-Meta/Templates/area-template|area-template.md]]
**Use for:** Ongoing responsibilities and interests without end dates

**Includes:**
- Purpose and standards
- Current focus areas
- Related projects
- Review schedule

**Example uses:**
- AI/LLM Learning (ongoing)
- Workshop Planning & Teaching
- Knowledge Base Management

---

### Resource Templates

#### [[5-Meta/Templates/bookmark-template|bookmark-template.md]]
**Use for:** Web bookmarks and links to process

**Includes:**
- URL and metadata
- Summary and key points
- Relevance and context
- Action items
- Related concepts

---

#### [[5-Meta/Templates/video-template|video-template.md]]
**Use for:** YouTube videos, lectures, conference talks

**Includes:**
- Video metadata (channel, duration)
- Timestamped notes
- Key takeaways
- Action items
- Related concepts

---

#### [[5-Meta/Templates/course-template|course-template.md]]
**Use for:** Online courses (Udemy, Coursera, Pluralsight, etc.)

**Includes:**
- Course metadata (platform, instructor, duration, URL)
- Key learnings and concepts
- Practical patterns and techniques
- Tools and technologies covered
- Personal assessment and recommendations
- Action items for implementation

**Note:** Focus on **what you learned**, not just course outline.

---

#### [[5-Meta/Templates/article-template|article-template.md]]
**Use for:** Articles, blog posts, technical documentation

**Includes:**
- Article metadata (author, date)
- Summary and key points
- Notable quotes
- Personal reflections
- Related concepts

---

### Knowledge Templates

#### [[5-Meta/Templates/permanent-note-template|permanent-note-template.md]]
**Use for:** Evergreen, atomic knowledge notes (Zettelkasten style)

**Includes:**
- Single concept focus
- Clear explanation
- Examples
- Related concept links
- Source attribution

**Example uses:**
- Concept definitions
- Technique explanations
- Best practices
- Mental models

---

## How to Use Templates

### In Obsidian

**Method 1: Command Palette**
1. Create a new note or open existing note
2. Press `Ctrl/Cmd + P`
3. Type "Templates: Insert template"
4. Select the appropriate template
5. Fill in the placeholders

**Method 2: Hotkey (if configured)**
1. Create a new note
2. Press your configured template hotkey
3. Select template from list
4. Fill in placeholders

**Method 3: Template Folder**
1. Navigate to `5-Meta/Templates/`
2. Copy the template you need
3. Paste into your new note
4. Fill in placeholders

---

## Configuring Templates in Obsidian

1. **Settings** → **Core Plugins** → Enable "Templates"
2. **Settings** → **Templates** → Set:
   - Template folder: `5-Meta/Templates`
   - Date format: `YYYY-MM-DD`
   - Time format: `HH:mm`

**Optional: Set Hotkeys**
- **Settings** → **Hotkeys** → Search "Templates"
- Assign keyboard shortcut for "Insert template"

---

## Template Placeholders

Common placeholders used in templates:

- `{{title}}` - Note title
- `{{date:YYYY-MM-DD}}` - Current date
- `{{time:HH:mm}}` - Current time
- `URL` - Replace with actual URL
- `[Your text here]` - Replace with your content

**Note:** Some placeholders are Obsidian-specific and auto-populate. Others are manual placeholders to remind you what to fill in.

---

## When to Use Each Template

| Content Type | Template | Location |
|--------------|----------|----------|
| Workshop planning | project-template | 1-Projects/ |
| Ongoing learning | area-template | 2-Areas/ |
| Web link to save | bookmark-template | 0-Inbox/bookmarks/ |
| YouTube video | video-template | 0-Inbox/videos/ |
| Online course | course-template | 3-Resources/courses/ |
| Blog post | article-template | 0-Inbox/web-clips/ |
| Quick idea | quick-note or none | 0-Inbox/quick-notes/ |
| Concept definition | permanent-note-template | 3-Resources/ |
| Model documentation | permanent-note-template | 3-Resources/models/ |
| Tool guide | permanent-note-template | 3-Resources/tools/ |

---

## Customizing Templates

**Feel free to customize!** Templates are starting points, not rigid requirements.

**Good reasons to customize:**
- Add fields specific to your workflow
- Remove sections you never use
- Adjust for specific content types
- Incorporate your organization's standards

**Keep these consistent:**
- Frontmatter structure (tags, dates, status)
- Source attribution
- Related concepts section
- Clear headings

---

## Creating New Templates

**When to create a new template:**
- You're creating the same structure repeatedly
- A specific content type needs consistent formatting
- Team collaboration requires standardization

**How to create:**
1. Create file in `5-Meta/Templates/`
2. Name it descriptively: `[type]-template.md`
3. Include:
   - YAML frontmatter
   - Clear section headings
   - Placeholders for variable content
   - Usage instructions (as comments)
4. Document it here in this README
5. Test it with real content

---

## Template Best Practices

**DO:**
- ✅ Include comprehensive frontmatter (tags, dates, type, status)
- ✅ Use clear, consistent headings
- ✅ Add "Related" section for linking
- ✅ Include metadata footer (created, updated dates)
- ✅ Make placeholders obvious

**DON'T:**
- ❌ Make templates too complex or rigid
- ❌ Include content that won't apply to all uses
- ❌ Forget to update templates when workflows change
- ❌ Create templates for one-off use cases

---

## Related

- [[5-Meta/Guidelines/Knowledge-Base-Guidelines]] - Content standards
- [[5-Meta/Guidelines/Contribution-Guidelines]] - How to contribute
- [[0-Inbox/README]] - Where templated notes often start
- [[5-Meta/README]] - Meta folder overview

---

**Remember:** Templates are tools for consistency, not constraints. Use what helps, skip what doesn't. The best template is one you actually use.
