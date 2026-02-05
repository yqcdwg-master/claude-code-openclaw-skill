---
name: claude-code-openclaw-skill
description: Invoke Claude Code programmatically for coding tasks, code analysis, and development workflows. Supports interactive mode, one-shot queries, and structured JSON output.
metadata:
  {
    "openclaw": {
      "emoji": "🤖",
      "requires": {
        "anyBins": ["claude"]
      }
    }
  }
---

# Claude Code Skill

Invoke Claude Code programmatically from OpenClaw for coding tasks, code analysis, debugging, and development automation.

## Installation

Ensure Claude Code CLI is installed:

```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# Or use Homebrew
brew install --cask claude-code
```

First-time use requires login: `claude`

## ⚠️ IMPORTANT: Correct Usage Format

### ✅ CORRECT Formats

```bash
# Basic query (recommended ⭐)
claude -p "Your task here"

# With PTY for interactive features
claude -p "Your task" --pty

# Interactive session
claude

# Specify working directory
claude -p "Your task" workdir:~/project

# With model specification
claude --model minimax/MiniMax-M2.1 -p "Your task"
```

### ❌ INCORRECT Formats

```bash
# WRONG - bash pty:true is NOT valid syntax in OpenClaw exec tool
bash pty:true command:"claude -p 'Task'"

# Error: bash: pty:true: No such file or directory

# WRONG - This syntax doesn't work
claude pty:true -p "Task"
```

### Why This Matters

The OpenClaw `exec` tool does NOT use `bash pty:true` syntax. Instead:

- Use `claude` directly as the command
- Add flags like `-p`, `--pty`, `--model` as needed
- Use `workdir:` parameter for directory specification

## Usage Modes

### 1. Interactive Mode

For user interaction, starts a complete Claude Code session:

```bash
# Start interactive session
claude

# Continue previous session
claude --continue
```

### 2. Print Mode ⭐ Recommended

Single-query mode, executes and exits automatically, suitable for programmatic calls:

```bash
# Basic usage
claude -p "Your task here"

# Specify working directory
claude -p "Explain the authentication flow" workdir:~/project

# JSON output (for parsing results)
claude -p --output-format json "List all functions in main.py"

# Stream JSON output
claude -p --output-format stream-json --include-partial-messages "Analyze this codebase"
```

### 3. Continue Session

Continue recent work:

```bash
# Continue most recent conversation
claude --continue

# Continue with a query
claude -c -p "Continue from where we left off"
```

### 4. Resume Specific Session

```bash
# Resume by name
claude -r "auth-refactor" "Finish implementing the auth flow"

# Resume by ID
claude --session-id "550e8400-e29b-41d4-a716-446655440000" "Continue working"
```

## Common Parameter Combinations

### Code Analysis

```bash
# Analyze project structure
claude -p "What technologies does this project use?"

# Explain specific function
claude -p "Explain the main() function in src/main.py"

# Explain folder structure
claude -p "Explain the folder structure of this project"
```

### Code Generation

```bash
# Add feature
claude -p "Add a hello world function to src/utils.rs"

# Refactor code
claude -p --append-system-prompt "Always use async/await" "Refactor the auth module"

# Fix bug
claude -p "Fix the bug where users can submit empty forms"
```

### Git Operations

```bash
# View changes
claude -p "What files have I changed?"

# Create commit
claude commit

# Create branch
claude -p "Create a new branch called feature/user-authentication"

# Help resolve merge conflicts
claude -p "Help me resolve merge conflicts"
```

### Code Review

```bash
# Review changes
claude -p "Review my changes and suggest improvements"

# Write tests
claude -p "Write unit tests for the calculator functions"
```

## Advanced Usage

### Custom Model

```bash
# Use specific model
claude --model minimax/MiniMax-M2.1 -p "Your task"

# Fallback model (when default is overloaded)
claude -p --fallback-model sonnet "Your task"
```

### Custom System Prompt

```bash
# Replace system prompt entirely
claude --system-prompt "You are a Python expert" -p "Create a new API endpoint"

# Load from file
claude -p --system-prompt-file ./prompts/python-expert.txt "Build a Django model"

# Append to default prompt
claude --append-system-prompt "Always use TypeScript" -p "Create a new component"
```

### Tool Restrictions

```bash
# Allow only specific tools
claude --tools "Read,Edit,Bash" -p "Add error handling"

# Disable all tools
claude --tools "" -p "Explain this code"

# Use default tools
claude --tools default -p "Your task"
```

### Budget & Limits

```bash
# Maximum spending limit
claude -p --max-budget-usd 5.00 "Your task"

# Maximum turns limit
claude -p --max-turns 3 "Your task"

# Disable session persistence
claude -p --no-session-persistence "Your task"
```

### Permission Modes

```bash
# Plan mode (view only, no modifications)
claude --permission-mode plan -p "Review my code"

# Allow skipping permissions (use with caution)
claude --permission-mode plan --allow-dangerously-skip-permissions -p "Your task"
```

## Pipeline & Redirection

### Process Pipeline Input

```bash
# Analyze from file
claude -p "Analyze this error" < error.log

# Process piped content
cat logs.txt | claude -p "Explain these errors"
```

### Output Redirection

```bash
# Save to file
claude -p --output-format json "List all imports" > imports.json

# Save verbose logs
claude -p --verbose "Your task" > output.log 2>&1
```

## Best Practices

### 1. Use Short Tasks

Claude Code works best with focused, short tasks:

```bash
# ✅ Good - short and specific
claude -p "What does this function do?"

# ❌ Avoid - too broad and may timeout
claude -p "Build an entire e-commerce application"
```

### 2. Step-by-Step Execution

Break complex tasks into smaller steps:

```bash
# Instead of one big task:
claude -p "Build entire todo app"

# Use multiple small tasks:
claude -p "Create HTML structure for todo app"
claude -p "Add CSS styling for skeuomorphic design"
claude -p "Implement JavaScript logic"
```

### 3. Use Read-Only Queries When Possible

Reduces permission issues and faster responses:

```bash
# Read-only queries work best
claude -p "Analyze this codebase"

claude -p "What files have changed?"
```

### 4. Specify Working Directory

Use `workdir` to limit Claude Code's access:

```bash
# Run in specific project directory
claude -p "Fix the login bug" workdir:~/Projects/myapp
```

### 5. Use JSON Output for Parsing

When you need to parse Claude Code's output:

```bash
claude -p --output-format json "What is the main function?" | jq -r '.result'
```

### 6. Set Reasonable Limits

```bash
# Budget limit
claude -p --max-budget-usd 2.00 "Your task"

# Turn limit
claude -p --max-turns 5 "Your task"
```

## Known Limitations

### 1. Long-Running Tasks Get SIGKILL

System may kill processes that run too long:

```bash
# May be killed if takes >30 seconds
claude -p "Complex refactoring task"

# Better approach - break into steps
claude -p "Step 1: Analyze current code"
claude -p "Step 2: Create refactoring plan"
claude -p "Step 3: Implement changes"
```

### 2. File Writes Require Permissions

OpenClaw security may block file operations:

```bash
# Claude Code may not be able to create files directly
claude -p "Create index.html"

# Alternative: Ask Claude Code for the code, then write it manually
# Or grant permissions in OpenClaw settings
```

### 3. Background Mode

For long tasks, use background mode:

```bash
# Run in background
claude -p "Complex task..." background:true

# Check progress
process action:log sessionId:XXX
```

## Troubleshooting

### Claude Code Not Responding

**Problem**: Claude Code starts but produces no output

**Solution**:
1. Check if MiniMax model is configured:
   ```bash
   cat ~/.claude/settings.json
   ```

2. Set environment variable in OpenClaw:
   ```bash
   openclaw config set env.ANTHROPIC_MODEL "MiniMax-M2.1"
   openclaw gateway restart
   ```

3. Verify configuration:
   ```bash
   claude --version
   ```

### Authentication Issues

**Problem**: Claude Code asks for login

**Solution**:
```bash
claude
# Follow login prompts
```

### Model Not Found

**Problem**: Wrong model or model not available

**Solution**:
```bash
# Specify model explicitly
claude --model minimax/MiniMax-M2.1 -p "Your task"
```

### Timeout Errors

**Problem**: Task takes too long and gets killed

**Solution**:
- Break into smaller steps
- Use simpler queries
- Reduce scope of task

## OpenClaw Integration

### Notify on Completion

For long-running tasks, have Claude Code notify OpenClaw:

```bash
claude -p "Build the REST API.

When completely finished, run: openclaw gateway wake --text \"Done: Built REST API\" --mode now"
```

### Error Handling

```bash
# Set timeout
claude -p "Your task" timeout:60

# Check exit code
claude -p "Your task" && echo "Success" || echo "Failed"
```

## Configuration Locations

### Claude Code Settings
- Location: `~/.claude/settings.json`
- Debug logs: `~/.claude/debug/`

### OpenClaw Environment Variables
```bash
# Set environment variable
openclaw config set env.VARIABLE_NAME "value"

# Requires gateway restart
openclaw gateway restart
```

## Related Resources

- [Claude Code Official Docs](https://code.claude.com/docs)
- [CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Quickstart Guide](https://code.claude.com/docs/en/quickstart)
- [Subagents Documentation](https://code.claude.com/docs/en/sub-agents)
- [MCP Servers](https://code.claude.com/docs/en/mcp)
