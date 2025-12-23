---
tags:
  - "#meta"
  - "#workflow"
  - "#guidelines"
created: 2025-12-23
---

# Processing Workflow

How to process items from Inbox to permanent locations using a sustainable, consistent workflow.

---

## Overview

This workflow implements a **capture → process → link** system inspired by GTD (Getting Things Done) and Zettelkasten principles.

**Core Principle:** Lower friction for capture, higher quality for processing.

---

## Daily Capture (5-10 min/day)

### Quick Capture Workflow

**Goal:** Capture everything worth keeping without overthinking.

**When you encounter valuable content:**

1. **Article or blog post?**
   - → Use Obsidian Web Clipper extension
   - → Save to `0-Inbox/web-clips/`
   - → No processing needed yet

2. **Bookmark or link?**
   - → Create note from bookmark template
   - → Add URL, title, brief note on why it's relevant
   - → Save to `0-Inbox/bookmarks/`

3. **Video to watch?**
   - → Create note from video template
   - → Add URL, title, channel
   - → Save to `0-Inbox/videos/`

4. **Quick idea or insight?**
   - → Create quick note (minimal template or freeform)
   - → Capture the thought
   - → Save to `0-Inbox/quick-notes/`

**Key Rules:**
- ✅ Spend < 2 minutes per capture
- ✅ Add just enough context to remember why it matters
- ✅ Trust the weekly review process
- ❌ Don't organize, tag extensively, or link yet
- ❌ Don't let perfection block capture

---

## Weekly Review (1-2 hours/week)

### Schedule

**Pick a consistent time:**
- **Option A:** Every Friday afternoon (2-4pm)
- **Option B:** Every Sunday morning (10am-12pm)

**Set calendar reminder:** Recurring weekly event

---

### Review Process

**Goal:** Process Inbox to empty or <10 items

---

#### Step 1: Review Inbox (45 min)

For each item in `0-Inbox/`, work through this checklist:

##### Articles & Web Clips (`0-Inbox/web-clips/`)

- [ ] **Read or skim** the article
- [ ] **Extract key points** (3-5 main takeaways)
- [ ] **Add relevant tags** (e.g., #models, #tools, #techniques)
- [ ] **Link to 3+ related notes** (existing concepts, MOCs, related resources)
- [ ] **Assess value:**
  - Keep → Move to `3-Resources/articles/`
  - Not valuable → Delete
  - Maybe later → Leave in Inbox (limit: 10 items)
- [ ] **Update frontmatter:** Change status to "processed"

##### Bookmarks (`0-Inbox/bookmarks/`)

- [ ] **Visit link, assess value**
- [ ] **Summarize content** (what is this and why does it matter?)
- [ ] **Add tags** (topic, category, priority)
- [ ] **Link to 3+ related concepts**
- [ ] **Add to appropriate location:**
  - Permanent reference → `3-Resources/bookmarks/`
  - Project-specific → Move to relevant project folder
  - No longer relevant → Delete
- [ ] **Update status:** Mark as processed

##### Videos (`0-Inbox/videos/`)

- [ ] **Watch video OR review description/timestamps**
- [ ] **Extract key takeaways** (main insights)
- [ ] **Note specific timestamps** for important points
- [ ] **Add action items** if applicable
- [ ] **Link to related concepts** (what topics does this cover?)
- [ ] **Move to:** `3-Resources/videos/`
- [ ] **Update status:** Mark as watched/processed

##### Quick Notes (`0-Inbox/quick-notes/`)

- [ ] **Review the note**
- [ ] **Decide:**
  - Expand into permanent note → Use permanent-note-template
  - Incorporate into existing note → Merge and delete
  - Add to project → Move to relevant project
  - No longer relevant → Delete
- [ ] **If keeping:** Add proper tags and links
- [ ] **If expanding:** Create new note with proper structure

---

#### Step 2: Update Projects (15 min)

- [ ] **Review all active projects** in `1-Projects/`
- [ ] **Update task lists** (check off completed, add new)
- [ ] **Update status** (in progress, blocked, completed)
- [ ] **Archive completed projects:**
  - Add completion notes
  - Document outcomes
  - Move to `4-Archives/projects/2025/`
- [ ] **Identify new projects** from inbox items if needed

---

#### Step 3: Link Gardening (30 min)

**Goal:** Strengthen connections between notes

- [ ] **Find 5-10 notes to enhance** (recently added or commonly accessed)
- [ ] **For each note:**
  - Add missing links to related concepts
  - Check if mentioned concepts should be linked
  - Link to relevant MOCs
  - Add backlinks where valuable
- [ ] **Check for broken links** (manually or with plugin)
- [ ] **Update MOCs if needed:**
  - Add new notes to relevant MOCs
  - Refine categories
  - Update "last updated" date

---

#### Step 4: Clean Up (10 min)

- [ ] **Inbox status check:**
  - Target: Empty
  - Acceptable: <10 items
  - If > 10: Prioritize or batch delete low-value items
- [ ] **Verify processed items:**
  - All have proper tags
  - All have 3+ links (where appropriate)
  - All in correct location
- [ ] **Update Inbox README:**
  - Note last processed date
  - Count remaining items

---

## Monthly Review (2-3 hours/month)

### Schedule

**First Sunday of each month** (or last Friday)

---

### Tasks

#### 1. Review All Areas (45 min)

- [ ] **For each area in `2-Areas/`:**
  - Still relevant to current work?
  - Standards still appropriate?
  - Current focus needs updating?
  - Related projects up to date?
  - Review schedule still working?
- [ ] **Update area notes** with current status
- [ ] **Archive inactive areas** to `4-Archives/areas/`

---

#### 2. Update Time-Sensitive Content (45 min)

- [ ] **Check content in `3-Resources/models/`:**
  - Model pricing current?
  - New models released?
  - Features updated?
  - Benchmarks still relevant?
- [ ] **Check tools documentation:**
  - New versions released?
  - Breaking changes?
  - Deprecated features?
- [ ] **Update "last updated" dates** in frontmatter
- [ ] **Add notes** about what changed

---

#### 3. Archive Management (30 min)

- [ ] **Archive completed projects** from `1-Projects/`
- [ ] **Organize archives** by year/category
- [ ] **Review recent archives** for valuable insights
- [ ] **Update archive metadata** if needed

---

#### 4. MOC Maintenance (30 min)

- [ ] **Review all MOCs** in `5-Meta/MOCs/`
- [ ] **Add new notes** created this month
- [ ] **Refine categories** and organization
- [ ] **Check for missing topics** that need MOCs
- [ ] **Update "last updated" dates**

---

#### 5. Vault Health Check (30 min)

- [ ] **Check for orphan notes:**
  - Use graph view to identify
  - Add links or archive
- [ ] **Verify link integrity:**
  - Check for broken links
  - Fix or remove
- [ ] **Tag consistency:**
  - Review tags being used
  - Consolidate similar tags
  - Update tag documentation if needed

---

#### 6. Process Improvements (15 min)

- [ ] **Reflect on workflow:**
  - What's working well?
  - What's causing friction?
  - What could be simplified?
- [ ] **Update guidelines** if needed
- [ ] **Refine templates** based on usage
- [ ] **Document lessons learned**

---

## Quarterly Review (4-6 hours/quarter)

### Schedule

**First weekend of:** January, April, July, October

---

### Tasks

#### 1. Major Content Audit (2-3 hours)

- [ ] **Review all content systematically**
- [ ] **Assess quality and relevance**
- [ ] **Archive outdated material** to `4-Archives/outdated/`
- [ ] **Identify gaps** in coverage
- [ ] **Plan content to create** next quarter

---

#### 2. Structural Review (1-2 hours)

- [ ] **Is folder structure working?**
- [ ] **Are templates effective?**
- [ ] **Are MOCs serving their purpose?**
- [ ] **Do workflows need adjustment?**
- [ ] **Should anything be reorganized?**

---

#### 3. Strategic Planning (1-2 hours)

- [ ] **Review learning goals** for past quarter
- [ ] **Set goals** for next quarter
- [ ] **Plan projects** to support areas
- [ ] **Identify skills** to develop
- [ ] **Update area focus** for next quarter

---

#### 4. Documentation Update (1 hour)

- [ ] **Update this workflow** based on learnings
- [ ] **Refine templates** that need improvement
- [ ] **Update README files** with current structure
- [ ] **Review and update CLAUDE.md** for AI assistant guidance
- [ ] **Document process improvements**

---

## Troubleshooting

### "Inbox is overwhelming (> 50 items)"

**Solutions:**
1. Set a time limit (1 hour max for review)
2. Process only newest/most relevant first
3. Batch delete low-priority items
4. Create "Backlog" subfolder for deferred processing
5. Accept that not everything needs processing

---

### "I'm not maintaining consistency"

**Solutions:**
1. Reduce review frequency (bi-weekly instead of weekly)
2. Use smaller time blocks (30 min instead of 2 hours)
3. Focus on capture over processing (it's OK to have backlog)
4. Set realistic expectations (done > perfect)
5. Use calendar blocks and reminders

---

### "Links feel forced"

**Solutions:**
1. Quality over quantity (3 good links > 10 weak links)
2. Link only when genuinely related
3. It's OK if some notes have fewer links
4. Use "Related Concepts" section for natural linking
5. Links will emerge naturally as vault grows

---

### "Weekly review takes too long"

**Solutions:**
1. Capture less (be more selective)
2. Process in batches (not everything weekly)
3. Simplify templates (fewer required fields)
4. Skip link gardening some weeks
5. Aim for "good enough" not perfect

---

### "Not seeing value from the system"

**Solutions:**
1. Focus on areas that matter most
2. Link more aggressively (that's where value emerges)
3. Use MOCs for navigation and discovery
4. Review past projects for insights
5. Give it time (network effects compound)

---

## Quick Reference Checklists

### Daily Capture (5-10 min)
- [ ] Save interesting content to Inbox (appropriate subfolder)
- [ ] Minimal metadata only (trust the process)
- [ ] No deep processing

### Weekly Review (1-2 hours)
- [ ] Process all Inbox items (or get to <10)
- [ ] Update active projects
- [ ] Link gardening (5-10 notes)
- [ ] Update todo lists

### Monthly Review (2-3 hours)
- [ ] Review all areas
- [ ] Update time-sensitive content
- [ ] Archive completed projects
- [ ] Update MOCs
- [ ] Vault health check

### Quarterly Review (4-6 hours)
- [ ] Major content audit
- [ ] Structural review and adjustments
- [ ] Strategic planning for next quarter
- [ ] Update all documentation

---

## Success Metrics

**After 4 weeks, you should have:**
- ✅ Inbox consistently <10 items
- ✅ Weekly review is habitual
- ✅ New content flowing in regularly
- ✅ Links forming between notes

**After 12 weeks, you should have:**
- ✅ Rich network of connected notes
- ✅ Easy navigation via MOCs
- ✅ Finding unexpected connections
- ✅ System feels natural and valuable

---

## Related

- [[0-Inbox/README]] - Capture zone
- [[5-Meta/Templates/README]] - Templates for processing
- [[5-Meta/MOCs/README]] - Navigation hubs
- [[5-Meta/README]] - Meta folder overview

---

**Remember:** Perfect is the enemy of good. Process consistently, not perfectly. The goal is a system you actually use, not one that's theoretically perfect.

---

**Created:** 2025-12-23
**Last Updated:** 2025-12-23
**Version:** 1.0
