---
tags:
  - "#plan"
  - "#capture"
  - "#workflows"
date: 2025-12-23
status: published
---

# Content Capture Strategy - Managing Bookmarks, Tabs, and Videos

Comprehensive strategies for capturing, processing, and integrating diverse content types into your knowledge base.

---

## Capture Philosophy

### Core Principles

**1. Capture Everything (Initially)**
- Don't filter at capture time
- Lowfriction = more captured
- Process and filter later

**2. Quick Capture, Slow Processing**
- Capture in seconds
- Process in minutes/hours
- Refine over days/weeks

**3. Progressive Refinement**
- Layer 1: Quick save (URL + title)
- Layer 2: Add summary
- Layer 3: Extract key points
- Layer 4: Link to existing knowledge
- Layer 5: Integrate insights

**4. Actionable Processing**
- Every captured item should lead to:
  - Knowledge note
  - Action item
  - Archive
  - Delete

---

## Content Type Strategies

### 1. Web Articles & Documentation

#### Capture Methods

**Option A: Obsidian Web Clipper (Recommended)**

**When:** Reading in-depth articles worth keeping

**Steps:**
1. Click Web Clipper extension icon
2. Choose "Full article" or "Selection" mode
3. Highlight key passages (optional)
4. Click "Clip"
5. Content saved to `0-Inbox/web-clips/`

**Metadata Captured:**
- URL
- Title
- Author
- Date
- Your highlights
- Full content in markdown

**Advantages:**
- Full content preserved offline
- Clean markdown format
- Highlights saved
- One-click capture

---

**Option B: Bookmark Template (For Quick Links)**

**When:** Quick reference, don't need full content

**Steps:**
1. Copy URL
2. New note from bookmark template (`Ctrl+T`)
3. Paste URL
4. Add title and quick summary
5. Tag with category
6. Save to `0-Inbox/bookmarks/`

**Advantages:**
- Faster than full clip
- Smaller vault size
- Can batch process later

---

**Option C: Browser Bookmark → Process Later**

**When:** Very quick capture, process in batch

**Steps:**
1. Save to browser bookmarks
2. Weekly: Export bookmarks
3. Batch process into Obsidian
4. Delete from browser

**Advantages:**
- Zero friction capture
- Works on any device
- Batch processing efficient

---

#### Processing Workflow

**Level 1: Quick Process (5-10 min/article)**
1. Skim article
2. Add 3-5 bullet points summary
3. Add 2-3 relevant tags
4. Update status: `processed`
5. Move to appropriate folder in `3-Resources/`

**Level 2: Deep Process (15-30 min/article)**
1. Read carefully
2. Extract key insights (5-10 points)
3. Add quotes (with context)
4. Link to 3+ related notes
5. Add "My Thoughts" section
6. Create action items if applicable
7. Move to permanent location

**Level 3: Integration (30-60 min/article)**
1. Create permanent notes for new concepts
2. Update existing notes with new info
3. Add to relevant MOC
4. Cross-link extensively
5. Update project or area notes if applicable

---

**Decision Matrix: Which Level?**

| Article Type | Processing Level | Time |
|--------------|-----------------|------|
| Quick reference | Level 1 | 5 min |
| Useful tutorial | Level 2 | 15 min |
| Key research paper | Level 3 | 45 min |
| News/updates | Level 1 or Delete | 5 min |
| Deep technical | Level 3 | 60 min |

---

### 2. Bookmarks (Browser Tabs & Saved Links)

#### The Browser Tab Problem

**Common Symptoms:**
- 50+ tabs open "to read later"
- Tabs open for weeks/months
- Fear of closing (might need it!)
- Browser slowdown

**Root Cause:** No trusted capture system

**Solution:** Systematic capture to knowledge base

---

#### Bookmark Triage System

**Four Categories:**

**1. Read & Process (20%)**
- Will definitely read
- High value content
- Relevant to current work

**Action:** Full clip or bookmark template → Schedule reading time

**2. Reference (30%)**
- Documentation
- How-to guides
- Might need later

**Action:** Quick bookmark with tags → Move to resources

**3. Interesting (40%)**
- Might be useful
- Not urgent
- Could be relevant

**Action:** Quick bookmark → Archive to "Backlog" → Review quarterly

**4. Delete (10%)**
- No longer relevant
- Duplicate
- Poor quality

**Action:** Close tab, don't capture

---

#### Processing Backlogs

**Existing Browser Bookmarks:**

**Step 1: Export** (15 min)
- Export all bookmarks to HTML
- Use browser bookmark manager

**Step 2: Categorize** (1-2 hours)
```
Review each bookmark:
- Still relevant? (Yes/No)
- Priority? (High/Medium/Low)
- Category? (Models/Tools/Techniques/etc.)
```

**Step 3: Batch Process** (Multiple sessions)

**Week 1: High Priority (30 bookmarks)**
- Use bookmark template
- Add to appropriate resource folder
- Process deeply

**Week 2: Medium Priority (50 bookmarks)**
- Use bookmark template
- Basic summary only
- Move to resources

**Week 3: Low Priority (Review)**
- Quickly skim
- Save only if truly valuable
- Delete rest (guilt-free!)

**Result:** Organized knowledge base, clean browser

---

#### Open Browser Tabs Strategy

**Daily Tab Management:**

**End of Day (5 min):**
1. Quick tab review
2. For each tab:
   - **Clip** if valuable article (Web Clipper)
   - **Bookmark** if might need reference
   - **Close** if done or not valuable
3. Goal: < 10 tabs open

**Exceptions:**
- Active work tabs (keep in separate window)
- Pinned essential tabs (email, calendar)

**Tab Bankruptcy Option:**

If overwhelmed (50+ tabs):

1. **Save all tabs** to Obsidian in batch:
   - Use browser extension (Tab Save, OneTab)
   - Export as list
   - Import to `0-Inbox/tab-dump-YYYY-MM-DD.md`

2. **Close ALL tabs** (fresh start)

3. **Process gradually:**
   - Review list weekly
   - Process 10-15 per session
   - Most will no longer be relevant (that's OK!)

4. **Prevention:**
   - Daily tab review (5 min)
   - Immediate capture habit

---

### 3. YouTube Videos & Educational Content

#### Capture Strategies

**Option A: Video Note Template (Recommended)**

**When:** Educational videos worth referencing

**Template Fields:**
- Title
- Channel
- URL
- Duration
- Watched date
- Summary
- Key takeaways (with timestamps)
- Action items
- Related concepts

**Workflow:**
1. Watching video → Take notes in template
2. Pause at key moments → Note timestamp
3. After watching → Fill action items
4. Link to related concepts
5. Save to `0-Inbox/videos/` → Process weekly to `3-Resources/videos/`

---

**Option B: NotebookLM Integration**

**When:** Long videos (>30 min), need quick summary

**Workflow:**
1. Add YouTube URL to NotebookLM
2. AI generates summary
3. Chat to extract specific info
4. Copy summary + key points
5. Paste into video template in Obsidian
6. Add your own notes and links
7. Save to vault

**Advantages:**
- Quick summary of long content
- Can query specific topics
- Saves watching time for low-priority videos

---

**Option C: Playlist Organization**

**When:** Curating learning content

**Create Playlists:**
- "AI - Must Watch" (priority)
- "AI - Tutorials" (by topic)
- "AI - Conferences" (recordings)
- "AI - Research Talks"
- "To Watch Later" (triage)

**In Obsidian:**
- Create note for each significant playlist
- Link to individual video notes
- Track watching progress

---

#### Video Processing Levels

**Level 1: Quick Capture (5 min)**
- URL + Title
- Channel
- 1-sentence description
- Tag with category
- Status: unprocessed

**Level 2: Summary (15 min)**
- Watch or use AI summary
- 5-10 key takeaways
- 2-3 most important timestamps
- Relevance note
- Status: summarized

**Level 3: Deep Notes (30-60 min)**
- Watch with dedicated note-taking
- Timestamped highlights (10-20)
- Screenshots or diagrams (if helpful)
- Action items extracted
- Link to 5+ related concepts
- Create permanent notes for new concepts
- Status: integrated

---

**Decision Matrix:**

| Video Type | Processing Level | When |
|------------|------------------|------|
| Quick tips (<10 min) | Level 2 | If useful |
| Tutorial (10-30 min) | Level 3 | If implementing |
| Conference talk (30-60 min) | Level 2 | If relevant field |
| Course lecture (>60 min) | Level 3 + Course notes | If studying topic |
| News/updates | Level 1 or Skip | Low priority |

---

#### Video Organization

**Folder Structure:**
```
3-Resources/videos/
├── README.md
├── Tutorials/
│   ├── by topic
├── Conferences/
│   ├── by event/year
├── Lectures/
│   ├── by course
└── Quick-Tips/
```

**Tags:**
- `#video/tutorial`
- `#video/conference`
- `#video/lecture`
- Plus content tags: `#rag`, `#agents`, `#claude`, etc.

---

### 4. Research Papers & Academic Content

#### Capture Strategy

**Option A: PDF + Note**

**Workflow:**
1. Download PDF to `attachments/papers/`
2. Create note using article template
3. Add paper metadata:
   - Title
   - Authors
   - Journal/Conference
   - Year
   - DOI/URL
4. Link to PDF: `![[paper.pdf]]`
5. Add summary and key findings

**Option B: Web Clip**

**Workflow:**
1. Read paper on arXiv or journal site
2. Web clip the abstract and key sections
3. Add your summary and thoughts
4. Link to original PDF/URL

---

#### Processing Research Papers

**Levels:**

**Quick Read (30 min):**
- Abstract
- Introduction
- Conclusions
- Key figures
- Note: Main contribution, relevance

**Standard Read (1-2 hours):**
- Full paper
- Extract methodology
- Note results
- Critique
- Action items or implementations

**Deep Read (3+ hours):**
- Multiple readings
- Understand all technical details
- Reproduce key results (if possible)
- Integrate into permanent notes
- Create new notes for novel concepts

---

**Template for Research Papers:**

```markdown
---
tags: [#paper, #research, #{{field}}]
type: research-paper
authors: Author 1, Author 2
year: YYYY
venue: Journal/Conference
url:
captured: {{date}}
read_status: abstract|skimmed|read|deep
---

# Paper Title

**Authors:** Author 1, Author 2
**Year:** YYYY
**Venue:** Journal/Conference
**URL:** [Paper](URL)
**PDF:** [[file.pdf]]

## Abstract
[Copy abstract]

## Key Contributions
- Contribution 1
- Contribution 2

## Methodology
Brief description

## Results
Key findings

## Relevance
Why this matters for my work

## Critical Notes
Limitations, questions, critiques

## Action Items
- [ ] Try implementation
- [ ] Read cited paper X

## Related
- [[Related Work 1]]
- [[Related Concept 1]]

---
**Read:** {{date}}
**Status:** {{read_status}}
```

---

### 5. Code Examples & Snippets

#### Capture Strategy

**Option A: Inline in Notes**

**When:** Small snippets related to concept

```markdown
## Example Implementation

\```python
# Code example
def example():
    pass
\```

**Source:** [Origin](URL)
**Modified:** Description
```

---

**Option B: Separate Code Files**

**When:** Full implementations, reusable code

**Structure:**
```
attachments/code/
├── README.md
├── rag-implementation/
│   ├── basic-rag.py
│   ├── README.md
│   └── requirements.txt
└── agent-examples/
    └── ...
```

**Link from Notes:**
```markdown
## Implementation

See [[attachments/code/rag-implementation/basic-rag.py]]

**Usage:**
\```bash
python rag-implementation/basic-rag.py
\```
```

---

**Option C: GitHub Gists + Link**

**When:** Want to share, version control separately

**Workflow:**
1. Create gist on GitHub
2. Link in note: `[Gist](URL)`
3. Add summary and context in note

---

### 6. Social Media & Discussions

#### Twitter/X Threads

**Capture:**
1. Thread URL
2. Create note with bookmark template
3. Paste URL
4. Add summary of key points
5. Tag with `#thread` and topic
6. Link to related concepts

**Optional:** Use Thread Reader App → Copy markdown → Paste to note

---

#### Reddit/HN/Forum Discussions

**Capture:**
1. Interesting discussion URL
2. Create note
3. Summarize key insights (not full thread)
4. Note diverging opinions
5. Action items or resources mentioned

**Don't:** Capture entire discussion verbatim
**Do:** Extract insights and resources

---

#### Discord/Slack Messages

**Capture:**
1. Screenshot or copy important messages
2. Paste into quick note
3. Add context (channel, date, participants)
4. Extract action items
5. Process into permanent notes

**Best Practice:** Link to original if possible, summarize don't copy-paste extensively

---

## Capture Tools Comparison

| Content Type | Primary Tool | Alternative | Time |
|--------------|--------------|-------------|------|
| **Articles** | Web Clipper | Bookmark template | 30s |
| **Bookmarks** | Bookmark template | Web Clipper | 15s |
| **Videos** | Video template | NotebookLM | 2 min |
| **Papers** | PDF + Note | Web clip | 5 min |
| **Code** | Inline or file | Gist + link | 3 min |
| **Threads** | Bookmark + summary | Thread reader | 2 min |
| **Discussions** | Summary note | - | 5 min |

---

## Mobile Capture

### On-the-Go Capture

**iOS Shortcuts:**
1. Share → Obsidian → Quick Capture
2. Saves to Inbox with timestamp
3. Process later on desktop

**Android:**
1. Share → Obsidian
2. Select Inbox folder
3. Add quick note

**Voice Memos:**
1. Record thought
2. Transcribe (auto or manual)
3. Add to Inbox
4. Process to permanent notes

---

## Batch Processing Techniques

### Weekly Batch Processing

**Friday Afternoon or Sunday Morning**

**Setup (5 min):**
- Clear workspace
- Open processing workflow
- Open Inbox folder
- Set timer (1-2 hours)

**Process (45-90 min):**

**Round 1: Triage (15 min)**
- Quick scan all Inbox items
- Delete obvious non-valuable
- Priority mark: High/Med/Low
- Estimated processing time

**Round 2: High Priority (30 min)**
- Process in detail
- Add extensive links
- Move to permanent locations

**Round 3: Medium Priority (30 min)**
- Basic processing
- Essential links only
- Move to permanent locations

**Round 4: Low Priority (15 min)**
- Quick skim
- Keep or archive
- Minimal processing

**Cleanup (5 min):**
- Commit changes
- Review MOCs to update
- Plan next week's focus

---

### Monthly Deep Processing

**One Sunday per Month (3-4 hours)**

**Focus:** Convert captured content into connected knowledge

**Activities:**

**1. Link Enhancement (1 hour)**
- Choose 20-30 processed notes
- Add 5-10 links to each
- Create bidirectional connections
- Update MOCs

**2. Permanent Note Creation (1 hour)**
- Review processed articles/videos
- Extract new concepts
- Create atomic permanent notes
- Link extensively

**3. MOC Updates (1 hour)**
- Update all MOCs
- Add new entries
- Reorganize if needed
- Improve structure

**4. Archive Review (30 min)**
- Review old captured content
- Delete no longer valuable
- Archive truly historical
- Extract any missed insights

---

## Quality Control

### Capture Quality Checklist

**For Each Captured Item:**
- [ ] Has clear title
- [ ] Source URL included
- [ ] Date captured
- [ ] Basic category tags
- [ ] Status tag (unprocessed)

**For Processed Items:**
- [ ] Summary or key points
- [ ] Relevant tags (3-5)
- [ ] At least 3 links to other notes
- [ ] Moved to permanent location
- [ ] Status updated

---

### Anti-Patterns to Avoid

**❌ Don't Do:**

1. **Capture Without Processing**
   - Problem: Inbox fills up, becomes overwhelming
   - Solution: Process weekly, keep Inbox < 50

2. **Perfect Capture**
   - Problem: Too much friction, capture less
   - Solution: Quick capture, refine later

3. **Hoard Everything**
   - Problem: Noise drowns out signal
   - Solution: Be selective, delete liberally

4. **No Links**
   - Problem: Isolated notes, no knowledge connections
   - Solution: Minimum 3 links per processed note

5. **Copy Full Text**
   - Problem: Vault bloat, no synthesis
   - Solution: Extract insights, summarize

6. **Never Review Captured**
   - Problem: Capture graveyard
   - Solution: Weekly processing, monthly review

---

## Automation Opportunities

### Zapier/IFTTT Integration

**Automate:**
- YouTube "Liked" videos → Obsidian note
- Pocket saves → Obsidian Inbox
- Reddit saved → Obsidian note
- Twitter bookmarks → Obsidian

**Setup:**
1. Connect services to Zapier
2. Create "Zap" to Dropbox/iCloud (Obsidian folder)
3. Notes auto-appear in Inbox

---

### Scripts for Power Users

**Bookmark Export Script:**
```python
# Convert exported bookmarks HTML to Obsidian notes
import html_parser
import markdown_generator

# Parse bookmark HTML
bookmarks = parse_bookmarks("bookmarks.html")

# Generate notes
for bookmark in bookmarks:
    note = generate_note(bookmark)
    save_to_inbox(note)
```

**Video Playlist to Notes:**
```python
# Use YouTube API to get playlist
# Generate notes for each video
# Save to Inbox/videos/
```

---

## Success Metrics

### Capture Effectiveness

**Good Indicators:**
- Capturing daily (content flowing in)
- Inbox processed weekly (< 50 items)
- Most captured items get processed (>80%)
- Processing feels manageable (not overwhelming)
- Browser tabs under control (<20)

**Warning Signs:**
- Inbox > 100 items for weeks
- Captured items never processed
- Still hoarding browser tabs
- Capture system feels burdensome
- Not linking captured content

---

## Troubleshooting

**"I can't keep up with processing"**
- Capture less
- Process faster (Level 1 only)
- Delete more aggressively
- Increase processing time

**"Everything seems worth capturing"**
- Be more selective at capture
- Trust you can find it again if needed
- Focus on truly unique insights
- Delete more in processing

**"I never look at captured content"**
- Improve linking to active work
- Create actionable items from captures
- Review regularly (MOCs help)
- Capture less, integrate more

**"Processing is boring/tedious"**
- Reduce processing depth
- Batch similar content
- Set shorter time limits
- Focus on most valuable content

---

## Next Steps

1. **Choose primary capture method** for each content type
2. **Set up templates** in `5-Meta/Templates/`
3. **Install Web Clipper** and configure
4. **Process first batch** of existing bookmarks (20-30)
5. **Establish weekly review** habit
6. **Refine workflow** based on experience

---

**Content Capture Version:** 1.0
**Created:** 2025-12-23
**Last Updated:** 2025-12-23

*Capture liberally, process regularly, integrate deeply. Your knowledge base is only as good as your capture and processing habits.*
