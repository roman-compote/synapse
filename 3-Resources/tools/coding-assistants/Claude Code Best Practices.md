---
tags:
  - "#coding-assistant"
  - "#best-practices"
  - "#claude-code"
  - "#reference"
date: 2025-12-01
status: published
---

# Claude Code Best Practices

A comprehensive guide to using Claude Code effectively, based on official Anthropic engineering recommendations and community insights.

> **Source:** [Claude Code Best Practices - Anthropic Engineering](https://www.anthropic.com/engineering/claude-code-best-practices)
> **See Also:** [[3-Resources/videos/Podcasts/boundary-podcast-context-engineering|Context Engineering Podcast]] - Advanced workflow patterns from production usage

---

## Quick Start Principles

**Core Philosophy:**
- Be specific in instructions to reduce course corrections
- Provide clear targets (tests, mocks, expected outputs) for iteration
- Use extended thinking for complex problems
- Leverage subagents early for verification without losing context
- Treat CLAUDE.md files like living prompt artifacts—refine continuously

---

## Setup & Configuration

### CLAUDE.md Files

Special documentation files that Claude automatically loads to understand your project context.

**What to Include:**
- Bash commands and custom tools
- Code style guidelines
- Testing instructions
- Repository etiquette
- Environment setup instructions

**Locations (in order of precedence):**
1. Project root: `./CLAUDE.md`
2. Parent directories (searches upward)
3. Global: `~/.claude/CLAUDE.md`

**Example CLAUDE.md:**
```markdown
# Project: E-Commerce API

## Technology Stack
- Node.js 18+ with Express
- PostgreSQL with Prisma ORM
- Jest for testing
- ESLint with Airbnb config

## Code Style
- Use async/await over promises
- Prefer functional components
- Follow REST API naming conventions
- All public functions must have JSDoc comments

## Testing
Run tests: `npm test`
Run with coverage: `npm run test:coverage`
Tests must pass before committing

## Custom Tools
- `db-reset`: Resets local database - run with `npm run db:reset`
- `lint-fix`: Auto-fixes linting issues - run with `npm run lint:fix`

## Repository Etiquette
- Branch naming: `feature/description` or `fix/description`
- Commit messages: Follow conventional commits
- Always run tests before creating PR
```

**Best Practices:**
- Keep concise—focus on actionable information
- Refine iteratively like prompts
- Update as project evolves
- Include examples of preferred patterns

---

## Subagents: Modular AI Workflows

**What are Subagents?**
Specialized, autonomous assistants that execute specific tasks with their own:
- System prompt
- Tool permissions
- Isolated context window

### When to Use Subagents

**✅ Good Use Cases:**
- Parallel development (frontend + backend simultaneously)
- Verification without context pollution
- Specialized tasks (code review, testing, documentation)
- Research without losing main conversation context
- Complex workflows requiring separation of concerns

**❌ Not Ideal For:**
- Simple, single-file changes
- Quick fixes
- Tasks requiring shared context
- Rapidly iterating on same code

### Creating Subagents

**Interactive Creation:**
```bash
/agents
```

This opens an interface to define:
- Agent name
- Description
- Tool whitelist
- System prompt

**Programmatic Creation:**
Create `.claude/agents/` directory with agent definition files.

**Example Agent: Code Reviewer**
```markdown
# .claude/agents/code-reviewer.md

Name: Code Reviewer
Description: Performs comprehensive code reviews

System Prompt:
You are a senior code reviewer. Analyze code for:
- Security vulnerabilities (SQL injection, XSS, auth issues)
- Error handling and edge cases
- Performance implications
- Code style consistency
- Test coverage
- Documentation quality

Provide actionable feedback with specific line references.

Tools: Read, Grep, Glob
```

### Subagent Workflow Patterns

**Pattern 1: Parallel Development**
```bash
> "Build a full-stack todo app with React frontend and Express backend"

# Claude spawns:
# - Subagent 1: Backend API implementation
# - Subagent 2: Frontend React app
# - Subagent 3: Integration tests
# Main agent: Coordinates and integrates
```

**Pattern 2: Verification Chain**
```bash
> "Implement user authentication"
[Main agent implements feature]

> "Use a subagent to review the authentication implementation for security issues"
[Subagent reviews with fresh context]
```

**Pattern 3: Specialized Roles (Pipeline)**
```bash
# Product Manager Agent
> Subagent 1: Analyzes requirements and creates spec

# Architect Agent
> Subagent 2: Reviews spec and designs architecture

# Implementer Agent
> Subagent 3: Implements based on architecture

# QA Agent
> Subagent 4: Tests and validates implementation
```

**Pattern 4: Research Without Context Loss**
```bash
# Early in conversation
> "Use a subagent to explore how authentication is currently implemented"
[Subagent investigates and returns summary]
[Main agent retains context for implementation]
```

### Subagent Security & Permissions

**Tool Allowlisting:**
```bash
# Option 1: Select "Always allow" during session
# Option 2: Use /permissions command
# Option 3: Edit .claude/settings.json
# Option 4: CLI flags --allowedTools
```

**Security Best Practices:**
- Start from deny-all; allowlist only what's needed
- Omit tools to inherit parent permissions (use cautiously)
- Require explicit confirmation for sensitive actions
- Block dangerous commands (rm -rf, sudo, production deployments)
- Scope file access to specific directories

**Example Permissions:**
```json
{
  "subagents": {
    "code-reviewer": {
      "allowedTools": ["Read", "Grep", "Glob"],
      "blockedPaths": [".env", "credentials/*"]
    },
    "tester": {
      "allowedTools": ["Read", "Write", "Bash"],
      "allowedCommands": ["npm test", "npm run coverage"]
    }
  }
}
```

---

## Custom Slash Commands

Store reusable prompt templates in `.claude/commands/` as Markdown files.

### Creating Commands

**Directory Structure:**
```
.claude/
└── commands/
    ├── review.md
    ├── test.md
    ├── docs.md
    └── security-audit.md
```

### Example Commands

**Code Review Command** (`.claude/commands/review.md`):
```markdown
Perform a comprehensive code review:

## Security
- [ ] SQL injection vulnerabilities
- [ ] XSS vulnerabilities
- [ ] Authentication/authorization issues
- [ ] Sensitive data exposure
- [ ] Input validation

## Code Quality
- [ ] Error handling completeness
- [ ] Edge cases covered
- [ ] Performance implications
- [ ] Memory leaks
- [ ] Resource cleanup

## Style & Standards
- [ ] Follows project conventions (see CLAUDE.md)
- [ ] Naming is clear and consistent
- [ ] Functions are single-responsibility
- [ ] Comments explain "why" not "what"

## Testing
- [ ] Unit tests exist and pass
- [ ] Edge cases tested
- [ ] Test coverage adequate
- [ ] Integration tests if needed

Provide specific line references and actionable feedback.
```

**Test Writing Command** (`.claude/commands/test.md`):
```markdown
Write comprehensive unit tests for $ARGUMENTS

Requirements:
- Use Jest testing framework
- Cover happy path scenarios
- Cover edge cases and error conditions
- Mock external dependencies
- Aim for 90%+ code coverage
- Include descriptive test names
- Group tests logically with describe blocks

Follow AAA pattern:
- Arrange: Set up test data
- Act: Execute function under test
- Assert: Verify expected outcomes
```

**Documentation Command** (`.claude/commands/docs.md`):
```markdown
Generate documentation for $ARGUMENTS

Include:
- Overview and purpose
- Function/class signatures with JSDoc
- Parameter descriptions with types
- Return value descriptions
- Usage examples (minimum 2)
- Edge cases and limitations
- Related functions/classes

Style: Clear, concise, example-driven
```

**Security Audit** (`.claude/commands/security-audit.md`):
```markdown
Perform security audit on $ARGUMENTS

Check for OWASP Top 10:
1. Injection flaws (SQL, NoSQL, Command)
2. Broken authentication
3. Sensitive data exposure
4. XML External Entities (XXE)
5. Broken access control
6. Security misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure deserialization
9. Using components with known vulnerabilities
10. Insufficient logging & monitoring

Also check:
- Hard-coded secrets or credentials
- Insecure cryptography
- Missing input validation
- CSRF vulnerabilities
- Insecure direct object references

Provide severity ratings and remediation steps.
```

### Parameterized Commands

Use `$ARGUMENTS` keyword for dynamic input:

```markdown
# .claude/commands/refactor.md

Refactor $ARGUMENTS using these principles:
- Single Responsibility Principle
- DRY (Don't Repeat Yourself)
- Clear naming conventions
- Extract complex logic into helper functions
- Add type annotations
```

Usage:
```bash
/refactor UserService.ts
```

---

## Effective Workflows

### Explore-Plan-Code-Commit Pattern

**Recommended Workflow:**

1. **Explore** - Understand existing code
```bash
> "Read the authentication module and explain how it works"
[No code changes yet]
```

2. **Plan** - Design solution
```bash
> "Think about how to add OAuth support. Create a detailed plan."
[Use "think" for extended thinking mode]
```

3. **Code** - Implement
```bash
> "Implement the OAuth plan from above"
[Claude writes code]
```

4. **Commit** - Save work
```bash
> "Commit these changes with a good commit message"
[Claude creates commit]
```

**Extended Thinking Levels:**
- `"think"` - Basic extended thinking
- `"think hard"` - More computation time
- `"think harder"` - Even more thinking
- `"ultrathink"` - Maximum thinking budget

### Test-Driven Development (TDD)

**Workflow:**

1. **Write Tests First**
```bash
> "Write tests for a user registration function that validates email format and password strength"
```

2. **Confirm Tests Fail**
```bash
> "Run the tests and confirm they fail"
```

3. **Commit Tests**
```bash
> "Commit the tests"
```

4. **Implement to Pass**
```bash
> "Implement the registration function to pass the tests"
```

5. **Verify with Subagent**
```bash
> "Use a subagent to verify the implementation isn't overfitting to the tests"
```

**Benefits:**
- Clear success criteria
- Better test coverage
- Prevents implementation bias
- Forces thinking about edge cases

### Visual Iteration Pattern

For UI work:

1. **Provide Target**
```bash
> "Here's a screenshot of the design [attach image]"
```

2. **Implement**
```bash
> "Implement this design in React with Tailwind"
```

3. **Screenshot & Compare**
```bash
> "Here's what I got [attach screenshot]. Fix the differences."
```

4. **Iterate**
```bash
[Repeat until match]
```

### Safe YOLO Mode

For uninterrupted work in isolated environments:

```bash
claude-code --dangerously-skip-permissions
```

**⚠️ Use Only When:**
- Working in Docker containers
- Disposable development environments
- Low-risk experimental projects
- No production access

**Never Use:**
- On production systems
- With access to sensitive data
- In shared environments

### Codebase Q&A Pattern

Treat Claude like a knowledgeable colleague:

```bash
> "What's the overall architecture of this app?"
> "How does the payment processing work?"
> "Where should I add the new feature?"
> "What patterns are used for error handling?"
> "Show me examples of similar features"
```

**Great for:**
- Onboarding new developers
- Understanding legacy code
- Architecture exploration
- Pattern discovery

---

## Optimization Techniques

### Specificity Matters

**❌ Vague:**
```bash
"Add tests for foo.py"
```

**✅ Specific:**
```bash
"Add unit tests for foo.py covering:
- Happy path with valid input
- Edge case: empty string
- Edge case: very long strings (>1000 chars)
- Error case: null input
- Use pytest framework
- Aim for 90% coverage"
```

### Visual Context

Claude excels with visual references:

```bash
# Method 1: Screenshot paste
> "Here's the error I'm seeing" [paste screenshot]

# Method 2: Drag and drop
[Drag image file into chat]

# Method 3: File path
> "Check the screenshot at ./debug/error.png"
```

### File References

Use tab-completion for precision:

```bash
> "Review src/[TAB]"
# Shows: src/api/, src/components/, src/utils/

> "Review src/api/user[TAB]"
# Shows: src/api/userController.ts, src/api/userService.ts
```

### URL Integration

```bash
# Direct paste
> "Review the API docs at https://docs.example.com/api"

# Allowlist for repeated use
/permissions
# Add domain: docs.example.com
```

### Course Correction Tools

**Ask for Plans:**
```bash
> "Before implementing, show me a detailed plan"
```

**Interrupt (Escape):**
```bash
[Press Esc during execution]
> "Actually, use PostgreSQL instead of MySQL"
```

**Edit Previous Prompt (Double-Escape):**
```bash
[Press Esc twice]
[Modify previous message]
```

**Request Undo:**
```bash
> "Undo the last changes and try a different approach"
```

### Context Management

**Clear Between Tasks:**
```bash
/clear
```

When to clear:
- Switching to unrelated task
- Context getting cluttered
- Performance degrading
- Starting fresh feature

**Preserve Context:**
Use subagents for research without polluting main context:
```bash
> "Use a subagent to investigate the database schema"
```

### Checklists for Complex Tasks

**GitHub Issues as Scratchpad:**
```markdown
## Migration: Express 4 → Express 5

- [ ] Update package.json dependencies
- [ ] Replace deprecated middleware
  - [ ] body-parser (now built-in)
  - [ ] helmet (update syntax)
- [ ] Update route handlers (new signature)
- [ ] Fix async error handling
- [ ] Update tests
- [ ] Test in staging
- [ ] Update documentation
```

**Markdown Checklist:**
```bash
> "Here's the migration checklist. Complete items one by one and check them off:
[paste checklist]"
```

---

## Data Handling Strategies

### Input Methods

**1. Copy-Paste**
```bash
> "Here's the error log:
[paste log]"
```

**2. Pipe Input**
```bash
cat error.log | claude-code -p "Analyze this error log and suggest fixes"
```

**3. Bash Commands**
```bash
> "Run `git log --oneline -20` and summarize recent changes"
```

**4. File Reads**
```bash
> "Read ./logs/error.log and analyze the errors"
```

**5. URL Fetches**
```bash
> "Fetch https://api.example.com/users/123 and analyze the response"
```

### Strategic Combinations

**Example: Log Analysis**
```bash
# Pipe recent logs for immediate context
cat app.log | tail -100 | claude-code -p "Quick error summary"

# Then let Claude fetch more context
> "Now read the full log file and cross-reference with code"
```

---

## Headless Mode & Automation

### Non-Interactive Execution

```bash
claude-code -p "Your prompt here"
```

**Structured Output:**
```bash
claude-code -p "Analyze code" --output-format stream-json
```

### Use Cases

**Issue Triage:**
```bash
cat issue.txt | claude-code -p "Categorize this issue and suggest labels"
```

**Pre-Commit Hooks:**
```bash
# .git/hooks/pre-commit
#!/bin/bash
staged_files=$(git diff --cached --name-only --diff-filter=ACM)
claude-code -p "Review these staged files for obvious issues: $staged_files"
```

**Code Review:**
```bash
git diff main | claude-code -p "Review this diff for security and style issues"
```

**CI Integration:**
```bash
# .github/workflows/ai-review.yml
- name: AI Code Review
  run: |
    git diff origin/main | claude-code -p "Review changes" > review.md
```

---

## Multi-Claude Workflows

### Parallel Verification

**Pattern:**
```bash
# Terminal 1: Implementation
claude-code
> "Implement feature X"

# Terminal 2: Review
claude-code
> "Review the changes in feature-x branch for security issues"
```

**Benefits:**
- Independent context = fresher perspective
- Parallel work = faster completion
- Separation of concerns

### Multiple Git Checkouts

**Setup:**
```bash
# Clone to different directories
mkdir -p ~/projects/app-{1,2,3,4}
cd ~/projects/app-1 && git clone repo-url .
cd ~/projects/app-2 && git clone repo-url .
cd ~/projects/app-3 && git clone repo-url .
```

**Usage:**
```bash
# Terminal 1: Feature A
cd ~/projects/app-1
claude-code
> "Implement authentication"

# Terminal 2: Feature B
cd ~/projects/app-2
claude-code
> "Add payment processing"

# Terminal 3: Bug fix
cd ~/projects/app-3
claude-code
> "Fix the caching issue"
```

### Git Worktrees (Lighter Alternative)

**Setup:**
```bash
# Main checkout
cd ~/projects/app

# Add worktrees
git worktree add ../app-feature-auth feature/auth
git worktree add ../app-feature-payments feature/payments
git worktree add ../app-bugfix bugfix/cache
```

**Usage:**
```bash
# Each worktree is independent
cd ~/projects/app-feature-auth && claude-code
cd ~/projects/app-feature-payments && claude-code
```

**Benefits:**
- Shares .git directory (disk efficient)
- Independent working trees
- No checkout conflicts
- Easy cleanup: `git worktree remove`

### Programmatic Integration

**Fan-Out Pattern (Large-Scale Migrations):**
```bash
# Migrate all controllers
for file in src/controllers/*.js; do
  claude-code -p "Migrate $file from CommonJS to ES modules" &
done
wait
```

**Pipeline Pattern:**
```bash
# Data processing pipeline
cat data.json \
  | claude-code -p "Extract user records" \
  | claude-code -p "Validate email formats" \
  | claude-code -p "Format as CSV" \
  > output.csv
```

---

## GitHub Integration

### Setup

```bash
# Install GitHub CLI
brew install gh  # macOS
# or: https://github.com/cli/cli

# Authenticate
gh auth login
```

### Usage Examples

```bash
# Create issues
> "Create a GitHub issue for adding dark mode"

# Open pull requests
> "Create a PR for this feature branch"

# Review PRs
> "Fetch and review PR #123"

# Manage repository
> "List open issues labeled 'bug'"
```

### GitHub PR Integration (Beta)

Tag Claude Code in PR comments:

```markdown
@claude-code Please fix the failing tests mentioned in the CI output
```

Claude will:
1. Read PR context
2. Analyze CI failures
3. Fix issues
4. Push commits
5. Respond to comment

---

## Tool Permissions Management

### Methods

**1. Interactive (During Session):**
```bash
# Claude asks permission
> Allow Read access to src/? (y/n/always)
> always
```

**2. Command:**
```bash
/permissions
```

**3. Manual Edit:**
```json
// .claude/settings.json
{
  "allowedTools": ["Read", "Write", "Bash"],
  "allowedPaths": ["src/", "tests/"],
  "blockedPaths": [".env", "credentials.json"],
  "allowedCommands": ["npm test", "npm run build"]
}
```

**4. CLI Flags:**
```bash
claude-code --allowedTools Read,Write,Bash
```

### Security Best Practices

**Principle of Least Privilege:**
- Start restrictive
- Add permissions as needed
- Review periodically

**Sensitive Operations:**
```json
{
  "requireConfirmation": [
    "git push",
    "npm publish",
    "rm -rf",
    "curl -X POST"
  ]
}
```

---

## MCP (Model Context Protocol) Integration

### Configuration

**Project-Level:**
```json
// .claude/mcp.json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "postgresql://localhost/mydb"
      }
    }
  }
}
```

**Global:**
```json
// ~/.claude/mcp.json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/Users/you/projects"]
    }
  }
}
```

### Debugging

```bash
claude-code --mcp-debug
```

### Example Usage

```bash
# Claude can now access database via MCP
> "Query the users table and show me active users"

# Access external APIs
> "Fetch the latest data from our analytics MCP server"
```

---

## Common Patterns & Anti-Patterns

### ✅ DO

- **Be specific and detailed**
- **Provide examples of what you want**
- **Use CLAUDE.md to encode project knowledge**
- **Leverage subagents for parallel work**
- **Ask for plans before implementation**
- **Use checkpoints for experimentation**
- **Clear context between unrelated tasks**
- **Review all AI-generated code**
- **Use custom commands for repeated workflows**

### ❌ DON'T

- **Give vague instructions**
- **Skip code review**
- **Let context grow indefinitely**
- **Use YOLO mode on production systems**
- **Trust test results without verification**
- **Forget to update CLAUDE.md**
- **Overload single agent with parallel tasks**
- **Assume AI knows your specific requirements**

---

## Quick Reference

### Essential Commands

```bash
/help                  # Show help
/clear                 # Clear conversation
/rewind                # Rollback to checkpoint
/permissions           # Manage tool permissions
/agents                # Create/manage subagents
/statusline            # Configure status display

# Custom commands (examples)
/review                # Code review
/test <file>           # Write tests
/docs <function>       # Generate docs
/security-audit        # Security check
```

### Keyboard Shortcuts

```bash
Esc                    # Interrupt current task
Esc Esc                # Edit previous message
Ctrl+R                 # Search command history
Ctrl+B                 # Run command in background
Tab                    # Autocomplete file paths
Ctrl+C                 # Cancel operation
```

### Extended Thinking Triggers

```bash
"think"                # Basic extended thinking
"think hard"           # More computation
"think harder"         # Even more thinking
"ultrathink"           # Maximum thinking budget
```

---

## Resources

**Official Documentation:**
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Building Agents with Claude Agent SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
- [Claude Code Subagents Docs](https://docs.claude.com/en/docs/claude-code/sub-agents)

**Community Resources:**
- [Best Practices for Claude Code Subagents - PubNub](https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/)
- [Awesome Claude Code Subagents - GitHub](https://github.com/VoltAgent/awesome-claude-code-subagents)
- [Claude Agent SDK Best Practices - Skywork](https://skywork.ai/blog/claude-agent-sdk-best-practices-ai-agents-2025/)

**Related:**
- [[Claude Code|Claude Code Overview]]
- [[tools/coding-assistants/README|Coding Assistants Comparison]]
- [[MCP|Model Context Protocol]]

---

**Last Updated:** 2025-12-01
**Based on:** Anthropic Engineering Best Practices (November 2025)

*These practices represent current recommendations and will evolve as Claude Code develops.*
