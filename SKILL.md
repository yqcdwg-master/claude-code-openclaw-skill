---
name: claude-code-openclaw-skill
description: Comprehensive guide for invoking Claude Code programmatically with OpenClaw, including Spec-Kit workflow, troubleshooting, and best practices.
metadata:
  {
    "openclaw": {
      "emoji": "🤖",
      "requires": {
        "anyBins": ["claude", "specify"]
      }
    }
  }
---

# Claude Code OpenClaw Skill

**Comprehensive guide for invoking Claude Code programmatically with OpenClaw, including Spec-Kit workflow, troubleshooting, and best practices.**

## Table of Contents

1. [Quick Start](#quick-start)
2. [Working Directory Rule](#working-directory-rule)
3. [Correct Usage Format](#correct-usage-format)
4. [Complete Workflow with Spec-Kit](#complete-workflow-with-spec-kit)
5. [Common Parameters](#common-parameters)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)
8. [Configuration](#configuration)
9. [Examples](#examples)

---

## Quick Start

### Installation

```bash
# Install Claude Code (macOS/Linux/WSL)
curl -fsSL https://claude.ai/install.sh | bash

# Or use Homebrew
brew install --cask claude-code

# First-time login
claude
```

### First Project in 5 Minutes

```bash
# 1. Get workspace path
WORKSPACE=$(openclaw config get agents.defaults.workspace)
cd $WORKSPACE

# 2. Create project directory
mkdir my-first-project
cd my-first-project

# 3. Initialize Spec-Kit (optional but recommended)
specify init . --ai claude --force

# 4. Start developing
claude -p "Create a simple landing page with HTML and CSS"
```

---

## Working Directory Rule

**⭐ CRITICAL: ALL projects MUST be created in your OpenClaw workspace directory.**

### How to Get Your Workspace Path

**Method 1: OpenClaw CLI (Recommended)**
```bash
openclaw config get agents.defaults.workspace
# Output: /Users/yourname/code/AIWorkspace
```

**Method 2: Environment Variable**
```bash
cd $(openclaw config get agents.defaults.workspace)
```

**Method 3: Quick Alias (Add to ~/.zshrc or ~/.bashrc)**
```bash
alias cw='cd $(openclaw config get agents.defaults.workspace)'

# Usage
cw
mkdir new-project
cd new-project
```

### Why This Rule Exists

- ✅ Centralized project management
- ✅ Easy to track and backup
- ✅ Consistent with OpenClaw's design
- ✅ Prevents scattered projects

### Examples

**✅ CORRECT:**
```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir my-project
cd my-project
claude -p "Create a web app"
```

**❌ INCORRECT:**
```bash
cd ~/Projects  # Wrong location!
mkdir my-project
claude -p "Create a web app"
```

---

## Correct Usage Format

### ✅ CORRECT Formats

```bash
# Basic query (most common ⭐)
claude -p "Your task here"

# With interactive features
claude -p "Your task" --pty

# Specify working directory
claude -p "Your task" workdir:~/project

# With model specification
claude --model minimax/MiniMax-M2.1 -p "Your task"

# Interactive session
claude

# Continue previous session
claude --continue

# JSON output
claude -p --output-format json "Your query"
```

### ❌ INCORRECT Formats

```bash
# WRONG - bash pty:true is NOT valid
bash pty:true command:"claude -p 'Task'"
# Error: bash: pty:true: No such file or directory

# WRONG - Invalid syntax
claude pty:true -p "Task"
```

### Why This Matters

The OpenClaw `exec` tool uses a different syntax than traditional bash commands:

| Feature | Correct | Incorrect |
|---------|---------|-----------|
| PTY mode | `claude -p "..." --pty` | `bash pty:true command:"..."` |
| Working directory | `claude -p "..." workdir:~/project` | `cd ~/project && claude -p "..."` |
| Model | `claude --model X -p "..."` | `claude -m X -p "..."` |

---

## Complete Workflow with Spec-Kit

Spec-Kit provides a structured approach to development using Claude Code.

### What is Spec-Kit?

Spec-Kit is GitHub's toolkit for **Spec-Driven Development** - a methodology where:
1. Specifications are executable
2. Planning happens before coding
3. AI agents follow structured workflows
4. Quality is ensured through checkpoints

> 💡 **Alternative**: Consider using [OpenSpec](#openspec-alternative) for a lighter, more iterative approach.

---

## OpenSpec Alternative ⭐

### Why OpenSpec?

**OpenSpec** is a lighter, more iterative Spec-Driven Development tool:

| Feature | OpenSpec | Spec Kit |
|---------|----------|----------|
| Setup | Lightweight | Heavyweight |
| Phases | Iterative | Rigid gates |
| Files | Minimal | Many Markdown |
| Setup | npm install | Python + pip |
| Brownfield | Excellent | Limited |
| Speed | Fast | Slower |
| Models | 20+ AI tools | Claude only |

### Install OpenSpec

```bash
# Requires Node.js 20.19.0+
npm install -g @fission-ai/openspec@latest
```

### Initialize Project

```bash
cd $(openclaw config get agents.defaults.workspace)
cd your-project

openspec init
openspec update
```

### Quick Commands

| Command | Description |
|---------|------------|
| `/opsx:new <feature>` | Create new feature proposal |
| `/opsx:ff` | Fast-forward (generate all docs) |
| `/opsx:apply` | Implement all tasks |
| `/opsx:archive` | Archive completed feature |

### Example Workflow

```bash
# Start new feature
/opsx:new add dark mode

# Generate all docs (proposal, specs, design, tasks)
/opsx:ff

# Implement all tasks
/opsx:apply

# Archive when done
/opsx:archive
```

### Learn More

- **GitHub**: https://github.com/Fission-AI/OpenSpec
- **NPM**: https://www.npmjs.com/package/@fission-ai/openspec
- **Skill**: See [`openspec-openclaw-skill`](../openspec-openclaw-skill/SKILL.md) for complete guide

---

## OpenSpec Alternative ⭐

### Why OpenSpec?

**OpenSpec** is a lighter, more iterative Spec-Driven Development tool:

| Feature | OpenSpec | Spec Kit |
|---------|----------|----------|
| Setup | Lightweight | Heavyweight |
| Phases | Iterative | Rigid gates |
| Files | Minimal | Many Markdown |
| Setup | npm install | Python + pip |
| Brownfield | Excellent | Limited |
| Speed | Fast | Slower |
| Models | 20+ AI tools | Claude only |

### Install OpenSpec

```bash
# Requires Node.js 20.19.0+
npm install -g @fission-ai/openspec@latest
```

### Initialize Project

```bash
cd $(openclaw config get agents.defaults.workspace)
cd your-project

openspec init
openspec update
```

### Quick Commands

| Command | Description |
|---------|------------|
| `/opsx:new <feature>` | Create new feature proposal |
| `/opsx:ff` | Fast-forward (generate all docs) |
| `/opsx:apply` | Implement all tasks |
| `/opsx:archive` | Archive completed feature |

### Example Workflow

```bash
# Start new feature
/opsx:new add dark mode

# Generate all docs (proposal, specs, design, tasks)
/opsx:ff

# Implement all tasks
/opsx:apply

# Archive when done
/opsx:archive
```

### Learn More

- **GitHub**: https://github.com/Fission-AI/OpenSpec
- **NPM**: https://www.npmjs.com/package/@fission-ai/openspec
- **Skill**: See [`openspec-openclaw-skill`](../openspec-openclaw-skill/SKILL.md) for complete guide

### Workflow Overview

```
1. Initialize Project
   └── specify init . --ai claude --force

2. Create Constitution (Project Principles)
   └── Define code quality, design standards, workflows

3. Write Specification (What to Build)
   └── User stories, requirements, acceptance criteria

4. Create Plan (How to Build)
   └── Tech stack, architecture, implementation details

5. Generate Tasks (Breakdown)
   └── Actionable steps with dependencies

6. Implement (Build)
   └── Execute tasks following the plan
```

### Step-by-Step Guide

#### Step 1: Initialize Project

```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir my-awesome-project
cd my-awesome-project

# Initialize with Spec-Kit
specify init . --ai claude --force
```

**Expected Output:**
```
╭───────────────────────────────────────────────────────╮
│  Specify Project Setup                                │
╰───────────────────────────────────────────────────────╯
Project: my-awesome-project
Working Path: /Users/.../my-awesome-project
Selected AI: claude
Script: sh
├── Check tools (ok)
├── Fetch latest release
├── Download template
├── Extract template
└── Project ready!
```

#### Step 2: Create Constitution

```bash
# Use Claude Code to create constitution
claude -p "Use /speckit.constitution command to create project constitution.

Create principles focused on:
- Code quality standards
- Design requirements
- Testing requirements
- Performance guidelines
- Security considerations

The project is a web application using HTML/CSS/JavaScript."

# Or create manually:
cat > .specify/memory/constitution.md << 'EOF'
# Project Constitution

## Core Principles

### I. Code Quality
- Clean, readable code
- No unnecessary dependencies
- Self-documenting with clear naming

### II. Design Standards
- Responsive layout
- Accessibility compliance
- Smooth animations (60fps)

### III. Testing
- Manual testing required
- Cross-browser compatibility

## Technology Stack
- Vanilla HTML5, CSS3, JavaScript (ES6+)
- No frameworks (keep it simple)

## Governance
All decisions follow these principles.
EOF
```

#### Step 3: Write Specification

```bash
claude -p "Use /speckit.specify command to create a feature specification.

Describe: A todo list application where users can:
1. Create, edit, delete tasks
2. Mark tasks as complete
3. Organize tasks by categories
4. Filter tasks by category
5. Data persists in local storage"
```

**Or create manually:**
```bash
mkdir -p .specify/specs/001-todo-app

cat > .specify/specs/001-todo-app/spec.md << 'EOF'
# Feature: Todo List App

## User Stories

### Story 1: Create Task (Priority: P1)
As a user, I want to create tasks so I can track my work.

**Acceptance:**
- Given user enters task, When submits, Then task appears in list
- Given empty input, When submits, Then show error

### Story 2: Complete Task (Priority: P1)
As a user, I want to mark tasks as complete.

**Acceptance:**
- Given task exists, When checkbox clicked, Then task marked complete
- Given task complete, When unchecked, Then task reopened

## Requirements
- FR-001: Users MUST create tasks
- FR-002: Users MUST edit tasks
- FR-003: Users MUST delete tasks
- FR-004: Users MUST mark complete
EOF
```

#### Step 4: Create Plan

```bash
claude -p "Use /speckit.plan command to create implementation plan.

Tech stack:
- HTML5, CSS3, JavaScript (ES6+)
- Local storage for persistence
- No frameworks"
```

**Or manually:**
```bash
cat > .specify/specs/001-todo-app/plan.md << 'EOF'
# Implementation Plan

## Architecture

### Files
```
todo-app/
├── index.html      # Main structure
├── styles.css      # Styling
├── script.js       # Logic
└── .specify/
    └── specs/
        └── 001-todo-app/
            ├── spec.md
            ├── plan.md
            └── tasks.md
```

## Implementation Steps

### Phase 1: HTML Structure
- Create semantic HTML5
- Add form for task input
- Create task list container
- Add proper ARIA labels

### Phase 2: CSS Styling
- Responsive design
- Clean, modern UI
- Smooth animations

### Phase 3: JavaScript
- Task CRUD operations
- Local storage sync
- Event handlers
- Form validation

## Testing
- Manual browser testing
- Responsive check
- Accessibility verification
EOF
```

#### Step 5: Generate Tasks

```bash
claude -p "Use /speckit.tasks command to break down the plan into actionable tasks."
```

**Or manually:**
```bash
cat > .specify/specs/001-todo-app/tasks.md << 'EOF'
# Tasks

## Task 1: HTML Structure
**File**: index.html
- [ ] Create main container
- [ ] Add task form
- [ ] Create task list
- [ ] Add ARIA labels

## Task 2: CSS Styling
**File**: styles.css
- [ ] Base styles
- [ ] Form styling
- [ ] Task card styling
- [ ] Responsive design

## Task 3: JavaScript Logic
**File**: script.js
- [ ] Task class
- [ ] CRUD operations
- [ ] Local storage
- [ ] Event listeners
EOF
```

#### Step 6: Implement

```bash
# Execute tasks one by one
claude -p "Implement Task 1: Create index.html with semantic HTML, form, task list, and ARIA labels."

claude -p "Implement Task 2: Add CSS styling for responsive design, form elements, and task cards."

claude -p "Implement Task 3: Create JavaScript for task CRUD operations and local storage persistence."
```

### Spec-Kit Command Reference

| Command | Description | When to Use |
|---------|-------------|-------------|
| `/speckit.constitution` | Create project principles | Before any development |
| `/speckit.specify` | Define requirements | After constitution |
| `/speckit.plan` | Create technical plan | After specification |
| `/speckit.tasks` | Generate task breakdown | After plan |
| `/speckit.implement` | Execute all tasks | Ready to build |
| `/speckit.clarify` | Ask structured questions | When requirements unclear |
| `/speckit.checklist` | Quality checklist | Before deployment |

---

## Common Parameters

### Basic Parameters

```bash
# Print mode (most common)
claude -p "Your task"

# With specific model
claude --model minimax/MiniMax-M2.1 -p "Your task"

# Interactive session
claude

# Continue previous
claude --continue
```

### Output Control

```bash
# JSON output
claude -p --output-format json "Your query"

# Stream JSON (real-time)
claude -p --output-format stream-json --include-partial-messages "Your query"

# Verbose logging
claude -p --verbose "Your task"
```

### Behavior Control

```bash
# Budget limit ($2.00)
claude -p --max-budget-usd 2.00 "Your task"

# Max turns (3)
claude -p --max-turns 3 "Your task"

# No persistence
claude -p --no-session-persistence "Your task"
```

### Customization

```bash
# Custom system prompt
claude --system-prompt "You are a Python expert" -p "Your task"

# Append to default
claude --append-system-prompt "Always use TypeScript" -p "Your task"

# From file
claude -p --system-prompt-file ./prompts/custom.txt "Your task"
```

### Permission Modes

```bash
# Plan mode (read-only)
claude --permission-mode plan -p "Review my code"

# Skip permissions
claude --permission-mode plan --allow-dangerously-skip-permissions -p "Your task"
```

---

## Best Practices

### 1. Start Small

```bash
# ✅ Good
claude -p "Create a button component"

# ❌ Too broad
claude -p "Build an entire e-commerce platform"
```

### 2. Break Complex Tasks

```bash
# Instead of one task:
claude -p "Build todo app with auth, database, API"

# Break into steps:
claude -p "Step 1: Design database schema"
claude -p "Step 2: Create HTML structure"
claude -p "Step 3: Add CSS styling"
claude -p "Step 4: Implement JavaScript"
claude -p "Step 5: Add authentication"
claude -p "Step 6: Connect to API"
```

### 3. Use Read-Only First

```bash
# ✅ Faster and safer
claude -p "Analyze this codebase structure"

claude -p "What files need updating?"

# Then create files
claude -p "Create index.html based on the analysis"
```

### 4. Always Verify

```bash
# Claude Code generates code
claude -p "Create a login form"

# Always verify manually:
cat index.html

# Test in browser
python3 -m http.server 8080
# Open http://localhost:8080
```

### 5. Use Proper Error Handling

```bash
# Set timeouts
claude -p "Your complex task" timeout:60

# Check exit status
claude -p "Your task" && echo "Success" || echo "Failed"
```

### 6. Document Your Work

```bash
# Use Spec-Kit for documentation
claude -p "Document the codebase with README.md"

# Include examples
claude -p "Add code examples to README.md"
```

---

## Troubleshooting

### Problem 1: Claude Code Not Responding

**Symptoms:**
- Starts but no output
- Gets SIGKILL
- Times out immediately

**Solutions:**

1. Check configuration:
```bash
cat ~/.claude/settings.json
```

2. Set environment variable:
```bash
openclaw config set env.ANTHROPIC_MODEL "MiniMax-M2.1"
openclaw gateway restart
```

3. Verify model:
```bash
claude --version
```

### Problem 2: Permission Denied for File Operations

**Symptoms:**
- "Cannot create file"
- "Permission denied"
- Files not being written

**Solutions:**

1. Add to allowlist:
```bash
openclaw approvals allowlist add "/Users/yourname/.local/bin/claude"
```

2. Verify allowlist:
```bash
cat ~/.openclaw/exec-approvals.json
```

### Problem 3: Wrong Model Being Used

**Symptoms:**
- Different responses than expected
- "Model not found" errors
- Unexpected behavior

**Solutions:**

1. Explicitly specify model:
```bash
claude --model minimax/MiniMax-M2.1 -p "Your task"
```

2. Check default model:
```bash
openclaw config get agents.defaults.model.primary
```

### Problem 4: Long Tasks Timing Out

**Symptoms:**
- Gets SIGKILL after ~30 seconds
- Incomplete output
- "Session closed" errors

**Solutions:**

1. Break into smaller tasks:
```bash
# Instead of:
claude -p "Create entire app"

# Do:
claude -p "Create HTML structure"
claude -p "Add CSS styling"
claude -p "Implement JavaScript"
```

2. Use simpler queries:
```bash
# Instead of complex analysis:
claude -p "Analyze this function"

# Use focused query:
claude -p "What does this function return?"
```

### Problem 5: Files Created in Wrong Location

**Symptoms:**
- Files appear in wrong directory
- Cannot find created files
- Path confusion

**Solutions:**

1. Always use workdir parameter:
```bash
# ✅ Correct
claude -p "Create file" workdir:~/project

# ❌ Wrong
cd ~/project && claude -p "Create file"
```

2. Navigate first, then use relative paths:
```bash
cd ~/project
claude -p "Create index.html"  # Creates in current dir
```

### Problem 6: JSON Output Not Parsable

**Symptoms:**
- jq: parse error
- Unexpected output format
- Missing data

**Solutions:**

1. Use correct flags:
```bash
# ✅ Correct
claude -p --output-format json "Your query" | jq '.result'

# ❌ Wrong
claude -p "Your query" | jq '.result'
```

2. Check jq installation:
```bash
which jq
```

### Problem 7: Interactive Mode Not Working

**Symptoms:**
- Cannot use interactive features
- Sessions not continuing
- "Not in interactive mode" errors

**Solutions:**

1. Use correct command:
```bash
# For interactive
claude

# For one-shot
claude -p "Your task"
```

2. Check TTY:
```bash
# Use --pty flag
claude -p "Interactive task" --pty
```

---

## Configuration

### OpenClaw Configuration

**Location:** `~/.openclaw/openclaw.json`

**Key Settings:**
```json
{
  "agents": {
    "defaults": {
      "workspace": "/Users/yourname/code/AIWorkspace",
      "model": {
        "primary": "minimax/MiniMax-M2.1"
      }
    }
  }
}
```

### Claude Code Configuration

**Location:** `~/.claude/settings.json`

**Example:**
```json
{
  "env": {
    "ANTHROPIC_MODEL": "MiniMax-M1.1",
    "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic"
  }
}
```

### Environment Variables

**Set via OpenClaw:**
```bash
openclaw config set env.VARIABLE_NAME "value"
openclaw gateway restart
```

**Common Variables:**
```bash
openclaw config set env.ANTHROPIC_MODEL "MiniMax-M2.1"
openclaw config set env.ANTHROPIC_BASE_URL "https://api.minimaxi.com/anthropic"
```

### Allowlist Configuration

**Location:** `~/.openclaw/exec-approvals.json`

**Add Claude Code:**
```bash
openclaw approvals allowlist add "/Users/yourname/.local/bin/claude"
```

**Result:**
```json
{
  "agents": {
    "*": {
      "allowlist": [{
        "pattern": "/Users/yourname/.local/bin/claude"
      }]
    }
  }
}
```

---

## Examples

### Example 1: Create a Web Project

```bash
# 1. Setup
cd $(openclaw config get agents.defaults.workspace)
mkdir my-website
cd my-website
specify init . --ai claude --force

# 2. Create constitution
claude -p "Create constitution.md focusing on responsive design and accessibility."

# 3. Plan and build
claude -p "Create index.html with semantic HTML and ARIA labels."
claude -p "Add CSS for responsive design."
claude -p "Add JavaScript for mobile menu toggle."

# 4. Test
python3 -m http.server 8080
# Open http://localhost:8080
```

### Example 2: Create a Skill

```bash
# 1. Setup
cd $(openclaw config get agents.defaults.workspace)
mkdir my-awesome-skill
cd my-awesome-skill
specify init . --ai claude --force

# 2. Structure
claude -p "Create README.md, SKILL.md, and examples/ directory structure."

# 3. Content
claude -p "Write comprehensive SKILL.md with usage examples."

# 4. Test
claude -p "Verify all files follow skill template requirements."

# 5. Publish
git add .
git commit -m "Initial commit"
git push origin main
```

### Example 3: Code Review

```bash
# 1. Navigate to project
cd $(openclaw config get agents.defaults.workspace)
cd my-project

# 2. Review changes
claude -p "What files have changed since last commit?"

# 3. Detailed review
claude -p "Review the changes for security issues."

# 4. Suggestions
claude -p "Suggest improvements for the modified code."
```

### Example 4: Bug Fix

```bash
# 1. Describe the bug
claude -p "There's a bug where form submits empty data. Help identify the issue."

# 2. Get fix
claude -p "Add validation to prevent empty form submission."

# 3. Test
claude -p "Create a test to verify the fix works."
```

### Example 5: API Development

```bash
# 1. Plan API
claude -p "Design a REST API for user management with endpoints:
- GET /users
- POST /users
- GET /users/:id
- PUT /users/:id
- DELETE /users/:id"

# 2. Implement
claude -p "Create server.js with Express.js for the API."

# 3. Add tests
claude -p "Write unit tests for each endpoint."

# 4. Document
claude -p "Generate API documentation in README.md."
```

---

## Quick Reference

### Essential Commands

```bash
# Get workspace
WORKSPACE=$(openclaw config get agents.defaults.workspace)

# Navigate
cd $WORKSPACE

# Create project
mkdir new-project
cd new-project

# Initialize Spec-Kit
specify init . --ai claude --force

# Develop with Claude Code
claude -p "Your task"

# Continue session
claude --continue
```

### File Locations

| Purpose | Location |
|---------|----------|
| OpenClaw config | `~/.openclaw/openclaw.json` |
| Claude settings | `~/.claude/settings.json` |
| Debug logs | `~/.claude/debug/` |
| Allowlist | `~/.openclaw/exec-approvals.json` |

### Useful Aliases (Add to ~/.zshrc)

```bash
# Navigate to workspace
alias cw='cd $(openclaw config get agents.defaults.workspace)'

# Quick project
alias np='cd $(openclaw config get agents.defaults.workspace) && mkdir -p new-project && cd new-project'

# Server
alias serve='python3 -m http.server 8080'

# Claude Code
alias cc='claude -p'
```

---

## Known Issues and Solutions

This section documents real issues encountered during development with Claude Code + OpenClaw and their solutions.

---

### Issue 1: @types/react-swipeable Version Not Found

**Error:**
```
npm error code ETARGET
npm error notarget No matching version found for @types/react-swipeable@^7.0.6.
```

**Cause:** The specified version of @types/react-swipeable doesn't exist in npm registry.

**Solution:**
```json
// package.json - devDependencies
{
  // ❌ Don't add @types for packages that include their own types
  // "@types/react-swipeable": "^7.0.6",
  
  // ✅ Just use the main package - it includes type definitions
  "react-swipeable": "^7.0.1"
}
```

**Prevention:**
- ✅ Check if a package includes its own type definitions before adding @types
- ✅ Search available versions: `npm search @types/package-name`
- ✅ Prefer packages that bundle their own types

---

### Issue 2: Chakra UI Icons Import Failure

**Error:**
```
Uncaught SyntaxError: The requested module '/node_modules/.vite/deps/@chakra-ui_icons.js' 
does not provide an export named 'SpeakerIcon'
```

**Cause:** @chakra-ui/icons has compatibility issues in newer versions.

**Solution:**
```typescript
// ❌ Don't import from @chakra-ui/icons (may fail)
import { SpeakerIcon, StarIcon, CheckIcon } from '@chakra-ui/icons';

// ✅ Use inline SVG components instead
const SpeakerIcon = (props: React.SVGProps<SVGSVGElement>) => (
  <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" {...props}>
    <polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"></polygon>
    <path d="M15.54 8.46a5 5 0 0 1 0 7.07"></path>
  </svg>
);
```

**Prevention:**
- ✅ Use Chakra UI's built-in components when possible
- ✅ For simple icons, inline SVGs are more reliable
- ✅ Create a centralized icons component library for reusable icons

---

### Issue 3: Template String Syntax Errors

**Error Examples:**
```typescript
// ❌ Wrong - escaping single quotes in template
definition: 'To find one\'s way across an area',

// ❌ Wrong - unclosed template string
w={`${Math.min(100, (stats.wordsLearned / Math.max(1, stats.wordsLearned))}%`}
```

**Solution:**
```typescript
// ✅ Use double quotes for strings with single quotes
definition: "To find one's way across an area",

// ✅ Ensure template strings are properly closed
w={`${Math.min(100, (stats.wordsLearned / Math.max(1, stats.wordsLearned))}%`}
```

**Debug Commands:**
```bash
# Check specific line numbers
sed -n '100,110p' filename

# Check for invisible characters
sed -n '行号p' 文件名 | od -c

# Verify file completeness
tail -20 filename
```

**Prevention:**
- ✅ Use IDE syntax highlighting and linting
- ✅ Use double quotes for strings containing apostrophes
- ✅ Ensure template string `${}` is properly closed
- ✅ Run ESLint before committing

---

### Issue 4: Vite + Ngrok Host Not Allowed

**Error:**
```
Blocked request. This host ("xxx.ngrok-free.dev") is not allowed. 
To allow this host, add "xxx.ngrok-free.dev" to server.allowedHosts in vite.config.js.
```

**Solution:**
```typescript
// vite.config.ts
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: true,
    allowedHosts: [
      'althea-lanceted-floridly.ngrok-free.dev', // Specific domain
      'true' // Or allow all hosts
    ]
  }
});
```

**Better Solution (Auto-detect ngrok):**
```typescript
import { readFileSync } from 'fs';

const ngrokLog = readFileSync('/tmp/ngrok.log', 'utf-8');
const ngrokUrl = ngrokLog.match(/https:\/\/[^\s]+/)?.[0];
const ngrokHost = ngrokUrl ? new URL(ngrokUrl).hostname : 'true';

export default defineConfig({
  server: {
    allowedHosts: [ngrokHost]
  }
});
```

**Prevention:**
- ✅ Always set `host: true` in Vite config
- ✅ Configure allowedHosts when using ngrok
- ✅ Create a startup script that auto-updates Vite config

---

### Issue 5: Incomplete File Exports

**Error:**
```
The requested module does not provide an export named 'WordCard'
```

**Cause:** File write operation was interrupted, leaving incomplete exports.

**Solution:**
```bash
# Always verify files after writing
tail -20 filename

# If incomplete, rewrite the complete file
```

**Prevention:**
- ✅ Always verify file completeness after write operations
- ✅ Check for proper export statements at file end
- ✅ Use version control to track file changes
- ✅ Break large files into smaller modules

---

## Quick Reference Card

### ✅ DO's (Recommended)
- Use double quotes for strings containing apostrophes
- Verify file completeness after writing
- Use inline SVGs for reliable icons
- Configure Vite allowedHosts for ngrok
- Use packages with built-in type definitions

### ❌ DON'Ts (Avoid)
- Don't add @types packages without checking
- Don't escape single quotes in template strings
- Don't assume file writes are always complete
- Don't skip Vite config for ngrok
- Don't use deprecated or incompatible packages

---

## GitHub CLI Reference

GitHub CLI (`gh`) is essential for managing repositories, issues, and pull requests directly from the command line.

**Official Documentation:** https://cli.github.com/manual/gh

---

### Installation and Authentication

**Install GitHub CLI:**
```bash
# macOS
brew install gh

# Linux (Debian/Ubuntu)
sudo apt install gh

# Windows
winget install GitHub.cli
```

**Authenticate:**
```bash
# Interactive login (opens browser)
gh auth login

# Check authentication status
gh auth status
```

---

### Core Commands

| Command | Description | Example |
|---------|-------------|---------|
| `gh auth` | Manage authentication | `gh auth login`, `gh auth status` |
| `gh repo` | Manage repositories | `gh repo create`, `gh repo clone` |
| `gh issue` | Manage issues | `gh issue create`, `gh issue list` |
| `gh pr` | Manage pull requests | `gh pr create`, `gh pr checkout` |
| `gh browse` | Open repository in browser | `gh repo view --web` |
| `gh api` | Make API requests | `gh api repos` |

---

### Repository Management

**Create a new repository:**
```bash
# Interactive mode
gh repo create

# Non-interactive (with name, public)
gh repo create my-project --public --description "My project description"

# Create from existing local directory
gh repo create my-project --private --source=. --remote=origin

# Create and clone
gh repo create my-project --public --clone

# Create with all options
gh repo create my-project \
  --public \
  --description "Project description" \
  --gitignore Node \
  --license MIT \
  --clone
```

**Clone a repository:**
```bash
# Clone by name (requires authenticated user)
gh repo clone username/repository

# Clone with full URL
gh repo clone https://github.com/username/repository.git

# Clone specific branch
gh repo clone username/repo -- -b branch-name
```

**View repository:**
```bash
# View in terminal
gh repo view

# Open in browser
gh repo view --web

# View with extended info
gh repo view --repo username/repo --json name,description,url
```

**List repositories:**
```bash
# List your repositories
gh repo list

# List with limit
gh repo list --limit 50

# List organization repositories
gh repo list org-name
```

**Sync repository:**
```bash
# Sync with remote
gh repo sync

# Sync specific branch
gh repo sync --branch main
```

---

### Issue Management

**Create an issue:**
```bash
# Interactive mode
gh issue create

# Non-interactive
gh issue create \
  --title "Bug in login feature" \
  --body "Description of the bug" \
  --label bug

# With assignee
gh issue create --title "Feature request" --assignee username
```

**List issues:**
```bash
# List open issues
gh issue list

# List with filters
gh issue list --state all --limit 20

# List by label
gh issue list --label "bug"
```

**View issue:**
```bash
# View in terminal
gh issue view 123

# Open in browser
gh issue view 123 --web
```

**Close/reopen issue:**
```bash
gh issue close 123
gh issue reopen 123
```

---

### Pull Request Management

**Create a PR:**
```bash
# Interactive mode
gh pr create

# Non-interactive
gh pr create \
  --title "Add new feature" \
  --body "Description of changes" \
  --base main

# Create from current branch
gh pr create --head feature-branch
```

**Checkout PR:**
```bash
# Checkout PR locally
gh pr checkout 123

# Checkout by branch name
gh pr checkout username:feature-branch
```

**View PR:**
```bash
# View in terminal
gh pr view 123

# View checks status
gh pr view 123 --checks

# Open in browser
gh pr view 123 --web
```

**Merge PR:**
```bash
# Merge PR
gh pr merge 123

# Squash and merge
gh pr merge 123 --squash

# Merge with message
gh pr merge 123 --body "Merged by GitHub CLI"
```

**List PRs:**
```bash
# List open PRs
gh pr list

# List all PRs
gh pr list --state all
```

---

### GitHub API

**Make API requests:**
```bash
# Get repository info
gh api repos/username/repo

# List issues
gh api repos/username/repo/issues

# Create issue via API
gh api repos/username/repo/issues \
  -f title="Issue title" \
  -f body="Issue description"

# Use pagination
gh api repos/username/repo/issues?per_page=100
```

**API with authentication:**
```bash
# Uses authenticated token automatically
gh api user

# Custom headers
gh api repos/username/repo -H "Accept: application/vnd.github.v3+json"
```

---

### Useful Aliases

Add these to your `~/.config/gh/config.yml`:

```yaml
aliases:
  co: pr checkout
  ci: issue create
  cl: repo clone
  status: repo view --json status
  cleanup: "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d"
```

Or create shell aliases:
```bash
# ~/.zshrc or ~/.bashrc
alias ghstatus='gh repo view --json status'
alias ghmyrepos='gh repo list --limit 20'
alias ghnewissue='gh issue create --title'
```

---

### Automation Examples

**Create issue from script:**
```bash
#!/bin/bash
# Create issue with environment variables
gh issue create \
  --title "Build failed: $BUILD_NUMBER" \
  --body "Build failed on $DATE" \
  --label bug,CI

# Check for duplicate issue
if gh issue list --search "Build failed" --state open | grep -q .; then
  echo "Issue already exists"
else
  gh issue create --title "Build failed" --body "..."
fi
```

**Sync fork workflow:**
```bash
# Sync fork with upstream
gh repo sync username/fork --base owner/upstream --branch main

# Create PR from fork
gh pr create --title "Sync with upstream" --body "Updated from upstream"
```

---

### Troubleshooting

**Authentication issues:**
```bash
# Check status
gh auth status

# Refresh token
gh auth refresh

# Logout and login again
gh auth logout
gh auth login
```

**Permission denied:**
```bash
# Check repo access
gh api user/repos --jq '.[].permissions | keys'

# Verify scopes
gh auth status --show-token
```

**Rate limiting:**
```bash
# Check rate limit
gh api rate_limit

# Authenticated requests have higher limits
gh auth login
```

---

## Common Debugging Commands

```bash
# Check file end
tail -20 filename

# Check specific lines
sed -n '100,110p' filename

# Check invisible characters
sed -n '行号p' 文件名 | od -c

# Restart Vite server
pkill -f vite
npm run dev

# Check port usage
lsof -i :3000

# Check ngrok status
cat /tmp/ngrok.log

# Get ngrok URL
grep -o "https://[^[:space:]]*" /tmp/ngrok.log | head -1

# GitHub CLI status
gh auth status

# GitHub repo info
gh repo view --json
```

---

## Related Resources

- [Claude Code Docs](https://code.claude.com/docs)
- [Spec-Kit GitHub](https://github.com/github/spec-kit)
- [OpenClaw Docs](https://docs.openclaw.ai)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Vite Config](https://vitejs.dev/config/)

---

**Last Updated:** 2026-02-06
**Version:** 2.4.0 (Added OpenSpec Usage Tips & Best Practices)
**Author:** Claude Code + OpenClaw

---

## OpenSpec Usage Tips & Best Practices ⭐

Based on real project development experience (Todo List app, 2026-02-06).

---

### Quick Start Commands

```bash
# 1. Install OpenSpec (requires Node.js 20.19.0+)
npm install -g @fission-ai/openspec@latest

# 2. Initialize project
cd your-project
openspec init --tools claude

# 3. Create new feature
openspec new change feature-name --description "Feature description"

# 4. List available commands
openspec help

# 5. Update AI instructions
openspec update
```

---

### Workflow Tips

#### 1. Initialize with Correct Tools
```bash
# ✅ Correct - specify claude as tool
openspec init --tools claude

# ❌ Wrong - missing required --tools flag
openspec init
```

#### 2. Use Descriptive Feature Names
```bash
# ✅ Good - kebab-case, descriptive
openspec new change todo-list-app --description "Simple todo management"

# ❌ Bad - unclear name
openspec new change feature-1
```

#### 3. Always Update After Init
```bash
# ✅ Good practice
openspec init --tools claude
openspec update  # Refresh AI instructions

# Why? Ensures latest slash commands are active
```

#### 4. Check Feature Status
```bash
# Before applying, check what's in the feature
ls openspec/changes/feature-name/

# View all changes
openspec list
```

---

### Document Structure Best Practices

#### Required Documents

**README.md** (Essential)
```markdown
# feature-name

Brief description

## Features Implemented
- ✅ Feature 1
- ✅ Feature 2

## Technical Details
- Technology stack
- File structure
- Key decisions

## Usage
How to use the feature

## Created With
- OpenSpec
- Claude Code
```

**requirements.md** (Important)
```markdown
# Functional Requirements

## FR-001: Feature Name
**Priority**: P0 (Essential)

- Requirement 1
- Requirement 2

## Non-Functional Requirements
- Performance
- Accessibility
- Browser support
```

**scenarios.md** (User Stories)
```markdown
## Scenario 1: Description
**User**: User type

**Given** context
**When** action
**Then** expected outcome
```

**design.md** (Technical)
```markdown
# Technical Design

## Architecture
Component structure

## Data Model
TypeScript interfaces

## Implementation Plan
Step-by-step approach
```

**tasks.md** (Checklist)
```markdown
# Tasks

## Task 1: Task Name
**File**: filename

### Subtasks
- [ ] Subtask 1
- [ ] Subtask 2

**Status**: ✅ Complete
```

---

### Project Structure Example

```
project/
├── index.html          # Main file
├── styles.css          # Styling
├── script.js           # Logic
└── openspec/
    └── changes/
        └── feature-name/
            ├── README.md           # ✅ Required
            ├── design.md           # ✅ Required
            ├── specs/
            │   ├── requirements.md # ✅ Required
            │   └── scenarios.md    # ✅ Required
            └── tasks.md           # ✅ Required
```

---

### Real-World Workflow Example

#### Project: Todo List App

**Step 1: Create Feature**
```bash
cd todo-openspec
openspec init --tools claude
openspec new change todo-list-app --description "Simple todo management"
```

**Step 2: Create Documents**
```bash
# Edit files manually or with Claude Code
claude -p "Create requirements.md for a todo list with add/edit/delete/complete features"

claude -p "Create user scenarios.md with Gherkin-style Given/When/Then"

claude -p "Create design.md with component structure and data model"

claude -p "Create tasks.md with implementation checklist"
```

**Step 3: Implement**
```bash
# Create core files
claude -p "Create index.html with semantic HTML structure"

claude -p "Create styles.css with responsive design, CSS variables, and smooth animations"

claude -p "Create script.js with TodoList class, localStorage persistence, and event handling"
```

**Step 4: Test & Verify**
```bash
# Manual testing checklist
- [x] Add task (button + Enter)
- [x] Complete task (checkbox)
- [x] Delete task
- [x] Edit task
- [x] Filter tabs
- [x] Persistence
- [x] Mobile layout
```

**Step 5: Document**
```bash
# Update README.md with features, usage, and screenshots
```

---

### Common Mistakes & Solutions

#### Mistake 1: Wrong Tool Name
```bash
# ❌ Error: Missing required option --tools
openspec init
# Valid tools: amazon-q, auggie, claude, cursor, etc.

# ✅ Fix
openspec init --tools claude
```

#### Mistake 2: Wrong Case in Feature Name
```bash
# ❌ Error: Must be lowercase
openspec new change Todo-List

# ✅ Fix
openspec new change todo-list-app
```

#### Mistake 3: Forgetting to Update
```bash
# ❌ Problem: Slash commands not working
/opsx:new

# ✅ Fix
openspec update
```

#### Mistake 4: Missing Documents
```bash
# ❌ Bad: No documentation

# ✅ Good: Complete docs
openspec new change feature
# Then manually create:
# - README.md
# - requirements.md
# - scenarios.md
# - design.md
# - tasks.md
```

---

### Tips for Claude Code Integration

#### 1. Provide Clear Prompts
```bash
# ✅ Good
claude -p "Create requirements.md for a todo list. Include:
- Add, edit, delete, complete features
- Local storage persistence
- Filter tabs (All/Active/Completed)"

# ❌ Bad
claude -p "Create requirements"
```

#### 2. Specify File Locations
```bash
# ✅ Good
claude -p "Create index.html in the project root"

# ❌ Bad
claude -p "Create index.html"
```

#### 3. Break Large Tasks
```bash
# ✅ Good - multiple focused tasks
claude -p "Create HTML structure"
claude -p "Add CSS styling"
claude -p "Implement JavaScript"

# ❌ Bad - one huge task
claude -p "Create entire todo app"
```

#### 4. Reference OpenSpec Documents
```bash
# ✅ Good
claude -p "Implement Task 1 from openspec/changes/todo-list-app/tasks.md"

# ✅ Good
claude -p "Follow the requirements in openspec/changes/todo-list-app/specs/requirements.md"
```

---

### Testing & Verification Checklist

- [ ] All files created in correct locations
- [ ] HTML validates (W3C Validator)
- [ ] CSS has no errors
- [ ] JavaScript has no console errors
- [ ] Features work as specified in requirements
- [ ] Edge cases handled (empty input, long text, etc.)
- [ ] Mobile layout works (responsive design)
- [ ] Data persists (localStorage)
- [ ] Accessibility (keyboard nav, ARIA labels)
- [ ] Performance (fast load, smooth animations)

---

### Project Metrics (Example: Todo List)

| Metric | Value |
|--------|--------|
| Core Files | 3 (HTML, CSS, JS) |
| Documentation | 5 OpenSpec docs |
| Dependencies | 0 (vanilla) |
| Lines of Code | ~310 |
| Features | 7 (+ filters, persistence) |
| Responsive | Yes (mobile-first) |
| Accessibility | Yes (keyboard, ARIA) |

---

### Quick Reference Card

#### Daily Commands
```bash
# Start new feature
openspec new change feature-name

# Update AI
openspec update

# List changes
openspec list

# Archive complete
openspec archive feature-name
```

#### File Locations
```
openspec/changes/
├── feature-name/
│   ├── README.md
│   ├── design.md
│   ├── specs/
│   │   ├── requirements.md
│   │   └── scenarios.md
│   └── tasks.md
```

#### Documentation Checklist
- [ ] README.md (features, usage)
- [ ] requirements.md (functional specs)
- [ ] scenarios.md (user stories)
- [ ] design.md (technical approach)
- [ ] tasks.md (implementation checklist)

---

### OpenSpec Experience Summary

**Project:** Todo List App  
**Date:** 2026-02-06  
**Result:** ✅ Successfully completed with zero dependencies

**Key Learnings:**
1. OpenSpec provides excellent structure for small-to-medium projects
2. Manual document creation is sometimes faster than waiting for Claude Code
3. The specification documents help keep the project focused
4. Task checklists make it easy to track progress
5. Claude Code + OpenSpec = fast, structured development

**Tips for Success:**
1. Always run `openspec update` after init
2. Create documents in this order: requirements → scenarios → design → tasks
3. Use Claude Code for implementation, not documentation (faster)
4. Test frequently (every 2-3 tasks)
5. Archive features promptly to keep workspace clean

---

**OpenSpec Experience:** Todo List project completed successfully (2026-02-06)
- Zero dependencies
- Mobile-first responsive design
- Complete OpenSpec documentation
- Smooth integration with Claude Code

**Key Takeaway:** OpenSpec + Claude Code = Structured, documented, maintainable projects

