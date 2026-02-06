# Claude Code OpenClaw Skill

🤖 **Comprehensive guide for invoking Claude Code programmatically with OpenClaw**

A skill that provides complete documentation and best practices for using Claude Code with OpenClaw, including Spec-Kit workflow integration, troubleshooting, and development patterns.

## What This Skill Provides

- ✅ Complete workflow guide for Claude Code + Spec-Kit
- ✅ Correct usage formats and examples
- ✅ Troubleshooting for common issues
- ✅ Best practices and patterns
- ✅ Configuration reference
- ✅ Real-world examples

## Quick Start

### 1. Get Your Workspace

```bash
WORKSPACE=$(openclaw config get agents.defaults.workspace)
cd $WORKSPACE
```

### 2. Create a Project

```bash
# Create and navigate
cd $WORKSPACE
mkdir my-project
cd my-project

# Initialize with Spec-Kit (recommended)
specify init . --ai claude --force

# Start developing
claude -p "Create a landing page with HTML and CSS"
```

### 3. Development Workflow

```bash
# Plan with Spec-Kit
claude -p "Use /speckit.constitution to create project principles"
claude -p "Use /speckit.specify to define requirements"
claude -p "Use /speckit.plan to create implementation plan"
claude -p "Use /speckit.tasks to generate task breakdown"

# Implement
claude -p "Implement Task 1: HTML structure"
claude -p "Implement Task 2: CSS styling"
claude -p "Implement Task 3: JavaScript logic"
```

## Key Features

### Correct Usage Format

```bash
# ✅ CORRECT
claude -p "Your task"
claude -p "Your task" --pty
claude -p "Your task" workdir:~/project

# ❌ INCORRECT
bash pty:true command:"claude -p 'Task'"  # Wrong syntax!
```

### Complete Documentation

See **[SKILL.md](./SKILL.md)** for:
- Detailed workflow guide
- All parameters and options
- Troubleshooting common issues
- Advanced configurations
- Real-world examples

### What You'll Learn

1. **Setup & Configuration**
   - Workspace directory rules
   - Environment variables
   - Permission settings

2. **Spec-Kit Integration**
   - Structured development workflow
   - From planning to implementation
   - Quality checkpoints

3. **Best Practices**
   - Breaking down complex tasks
   - Using read-only queries
   - Verifying generated code

4. **Troubleshooting**
   - Claude Code not responding
   - Permission denied errors
   - Timeout issues
   - Wrong model usage

## Documentation Structure

| Document | Purpose |
|----------|---------|
| **SKILL.md** | Complete guide (start here) |
| **examples/QUICK_REFERENCE.md** | Command quick reference |
| **examples/USAGE.sh** | Executable examples |

## Examples

### Web Development

```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir website
cd website

claude -p "Create a responsive landing page"
claude -p "Add CSS animations"
claude -p "Create contact form with validation"
```

### API Development

```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir api
cd api

claude -p "Design REST API for user management"
claude -p "Implement endpoints with Node.js"
claude -p "Add unit tests"
```

### Code Review

```bash
cd my-project
claude -p "Review recent changes"
claude -p "Check for security issues"
claude -p "Suggest performance improvements"
```

## Troubleshooting

### Common Issues

**Claude Code Not Responding**
```bash
# Check configuration
cat ~/.claude/settings.json

# Set environment variable
openclaw config set env.ANTHROPIC_MODEL "MiniMax-M2.1"
openclaw gateway restart
```

**Permission Denied**
```bash
# Add to allowlist
openclaw approvals allowlist add "/Users/yourname/.local/bin/claude"
```

**Files in Wrong Location**
```bash
# Always get workspace dynamically
cd $(openclaw config get agents.defaults.workspace)
```

See **[SKILL.md](./SKILL.md)** for complete troubleshooting guide.

## Resources

- 📖 **[SKILL.md](./SKILL.md)** - Complete documentation
- 📝 **[examples/QUICK_REFERENCE.md](./examples/QUICK_REFERENCE.md)** - Command reference
- 💻 **[examples/USAGE.sh](./examples/USAGE.sh)** - Executable examples
- 🔗 [Claude Code Docs](https://code.claude.com/docs)
- 🔗 [Spec-Kit](https://github.com/github/spec-kit)
- 🔗 [OpenClaw Docs](https://docs.openclaw.ai)

## Version

- **Current:** 2.0.0
- **Last Updated:** 2026-02-06
- **Compatible with:** OpenClaw 2026.2.2+

---

**💡 Tip:** Start with SKILL.md for the complete guide, then use QUICK_REFERENCE.md for fast lookups during development.
