---
tags:
  - "#plan"
  - "#tools"
  - "#workflows"
date: 2025-12-23
status: published
---

# Tools and Workflows - Technical Implementation Guide

Comprehensive guide to tools, plugins, configurations, and workflows for your AI knowledge base.

---

## Core Tools

### 1. Obsidian (Required)

**What:** Local-first, markdown-based knowledge management application

**Why:**
- Complete data ownership
- Plain text markdown (portable, future-proof)
- Powerful linking and graph features
- Extensible plugin ecosystem
- Works offline

**Installation:**
- Download from [obsidian.md](https://obsidian.md)
- Available for: Windows, macOS, Linux, iOS, Android

**Cost:** Free (Sync and Publish are paid, but optional)

**Basic Configuration:**
1. Settings → Editor → Enable "Strict Line Breaks"
2. Settings → Files & Links → Set "Default location for new notes" to "In the folder specified below" → "0-Inbox"
3. Settings → Files & Links → Enable "Automatically update internal links"

---

### 2. Obsidian Web Clipper (Required)

**What:** Official browser extension for saving web content to Obsidian

**Why:**
- One-click saving of articles and web pages
- Converts to clean markdown
- AI-powered metadata extraction
- Customizable templates
- Hotkey support

**Installation:**
1. Visit [obsidian.md/clipper](https://obsidian.md/clipper)
2. Install for your browser:
   - Chrome/Edge/Brave/Arc: Chrome Web Store
   - Firefox: Firefox Add-ons
   - Safari: Safari Extensions

**Configuration:**

**Basic Setup:**
1. Click extension icon
2. Connect to your Obsidian vault
3. Set default folder: `0-Inbox/web-clips/`
4. Enable "Add highlights" option

**Advanced Setup (Optional):**
```javascript
// Custom template for web clips
---
tags: [#web-clip, #{{category}}]
source: {{url}}
author: {{author}}
captured: {{date:YYYY-MM-DD}}
status: unprocessed
---

# {{title}}

{{#if highlights}}
## Highlights
{{#each highlights}}
- {{this}}
{{/each}}
{{/if}}

## Content
{{content}}

## Related
- [[]]

---
**Source:** [{{title}}]({{url}})
**Captured:** {{date:YYYY-MM-DD}}
```

**Hotkeys (Configure in extension):**
- `Ctrl+Shift+S` - Save current page
- `Ctrl+Shift+H` - Save with highlights

---

### 3. Git (Recommended for Backup)

**What:** Version control system

**Why:**
- Automatic backups
- Change history
- Collaboration support
- Free remote storage (GitHub)

**Setup:**

**If not already using Git:**
1. Install Git: [git-scm.com](https://git-scm.com)
2. Initialize in vault:
   ```bash
   cd /path/to/vault
   git init
   git add .
   git commit -m "Initial commit"
   ```

**Create .gitignore:**
```
.obsidian/workspace*
.obsidian/cache
.trash/
.DS_Store
```

**Backup to GitHub:**
1. Create private repository on GitHub
2. Link and push:
   ```bash
   git remote add origin https://github.com/yourusername/vault.git
   git push -u origin main
   ```

**Daily Backup Script** (optional):
```bash
#!/bin/bash
cd /path/to/vault
git add .
git commit -m "vault backup: $(date +'%Y-%m-%d %H:%M:%S')"
git push
```

---

## Obsidian Plugins

### Core Plugins (Built-in, Enable These)

**1. Templates**
- Settings → Core Plugins → Enable "Templates"
- Settings → Templates → Template folder: `5-Meta/Templates`
- Assign hotkey: `Ctrl+T` for "Insert template"

**2. Daily Notes** (Optional but recommended)
- Enable in Core Plugins
- Set folder: `2-Areas/Daily-Notes/`
- Date format: `YYYY-MM-DD`
- Template: Create in `5-Meta/Templates/daily-note-template.md`

```markdown
---
tags: [#daily-note]
date: {{date:YYYY-MM-DD}}
---

# {{date:YYYY-MM-DD dddd}}

## Captured Today
-

## Learning
-

## Tasks
- [ ]

## Notes
```

**3. Backlinks**
- Always enabled
- Shows what links to current note
- Essential for Zettelkasten workflow

**4. Graph View**
- Always enabled
- Visual representation of note connections
- Useful for finding orphans and clusters

**5. Outgoing Links**
- Shows what current note links to
- Helps ensure proper linking

**6. File Recovery**
- Automatic backup of deleted files
- Safety net

**7. Bookmarks** (Core Plugin)
- Bookmark frequently accessed notes/folders
- Quick navigation

---

### Community Plugins (Optional but Useful)

**Installation:**
1. Settings → Community Plugins → Turn off "Restricted mode"
2. Browse → Search → Install → Enable

#### Essential Plugins

**1. Dataview**
**Purpose:** Query your notes like a database

**Use Cases:**
- List all unprocessed inbox items
- Show projects by status
- Track last updated dates
- Generate reading lists

**Example Queries:**

```dataview
# Unprocessed Inbox
LIST
FROM "0-Inbox"
WHERE status = "unprocessed"
SORT captured DESC
```

```dataview
# Active Projects
TABLE status, deadline
FROM "1-Projects"
WHERE status = "active"
SORT deadline ASC
```

```dataview
# Recently Updated Resources
TABLE last_updated, tags
FROM "3-Resources"
SORT last_updated DESC
LIMIT 10
```

**Configuration:**
- Enable inline queries
- Enable JavaScript queries (advanced)

---

**2. Templater**
**Purpose:** Advanced template engine with programming logic

**Why over Core Templates:**
- Dynamic date calculations
- Conditional logic
- User prompts
- File system operations

**Example Advanced Template:**

```javascript
<%*
const title = await tp.system.prompt("Title");
const category = await tp.system.suggester(
  ["Models", "Tools", "Techniques", "Other"],
  ["models", "tools", "techniques", "other"]
);
-%>
---
tags: [#<% category %>, #resource]
created: <% tp.date.now("YYYY-MM-DD") %>
last_updated: <% tp.date.now("YYYY-MM-DD") %>
---

# <% title %>

Brief overview

## Main Content

## Related
- [[]]

---
**Created:** <% tp.date.now("YYYY-MM-DD") %>
```

**Configuration:**
- Template folder: `5-Meta/Templates`
- Enable folder templates (auto-apply)
- Set hotkeys for common templates

---

**3. Tasks**
**Purpose:** Advanced task management

**Features:**
- Query tasks from all notes
- Group by project, tag, status
- Recurring tasks
- Priority levels

**Example Task Queries:**

```tasks
not done
path includes 1-Projects
group by filename
```

**Recommended:**
- Set task symbols: `- [ ]` uncompleted, `- [x]` completed
- Enable global task inbox

---

**4. Calendar**
**Purpose:** Calendar visualization of daily notes

**Features:**
- Monthly calendar view
- Click to create/open daily note
- Visual dots for notes on specific days

**Use Case:**
- Track daily learning
- Visual journal
- Quick access to past notes

---

**5. Tag Wrangler**
**Purpose:** Tag management and renaming

**Features:**
- Rename tags across all notes
- Merge similar tags
- View tag hierarchy
- Organize tag structure

**Use Case:**
- Clean up tag inconsistencies
- Standardize naming
- Maintain tag taxonomy

---

**6. Obsidian Git** (Alternative to manual Git)
**Purpose:** Automated Git backup within Obsidian

**Features:**
- Auto-commit on interval
- Auto-push to remote
- Commit message templates
- Git status in status bar

**Configuration:**
- Set auto-commit interval: 30 minutes
- Set auto-push interval: 60 minutes
- Commit message: `vault backup: {{date}}`

**Recommended if:**
- You want automatic backups
- Don't want to use command line
- Prefer set-it-and-forget-it approach

---

**7. Advanced Tables**
**Purpose:** Excel-like table editing in markdown

**Features:**
- Easy table creation
- Auto-formatting
- Add/remove rows/columns
- Sort tables

**Use Case:**
- Model comparison tables
- Feature matrices
- Quick data entry

---

**8. Outliner**
**Purpose:** Enhanced list and outline editing

**Features:**
- Fold/unfold lists
- Drag and drop bullets
- Zoom into lists
- Outliner-style navigation

**Use Case:**
- Hierarchical note-taking
- Better list management
- Outline-first writing

---

**9. Natural Language Dates**
**Purpose:** Write dates in natural language

**Features:**
- "tomorrow" → actual date
- "next Monday" → date
- "in 2 weeks" → date

**Use Case:**
- Quick task due dates
- Human-readable scheduling
- Faster date entry

---

**10. Excalidraw** (For diagrams)
**Purpose:** Sketch and diagram within Obsidian

**Features:**
- Hand-drawn style diagrams
- Embed in notes
- Link to other notes
- Export as image

**Use Case:**
- Architecture diagrams
- Concept maps
- Visual thinking

---

### Plugin Recommendations by Use Case

**Minimal Setup (Just Getting Started):**
- Core Templates
- Core Backlinks
- Obsidian Web Clipper

**Standard Setup (Recommended):**
- Above, plus:
- Daily Notes
- Dataview
- Tasks
- Calendar

**Power User Setup:**
- Above, plus:
- Templater
- Obsidian Git
- Tag Wrangler
- Advanced Tables
- Natural Language Dates

**Visual Thinker Setup:**
- Standard, plus:
- Excalidraw
- Outliner
- Mind Map plugin

---

## Workflows

### Daily Workflow

**Morning (5 min):**
1. Open Obsidian
2. Open today's daily note (Ctrl+D if configured)
3. Review yesterday's learning
4. Set 1-3 goals for today

**During Day (As Needed):**
1. See interesting article → Web Clipper → Save to Inbox
2. Find useful video → Quick note with video template
3. Quick idea → Daily note or quick-note template
4. Learning moment → Add to daily note

**Evening (5-10 min):**
1. Review today's daily note
2. Move important items from daily note to permanent notes
3. Update project task lists if needed
4. Quick scan of Inbox (don't process, just awareness)

---

### Weekly Workflow

**Friday Afternoon or Sunday Morning (1-2 hours):**

**Phase 1: Inbox Processing (45 min)**

1. **Open Dataview query:**
   ```dataview
   LIST
   FROM "0-Inbox"
   SORT captured DESC
   ```

2. **For each unprocessed item:**
   - Web clips: Read, extract key points, add links, move to 3-Resources/articles/
   - Bookmarks: Visit, assess, summarize, link, move or delete
   - Videos: Review, extract takeaways, link, move or delete
   - Quick notes: Expand to permanent note or incorporate elsewhere

3. **Goal:** Inbox < 10 items

**Phase 2: Project Review (15 min)**

1. Open each project in 1-Projects/
2. Update task lists
3. Check deadlines
4. Archive if completed
5. Move to Archives if inactive

**Phase 3: Link Gardening (30 min)**

1. Choose 5-10 notes to enhance
2. Add 3-5 new links to each
3. Check for broken links
4. Update MOCs if needed
5. Add backlinks where valuable

**Phase 4: Cleanup**
- Quick git commit and push
- Close unneeded tabs
- Plan next week's focus

---

### Monthly Workflow

**First Sunday of Month (2-3 hours):**

**1. Review Areas (30 min)**
- Open each area in 2-Areas/
- Still relevant?
- Standards being met?
- Need new projects?
- Update focus

**2. Content Audit (45 min)**
- Check time-sensitive content (models/, tools/)
- Update pricing, features, versions
- Mark deprecated content
- Update "Last Updated" dates

**3. Archive Projects (15 min)**
- Move completed projects to 4-Archives/
- Add archived date
- Update project README

**4. MOC Review (30 min)**
- Update each MOC
- Add new notes
- Reorganize if needed
- Check for missing links

**5. Vault Health (30 min)**
- Run orphan notes check (graph view)
- Find broken links
- Check frontmatter consistency (sample 20 notes)
- Review tag usage

**6. Plan Next Month**
- What to learn?
- What projects to start?
- What content to create?

---

### Quarterly Workflow

**First Weekend of Jan/Apr/Jul/Oct (4-6 hours):**

**1. Major Content Audit (2 hours)**
- Review ALL time-sensitive content
- Archive heavily outdated material
- Update comparisons and benchmarks
- Refresh examples

**2. Structure Review (1 hour)**
- Is organization still working?
- Need new folders/categories?
- Should anything be reorganized?
- Are tags still meaningful?

**3. Template & Workflow Updates (1 hour)**
- Review all templates
- Update based on usage
- Refine workflows
- Document improvements

**4. Collaboration Review (1 hour, if applicable)**
- How is team using the KB?
- What's working?
- What's confusing?
- Update onboarding/contribution guides

**5. Plan Next Quarter (1 hour)**
- Set learning goals
- Identify knowledge gaps
- Plan workshops or deep dives
- Set improvement goals

---

## Advanced Configurations

### Hotkeys (Recommended Setup)

**File Navigation:**
- `Ctrl+O` - Quick switcher
- `Ctrl+Shift+F` - Search in all files
- `Ctrl+G` - Open graph view
- `Ctrl+Alt+Left` - Navigate back
- `Ctrl+Alt+Right` - Navigate forward

**Note Creation:**
- `Ctrl+N` - New note
- `Ctrl+T` - Insert template
- `Ctrl+D` - Open today's daily note (if Daily Notes enabled)

**Content Manipulation:**
- `Ctrl+K` - Insert link
- `Ctrl+B` - Bold text
- `Ctrl+I` - Italic text
- `Ctrl+E` - Toggle edit/preview

**Custom Hotkeys:**
- Assign to bookmark template
- Assign to video template
- Assign to "Move file to folder"

---

### Workspace Setup

**Recommended Layout:**

**Left Sidebar:**
- File explorer (primary)
- Bookmarks (secondary)
- Tags (tertiary)

**Main Pane:**
- Current note
- Split for reference note (right split)

**Right Sidebar:**
- Backlinks
- Outgoing links
- Graph view (local)

**Save as Workspace:**
- Manage Layouts → Save current layout → Name it "Standard"

---

### CSS Customization (Optional)

**Create:** `.obsidian/snippets/custom.css`

**Example - Better Inbox Visibility:**
```css
/* Highlight inbox items */
.tree-item-self[data-path^="0-Inbox"] {
    background-color: #fffacd;
    font-weight: bold;
}

/* Highlight unprocessed status */
.cm-hashtag-end:contains("unprocessed") {
    color: #ff6b6b;
    font-weight: bold;
}

/* Highlight active projects */
.tree-item-self[data-path^="1-Projects"] {
    color: #51cf66;
}
```

Enable: Settings → Appearance → CSS snippets → Enable "custom"

---

## Integrations

### Raindrop.io (Optional Bookmark Manager)

**Why:**
- Browser extension for quick bookmarking
- Collections and tags
- Full-text search
- Can export to markdown

**Integration with Obsidian:**

**Option 1: Manual Export**
1. Export from Raindrop as CSV/HTML
2. Convert to markdown notes
3. Import to Obsidian

**Option 2: API Integration** (advanced)
- Use Raindrop API
- Script to sync bookmarks → Obsidian notes
- Automated via cron job

**Recommendation:**
- Start with Obsidian Web Clipper only
- Add Raindrop.io if you need:
  - Mobile bookmarking
  - Share collections with others
  - Full-text search before processing

---

### NotebookLM (For Video Processing)

**What:** Google's AI research tool

**Use Case:** Process YouTube videos into notes

**Workflow:**
1. Add YouTube URL to NotebookLM
2. Chat with AI about video content
3. Generate summary
4. Export key points
5. Create video note in Obsidian with insights

**When to Use:**
- Long videos (>30 min)
- Dense technical content
- Need quick summary before watching
- Want to extract specific information

---

### Claude Desktop/Code with MCP

**What:** AI integration via Model Context Protocol

**Use Case:** AI-assisted knowledge management

**Features:**
- Ask questions about your vault
- Generate summaries
- Suggest links between notes
- Find related concepts

**Setup:**
1. Install Claude Desktop
2. Configure MCP connection to your vault
3. Use AI to explore and enhance your knowledge base

**Example Uses:**
- "What notes relate to RAG implementation?"
- "Summarize my notes on Claude 4 Sonnet"
- "Find gaps in my knowledge about agents"

---

## Troubleshooting

### Common Issues

**"Web Clipper not saving to vault"**
- Check vault path in extension settings
- Verify folder exists (0-Inbox/web-clips/)
- Restart Obsidian
- Check permissions

**"Templates not appearing"**
- Verify folder path: 5-Meta/Templates
- Check Templates plugin is enabled
- Restart Obsidian

**"Git conflicts"**
- If using Obsidian Git, resolve in Git client
- Usually workspace files (safe to overwrite)
- Backup before resolving

**"Slow performance"**
- Disable unused plugins
- Reduce Dataview queries
- Exclude .obsidian folder from sync
- Consider splitting large vault

**"Lost note"**
- Check File Recovery plugin
- Check .trash folder
- Use search (Ctrl+Shift+F)
- Check git history if using Git

---

## Performance Optimization

**For Large Vaults (1000+ notes):**

1. **Exclude from indexing:**
   - Settings → Files & Links → Excluded files: `.obsidian/cache, 4-Archives`

2. **Optimize plugins:**
   - Disable unused plugins
   - Limit Dataview query complexity
   - Use lazy loading

3. **Organize files:**
   - Don't put all files in root
   - Use folder structure
   - Archive old content

4. **Sync optimization:**
   - Exclude workspace files from sync
   - Use selective sync if cloud syncing

---

## Backup Strategy

**3-2-1 Rule:**
- **3 copies:** Original + 2 backups
- **2 different media:** Local + Cloud
- **1 offsite:** Remote backup

**Implementation:**

**1. Local backup:** Obsidian vault on your computer (original)

**2. Cloud backup:** GitHub (automated via Obsidian Git)

**3. Second cloud backup:**
   - Dropbox/Google Drive sync of vault folder
   - OR: Manual periodic backup to external drive

**Recovery Plan:**
- Test restore process quarterly
- Document recovery steps
- Keep backup credentials secure

---

## Security & Privacy

**Local-First Benefits:**
- Complete data control
- No third-party access
- Works offline
- Privacy by default

**Best Practices:**

1. **Sensitive content:**
   - Don't put passwords/keys in notes
   - Use separate secure storage
   - Consider encrypting specific notes

2. **Git repository:**
   - Use private repository
   - Don't commit sensitive data
   - Review .gitignore

3. **Sharing:**
   - Export specific notes for sharing
   - Don't share entire vault unless intended
   - Review content before sharing

4. **Sync services:**
   - Use encrypted sync (Obsidian Sync, encrypted cloud)
   - Review sync permissions
   - Consider what needs syncing

---

## Mobile Setup (Optional)

**Obsidian Mobile:**
- Available for iOS and Android
- Full-featured markdown editor
- Sync via Obsidian Sync (paid) or iCloud/Dropbox (free)

**Mobile Workflow:**

**Capture:**
- Share → Obsidian → Quick capture to Inbox
- Voice notes → Transcribe → Save to Inbox
- Photos → Attach to notes

**Review:**
- Read notes on the go
- Quick edits
- Browse graph

**Sync Setup:**
- Option 1: Obsidian Sync ($10/month, official)
- Option 2: iCloud (iOS) - put vault in iCloud Drive
- Option 3: Syncthing (free, cross-platform, more setup)

---

## Recommended Tool Stack

**Minimal (Free):**
- Obsidian
- Obsidian Web Clipper
- Core plugins only
- Git (for backup)

**Standard (Free):**
- Above, plus:
- Daily Notes plugin
- Dataview plugin
- Tasks plugin
- Calendar plugin

**Professional (Free):**
- Above, plus:
- Templater plugin
- Obsidian Git plugin
- Tag Wrangler plugin
- Advanced Tables plugin

**Premium (Paid Options):**
- Above, plus:
- Obsidian Sync ($10/month) - Official sync
- Obsidian Publish ($10/month) - Public website from vault
- Raindrop.io Pro ($28/year) - Enhanced bookmarking

---

## Next Steps

1. **Install core tools** (Obsidian, Web Clipper)
2. **Enable essential plugins** (Templates, Backlinks)
3. **Configure hotkeys** for efficiency
4. **Test workflows** with sample content
5. **Gradually add** community plugins as needed

**Remember:** Start simple, add complexity as you discover needs.

---

**Tools Guide Version:** 1.0
**Created:** 2025-12-23
**Last Updated:** 2025-12-23

*Your tools should serve your workflow, not dictate it. Start minimal and enhance as needed.*
