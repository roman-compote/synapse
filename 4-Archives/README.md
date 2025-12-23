---
tags:
  - "#meta"
  - "#readme"
  - "#archives"
created: 2025-12-23
---

# 4-Archives - Completed & Inactive Content

## Purpose

The Archives store **completed projects, inactive areas, and outdated content** that is no longer actively used but may have historical or reference value.

**Key Principle:** Archive, don't delete. Past work has value for context and learning.

---

## What Goes Here

### Completed Projects (projects/)
- Finished workshops and events
- Completed learning initiatives
- Delivered projects with documented outcomes
- One-time research that reached conclusion

### Inactive Areas (areas/)
- Responsibilities you're no longer maintaining
- Interests you've moved on from
- Areas that are on hold indefinitely

### Outdated Content (outdated/)
- Deprecated model documentation
- Superseded tool guides
- Historical versions of content
- Old benchmarks and comparisons

### Time-Specific Content (by-year/)
- Workshops by year (2024/, 2025/, etc.)
- Annual projects
- Dated references

---

## Structure

```
4-Archives/
├── projects/
│   ├── 2024/
│   │   └── completed-project/
│   └── 2025/
│       └── recent-project/
├── areas/
│   └── inactive-area/
├── outdated/
│   ├── models/
│   └── tools/
└── workshops/
    ├── 2024/
    └── 2025/
```

---

## Guidelines

**When to Archive:**

**Projects:**
- ✅ All deliverables completed
- ✅ Outcomes documented
- ✅ Lessons learned captured
- ✅ No further action needed

**Areas:**
- ✅ No longer relevant to current work
- ✅ Not reviewed in 3+ months
- ✅ Responsibility transferred or ended
- ✅ Interest shifted elsewhere

**Content:**
- ✅ Information is outdated or superseded
- ✅ Model/tool is deprecated
- ✅ Better documentation exists elsewhere
- ✅ Historical value only

**How to Archive:**

1. **Add archive metadata** to frontmatter:
   ```yaml
   status: archived
   archived_date: 2025-12-23
   archived_reason: "Project completed" or "Outdated content"
   ```

2. **Document completion/outcome:**
   - For projects: Add final results and learnings
   - For areas: Note why it became inactive
   - For content: Link to current version if applicable

3. **Preserve important links:**
   - Keep cross-references intact
   - Add redirect notes if content moved
   - Update MOCs to reflect archived status

4. **Move to appropriate archive folder:**
   - Projects → `4-Archives/projects/[year]/`
   - Areas → `4-Archives/areas/`
   - Content → `4-Archives/outdated/`

5. **Update related notes:**
   - Remove from active lists
   - Update references in other notes
   - Maintain backlinks for context

---

## Archive vs Delete

**Archive when:**
- Content might be useful for reference
- You may want to revisit approach
- Historical context has value
- Someone else might reference it

**Delete when:**
- Content is completely irrelevant
- Information is incorrect and misleading
- Privacy or security concern
- Truly has zero value

**Default: Archive.** Storage is cheap, context is valuable.

---

## Searching Archives

Archives are still searchable within Obsidian:
- Use search with `path:4-Archives/`
- Filter by tags and dates
- Check graph view for connections
- Use backlinks to find related active content

---

## Maintenance

**Monthly:**
- Archive completed projects from last month
- Update archived content metadata

**Quarterly:**
- Review areas for archiving
- Clean up outdated content
- Update outdated/ folder with superseded docs
- Verify links are still working

**Annually:**
- Major archive cleanup
- Organize by year
- Remove truly valueless content
- Update documentation standards

---

## Related

- [[1-Projects/README]] - Active projects (before archiving)
- [[2-Areas/README]] - Active areas (before archiving)
- [[3-Resources/README]] - Current, active reference content
- [[5-Meta/Guidelines/Processing-Workflow]] - When and how to archive

---

**Remember:** The archive is a museum, not a graveyard. Past work informs future decisions. Keep it organized, searchable, and accessible.
