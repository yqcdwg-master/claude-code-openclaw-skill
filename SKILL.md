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

## Related Resources

- [Claude Code Docs](https://code.claude.com/docs)
- [Spec-Kit GitHub](https://github.com/github/spec-kit)
- [OpenClaw Docs](https://docs.openclaw.ai)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)

---

**Last Updated:** 2026-02-06
**Version:** 2.0.0
**Author:** Claude Code + OpenClaw
