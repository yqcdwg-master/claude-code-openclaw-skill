# Claude Code OpenClaw Skill

🤖 **Comprehensive guide for invoking Claude Code programmatically with OpenClaw**

A skill that provides complete documentation and best practices for using Claude Code with OpenSpec, including workflow integration, troubleshooting, and development patterns.

## What This Skill Provides

- ✅ Complete workflow guide for Claude Code + OpenSpec
- ✅ Correct usage formats and examples
- ✅ **NEW: OpenSpec + Claude Code Development Tips** (2026-02-08)
- ✅ Known Issues and Solutions
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

### 2. Create OpenSpec Project

```bash
# Create project directory
cd $WORKSPACE
mkdir my-project
cd my-project

# Initialize OpenSpec change
mkdir -p openspec/changes/my-feature
cd openspec/changes/my-feature

# Create documentation
cat > README.md << 'EOF'
# my-feature

## Overview
Brief description of the feature.

## Features
- Feature 1
- Feature 2

## Requirements
- P0: Critical requirement
- P1: Important requirement
- P2: Nice to have
EOF

# Create tasks
cat > tasks.md << 'EOF'
# Tasks - my-feature

## Task Breakdown

### Task 1: Implementation
**Duration**: 4h
**Status**: Pending

| Subtask | Description |
|---------|-------------|
| T-1.1 | Subtask 1 |

**Output**: `filename`
EOF
```

### 3. Execute with Claude Code

```bash
# Correct format
cd /path/to/project
claude -p "Implement Task 1 based on openspec/changes/my-feature/tasks.md. Output to: /path/to/file.py"

# Verify output
tail -20 /path/to/file.py
```

---

## 📚 OpenSpec + Claude Code Development Tips

### 1. OpenSpec Project Structure

```
project/
├── openspec/
│   ├── changes/
│   │   └── feature-name/
│   │       ├── README.md              # Overview
│   │       ├── .openspec.yaml         # Config
│   │       ├── design.md              # Architecture
│   │       ├── tasks.md               # Task breakdown
│   │       └── specs/
│   │           ├── requirements.md    # P0/P1/P2
│   │           └── scenarios.md       # User stories
│   └── config.yaml                   # Global config
├── backend/                          # Implementation
├── frontend/
└── scripts/
```

### 2. Claude Code Command Format

```bash
# ✅ CORRECT
claude -p "Task description with context"
claude -p "Task description" --pty
claude -p "Task" workdir:/path/to/project

# ❌ INCORRECT
bash pty:true command:"claude -p 'Task'"  # Wrong!
```

### 3. Effective Prompt Template

```bash
claude -p "
Implement [FEATURE] for [PROJECT].

Project path: /path/to/project
Python venv: /path/to/.venv
Existing file: /path/to/file.py

Task: [Specific task description]

Requirements:
1. [Requirement 1]
2. [Requirement 2]

Output: /path/to/output/file.py

After implementation, run:
cd /path/to/project
python -c 'from module import function; print(\"OK\")'
"
```

### 4. Task Execution Strategy

**Phase-based Development**:
```bash
# Phase 1: Documentation
openspec new change "feature-name"
# Create README, design.md, tasks.md, requirements.md

# Phase 2: Implementation (one task at a time)
claude -p "Implement Task 1. Output to: path/file1.py"
claude -p "Implement Task 2. Output to: path/file2.py"

# Phase 3: Testing & Verification
pytest tests/ -v
git add . && git commit -m "feat: complete feature"
```

**Handle Claude Code Instability**:
```bash
# If Claude Code fails (SIGKILL), implement manually:
cat > /path/to/file.py << 'EOF'
# Your implementation
EOF

# Verify
python -c "import file; print('OK')"
```

### 5. OpenSpec Document Templates

#### README.md
```markdown
# feature-name

## Overview
Brief description

## Features Implemented
- ✅ Feature 1
- ✅ Feature 2

## Technical Details
- Tech stack, architecture

## Usage
```bash
# Command examples
```

## Files Created
| File | Description |
|------|-------------|
| file.py | Implementation |
```

#### requirements.md
```markdown
# Requirements - feature-name

## Priority Matrix

### Must Have (P0)
1. **RQ-001**: Critical feature
   - Description: ...
   - Priority: P0
   - Effort: 4h

### Should Have (P1)
### Nice to Have (P2)
```

#### tasks.md
```markdown
# Tasks - feature-name

## Task Breakdown

### Task 1: Name
**Duration**: 4h
**Status**: ✅ Completed

| Subtask | Description | Hours |
|---------|-------------|-------|
| T-1.1 | Subtask 1 | 1h |

**Output**: `filename.py`
```

### 6. Git Integration Workflow

```bash
# Complete a phase
git add changed/files
git commit -m "feat: complete [feature-name]

- Task 1: description
- Task 2: description"

git push origin main

# Archive completed change
mv openspec/changes/feature-name openspec/changes/archive/
```

### 7. Progress Tracking Script

```bash
# scripts/progress-tracker.sh
#!/bin/bash
echo "📊 Project Progress"
echo "✅ Completed:"
ls openspec/changes/archive/ | wc -l
echo "⏳ In Progress:"
ls openspec/changes/*/tasks.md 2>/dev/null | wc -l
```

---

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

### Documentation Structure

| Document | Purpose |
|----------|---------|
| **SKILL.md** | Complete guide (start here) |
| **README.md** | Project overview |
| **tasks.md** | Task breakdown |
| **specs/requirements.md** | P0/P1/P2 priorities |

## Examples

### Web Development

```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir website
cd website

# Create OpenSpec structure
mkdir -p openspec/changes/web-frontend
cat > openspec/changes/web-frontend/README.md << 'EOF'
# Web Frontend

## Features
- Responsive layout
- Component library
EOF

# Implement with Claude Code
claude -p "Create index.html with responsive layout. Output to: /path/to/index.html"
claude -p "Create styles.css with component styles. Output to: /path/to/styles.css"
```

### API Development

```bash
cd $(openclaw config get agents.defaults.workspace)
mkdir api
cd api

# Create OpenSpec change
openspec new change "user-api"

# Implement
claude -p "Create FastAPI endpoints for user CRUD. Output to: /path/to/api/routes/users.py"
```

### Multi-Phase Project

```bash
# Phase 1: Documentation
openspec new change "ai-feature"
# Create all documentation files

# Phase 2: Implementation (iterative)
claude -p "Implement Phase 1: Data model"
claude -p "Implement Phase 2: API endpoints"
claude -p "Implement Phase 3: Frontend components"

# Phase 3: Testing & Docker
claude -p "Write unit tests for all modules"
claude -p "Create Dockerfile and docker-compose.yml"
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

**Claude Code SIGKILL**
```bash
# Manual implementation fallback
cat > /path/to/file.py << 'EOF'
# Manual implementation
EOF

# Verify
python -c "import file; print('OK')"
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.5.0 | 2026-02-08 | ✅ Added OpenSpec + Claude Code Tips |
| 2.4.0 | 2026-02-06 | Added OpenSpec Usage Tips |
| 2.3.0 | 2026-02-06 | Added Known Issues section |
| 2.2.0 | 2026-02-06 | Added Spec-Kit workflow |
| 2.1.0 | 2026-02-06 | Initial release |

---

## Resources

- 📖 **SKILL.md** - Complete documentation
- 📝 **[examples/QUICK_REFERENCE.md](./examples/QUICK_REFERENCE.md)** - Command reference
- 💻 **[examples/USAGE.sh](./examples/USAGE.sh)** - Executable examples
- 🔗 [OpenClaw Docs](https://docs.openclaw.ai)
- 🔗 [Claude Code Docs](https://code.claude.com/docs)
- 🔗 [OpenSpec](https://github.com/Fission-AI/OpenSpec)
- 🔗 [GitHub CLI Manual](https://cli.github.com/manual/gh)

---

**💡 Tip:** Start with SKILL.md for the complete guide, then use QUICK_REFERENCE.md for fast lookups during development.
