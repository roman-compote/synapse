---
tags:
  - "#guidelines"
  - "#standards"
  - "#knowledge-base"
  - "#obsidian"
date: 2025-12-01
status: published
---

# Knowledge Base Guidelines

Guidelines for maintaining a consistent, searchable, and context-aware knowledge base in Obsidian.

---

## Core Principles

### 1. Context-Aware Organization
- **Atomic Notes:** One concept per file
- **Linking:** Connect related concepts with [[wiki-links]]
- **Tags:** Use semantic tags for categorization
- **Folders:** Organize by topic area (models, tools, techniques, workshops, resources)

### 2. Source Attribution
- **Always cite sources:** Web resources, documentation, research papers
- **Include URLs:** Use markdown links for references
- **Date sources:** Note when information was current
- **Version information:** Specify software/model versions when relevant

### 3. Temporal Awareness
- **Last Updated:** Track when content was last reviewed
- **Date Created:** Document creation date in frontmatter
- **Next Review:** Schedule for reviewing time-sensitive content
- **Version Notes:** Track major updates or changes

---

## File Structure Standards

### Frontmatter (Flexible)

**Recommended Format:**
```yaml
---
tags:
  - "#category"
  - "#subcategory"
date: YYYY-MM-DD
status: draft|published|archived
last_updated: YYYY-MM-DD
next_review: YYYY-MM-DD (optional, for time-sensitive content)
---
```

**Tag Conventions:**
- Use `#` prefix for all tags
- Multi-word tags: use hyphens `#ai-models` not `#ai models`
- Hierarchical: `#tool`, `#tool/coding-assistant`, `#tool/framework`
- Status tags: `#draft`, `#published`, `#archived`, `#needs-review`

### Content Structure

**Recommended Sections (adapt as needed):**

1. **Title** (H1)
2. **Brief Overview** - 1-2 sentences
3. **Main Content** - Organized with H2/H3 headings
4. **Examples** - Practical demonstrations (if applicable)
5. **Resources** - Links to sources
6. **Related Concepts** - Links to related notes
7. **Metadata Footer** - Last updated, version, status

**Example:**
```markdown
---
tags:
  - "#model"
  - "#ai"
date: 2025-12-01
status: published
last_updated: 2025-12-01
---

# Model Name

Brief description of what this is.

---

## Overview

Detailed explanation...

## Key Features

- Feature 1
- Feature 2

## Examples

Practical examples...

## Resources

**Official:**
- [Documentation](https://example.com)

**Community:**
- [Tutorial](https://example.com)

## Related Concepts

- [[Related Note 1]]
- [[Related Note 2]]

---

**Last Updated:** 2025-12-01
**Version:** 1.0
```

---

## Content Types & Templates

### Research Notes
```yaml
tags:
  - "#research"
  - "#topic"
status: draft
date: YYYY-MM-DD
```

**Focus:** Exploration, questions, findings
**Structure:** Flexible, capture insights
**Sources:** Required for all claims

### Reference Documents
```yaml
tags:
  - "#reference"
  - "#topic"
status: published
last_updated: YYYY-MM-DD
next_review: YYYY-MM-DD
```

**Focus:** Comprehensive coverage
**Structure:** Well-organized sections
**Sources:** Extensive citations
**Maintenance:** Regular updates

### Workshop Materials
```yaml
tags:
  - "#workshop"
  - "#topic"
status: draft|published
date: YYYY-MM-DD
```

**Focus:** Teaching, practical exercises
**Structure:** Time-based sections
**Examples:** Required
**Resources:** Extensive

### Quick Notes
```yaml
tags:
  - "#note"
  - "#topic"
date: YYYY-MM-DD
```

**Focus:** Capture ideas quickly
**Structure:** Minimal
**Processing:** Move to inbox, process later

---

## Source Attribution Standards

### Web Resources

**Format:**
```markdown
## Resources

**Official Documentation:**
- [Page Title](https://example.com) - Brief description

**Research & Articles:**
- [Article Title](https://example.com) - Author, Date

**Community Resources:**
- [Resource Name](https://example.com) - Platform

**Last Accessed:** YYYY-MM-DD
```

**Example:**
```markdown
## Resources

**Official Documentation:**
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Anthropic Engineering

**Research Articles:**
- [Building Agents with Claude SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk) - Anthropic, Nov 2025

**Community Resources:**
- [Awesome Claude Subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) - GitHub Collection

**Last Accessed:** 2025-12-01
```

### Academic Sources

**Format:**
```markdown
Author, A. (Year). Title. *Journal*, Volume(Issue), Pages. DOI or URL
```

### Code Examples

**Attribution:**
```markdown
## Example Implementation

Based on: [Source Name](URL)
Modified: Description of changes
License: License type (if applicable)
```

---

## Linking Best Practices

### Internal Links

**Wiki-Links (Preferred):**
```markdown
[[Note Name]]
[[Note Name|Display Text]]
[[folder/Note Name]]
```

**When to Link:**
- First mention of concept
- Related concepts section
- Navigation between topics
- Cross-references

**Avoid:**
- Over-linking (not every mention)
- Circular references without purpose
- Broken links (check regularly)

### External Links

**Inline Links:**
```markdown
The [Claude Code documentation](https://docs.claude.com) provides details.
```

**Reference Style:**
```markdown
See the Claude Code documentation[^1] for details.

[^1]: https://docs.claude.com
```

**Best Practices:**
- Use descriptive link text (not "click here")
- Include URLs in Resources section
- Note when links may expire
- Archive important resources

---

## Tag Strategy

### Hierarchical Tags

**Format:** `#parent/child/grandchild`

**Example:**
```yaml
tags:
  - "#tool"
  - "#tool/coding-assistant"
  - "#tool/coding-assistant/claude-code"
```

### Semantic Categories

**Content Type:**
- `#reference` - Reference documentation
- `#tutorial` - How-to guides
- `#workshop` - Workshop materials
- `#research` - Research notes
- `#example` - Code examples

**Topic Area:**
- `#ai-models`
- `#coding-assistants`
- `#prompting`
- `#agents`
- `#mcp`

**Status:**
- `#draft` - Work in progress
- `#published` - Complete and reviewed
- `#archived` - Historical/deprecated
- `#needs-review` - Requires update

### Tag Maintenance

**Review Regularly:**
- Consolidate similar tags
- Remove unused tags
- Update tag hierarchy
- Document tag meanings

---

## Obsidian-Specific Optimizations

### Search Optimization

**Make Content Searchable:**
- Use clear, descriptive titles
- Include synonyms and alternative terms
- Add examples with realistic scenarios
- Use consistent terminology

**Search Operators:**
```
file:"filename"
tag:#tagname
path:folder/
line:(search term)
```

### Graph View Optimization

**Create Meaningful Connections:**
- Link related concepts
- Use MOCs (Maps of Content) for topic overviews
- Create hub notes for major topics
- Balance links (not too many/few)

### Templates

**Location:** `.obsidian/templates/`

**Useful Templates:**
- New Research Note
- Reference Document
- Workshop Plan
- Meeting Notes
- Daily Note

**Template Variables:**
```markdown
{{date:YYYY-MM-DD}}
{{time:HH:mm}}
{{title}}
```

### Dataview Integration (Optional)

**Track Updates:**
```dataview
TABLE last_updated, status
FROM #reference
WHERE last_updated < date(today) - dur(90 days)
SORT last_updated ASC
```

**Find Drafts:**
```dataview
LIST
FROM #draft
SORT date DESC
```

---

## Maintenance Practices

### Weekly Review

**Tasks:**
- Process inbox notes
- Update stale content
- Fix broken links
- Consolidate similar notes
- Review tags

### Monthly Review

**Tasks:**
- Review time-sensitive content
- Update resources with new findings
- Archive outdated information
- Reorganize if needed
- Update templates

### Quarterly Review

**Tasks:**
- Major content updates
- Reorganize structure if needed
- Audit tag system
- Clean up unused files
- Update guidelines document

---

## Collaboration Guidelines

### Version Control

**Git Best Practices:**
- Commit frequently
- Descriptive commit messages
- Use branches for major updates
- Review before merging

**Commit Message Format:**
```
type: subject

body (optional)
```

**Types:**
- `add`: New content
- `update`: Content updates
- `fix`: Corrections
- `refactor`: Reorganization
- `docs`: Documentation updates

### Shared Knowledge

**Team Practices:**
- Consistent tag usage
- Shared templates
- Regular sync meetings
- Document decisions
- Update CLAUDE.md files

---

## Quality Standards

### Content Quality

**Criteria:**
- **Accuracy:** Fact-checked, sourced
- **Clarity:** Well-written, understandable
- **Completeness:** Covers topic adequately
- **Currency:** Up-to-date information
- **Usefulness:** Practical value

### Technical Accuracy

**For Code Examples:**
- Test before publishing
- Include context and setup
- Specify versions
- Note limitations
- Provide error handling

**For Tools/Models:**
- Verify features
- Check version numbers
- Test claims
- Note deprecations

---

## Special Cases

### Time-Sensitive Content

**Examples:** Model versions, tool features, pricing, benchmarks

**Requirements:**
- Include date in frontmatter
- Set next_review date
- Note when information was current
- Archive when outdated

**Example:**
```yaml
---
date: 2025-12-01
last_updated: 2025-12-01
next_review: 2026-03-01
status: published
note: "Pricing and features current as of December 2025"
---
```

### Deprecated Content

**Don't Delete - Archive:**
```yaml
---
status: archived
deprecated_date: 2025-12-01
replacement: "[[New Document]]"
---

> **⚠️ ARCHIVED:** This information is outdated. See [[New Document]] for current information.
```

### Controversial or Uncertain Content

**Mark Clearly:**
```markdown
> **Note:** This is based on limited information/unverified sources. Treat as preliminary.
```

---

## Tools & Plugins (Recommended)

### Core Plugins
- **Backlinks:** See what links to current note
- **Graph View:** Visualize connections
- **Templates:** Quick note creation
- **Daily Notes:** Regular capture

### Community Plugins (Optional)
- **Dataview:** Query your notes
- **Templater:** Advanced templates
- **Calendar:** Date-based navigation
- **Tag Wrangler:** Manage tags
- **Obsidian Git:** Version control

---

## Summary Checklist

**Before Publishing:**
- [ ] Frontmatter complete
- [ ] Sources cited with URLs
- [ ] Internal links to related notes
- [ ] Appropriate tags applied
- [ ] Examples included (if applicable)
- [ ] Last updated date current
- [ ] Spell-check completed
- [ ] Technical accuracy verified

**Maintenance:**
- [ ] Review time-sensitive content quarterly
- [ ] Update broken links
- [ ] Consolidate duplicates
- [ ] Archive deprecated content
- [ ] Update tags as needed

---

## Resources

**Obsidian Knowledge Management:**
- [Using Obsidian for PKM](https://www.glukhov.org/post/2025/07/obsidian-for-personal-knowledge-management/)
- [Obsidian Best Practices](https://obsidian.rocks/)
- [Weekly Reviews in Second Brain](https://medium.com/@theo-james/weekly-reviews-in-your-second-brain-how-i-do-it-in-obsidian-65af0f6dd5f1)

**Note-Taking Methods:**
- Zettelkasten method
- PARA method (Projects, Areas, Resources, Archives)
- Cornell note-taking
- Second Brain methodology

**Related Guidelines:**
- [[Claude Code Best Practices]]
- [[workshops/Coding Assistants Workshop - Plan|Workshop Planning]]

---

**Last Updated:** 2025-12-01
**Version:** 1.0
**Next Review:** 2026-03-01

*These guidelines are living documents. Suggest improvements as the knowledge base evolves.*
