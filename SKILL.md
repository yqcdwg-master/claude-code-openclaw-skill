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

确保已安装 Claude Code CLI：

```bash
# macOS/Linux/WSL
curl -fsSL https://claude.ai/install.sh | bash

# 或使用 Homebrew
brew install --cask claude-code
```

首次使用需要登录：`claude`

## 使用模式

### 1. 交互模式 (Interactive Mode)

需要用户交互时使用，开启一个完整的 Claude Code 会话：

```bash
bash pty:true workdir:~/project command:"claude"
```

### 2. 打印模式 (Print Mode) ⭐ 推荐

单次查询模式，执行后自动退出，适合程序化调用：

```bash
# 基本用法
bash pty:true command:"claude -p 'Your task here'"

# 指定工作目录
bash pty:true workdir:~/project command:"claude -p 'Explain the authentication flow'"

# JSON 输出（适合解析结果）
bash pty:true command:"claude -p --output-format json 'List all functions in main.py'"

# 流式 JSON 输出
bash pty:true command:"claude -p --output-format stream-json --include-partial-messages 'Analyze this codebase'"
```

### 3. 继续对话 (Continue Session)

继续最近的工作：

```bash
bash pty:true workdir:~/project command:"claude --continue"
bash pty:true workdir:~/project command:"claude -c -p 'Continue from where we left off'"
```

### 4. 恢复指定会话

```bash
# 按名称恢复
bash pty:true command:"claude -r 'auth-refactor' 'Finish implementing the auth flow'"

# 按 ID 恢复
bash pty:true command:"claude --session-id '550e8400-e29b-41d4-a716-446655440000' 'Continue working'"
```

## 常用参数组合

### 代码分析与解释

```bash
# 分析代码库结构
bash pty:true workdir:~/project command:"claude -p 'What technologies does this project use?'"

# 解释特定函数
bash pty:true workdir:~/project command:"claude -p 'Explain the main() function in src/main.py'"

# 解释文件夹结构
bash pty:true workdir:~/project command:"claude -p 'Explain the folder structure of this project'"
```

### 代码生成与编辑

```bash
# 添加功能
bash pty:true workdir:~/project command:"claude -p 'Add a hello world function to src/utils.rs'"

# 重构代码
bash pty:true workdir:~/project command:"claude -p --append-system-prompt 'Always use async/await' 'Refactor the auth module to use async/await'"

# 修复 bug
bash pty:true workdir:~/project command:"claude -p 'Fix the bug where users can submit empty forms'"
```

### Git 操作

```bash
# 查看更改
bash pty:true workdir:~/project command:"claude -p 'What files have I changed?'"

# 创建提交
bash pty:true workdir:~/project command:"claude commit"

# 创建分支
bash pty:true workdir:~/project command:"claude -p 'Create a new branch called feature/user-authentication'"

# 帮助解决合并冲突
bash pty:true workdir:~/project command:"claude -p 'Help me resolve merge conflicts'"
```

### 代码审查

```bash
# 审查更改
bash pty:true workdir:~/project command:"claude -p 'Review my changes and suggest improvements'"

# 编写测试
bash pty:true workdir:~/project command:"claude -p 'Write unit tests for the calculator functions in src/calc.rs'"
```

## 高级用法

### 自定义模型

```bash
# 使用特定模型
bash pty:true workdir:~/project command:"claude --model claude-sonnet-4-5-20250929 -p 'Your task'"

# 备用模型（当默认模型过载时）
bash pty:true command:"claude -p --fallback-model sonnet 'Your task'"
```

### 自定义系统提示词

```bash
# 完全替换系统提示词
bash pty:true command:"claude --system-prompt 'You are a Python expert who only writes type-annotated code' -p 'Create a new API endpoint'"

# 从文件加载系统提示词
bash pty:true command:"claude -p --system-prompt-file ./prompts/python-expert.txt 'Build a Django model'"

# 追加系统提示词
bash pty:true command:"claude --append-system-prompt 'Always use TypeScript and include JSDoc comments' -p 'Create a new component'"
```

### 工具限制

```bash
# 只允许特定工具
bash pty:true command:"claude --tools 'Read,Edit,Bash' -p 'Add error handling'"

# 禁用所有工具
bash pty:true command:"claude --tools '' -p 'Explain this code'"

# 使用默认工具集
bash pty:true command:"claude --tools default -p 'Your task'"
```

### 预算与限制

```bash
# 最大消费限制
bash pty:true command:"claude -p --max-budget-usd 5.00 'Your task'"

# 最大回合数限制
bash pty:true command:"claude -p --max-turns 3 'Your task'"

# 禁用会话持久化
bash pty:true command:"claude -p --no-session-persistence 'Your task'"
```

### 权限模式

```bash
# 计划模式（只查看，不修改）
bash pty:true command:"claude --permission-mode plan -p 'Review my code'"

# 允许跳过权限检查（谨慎使用）
bash pty:true command:"claude --permission-mode plan --allow-dangerously-skip-permissions -p 'Your task'"
```

## 管道与重定向

### 处理管道输入

```bash
# 从文件读取并分析
bash pty:true command:"claude -p 'Analyze this error' < error.log"

# 处理管道内容
bash pty:true command:"cat logs.txt | claude -p 'Explain these errors'"
```

### 输出重定向

```bash
# 保存到文件
bash pty:true command:"claude -p --output-format json 'List all imports' > imports.json"

# 保存详细日志
bash pty:true command:"claude -p --verbose 'Your task' > output.log 2>&1"
```

## 最佳实践

### 1. 总是使用 PTY

Claude Code 是交互式终端应用，**必须**使用 `pty:true`：

```bash
# ✅ 正确
bash pty:true command:"claude -p 'Your task'"

# ❌ 错误（可能损坏输出或导致挂起）
bash command:"claude -p 'Your task'"
```

### 2. 工作目录隔离

使用 `workdir` 限制 Claude Code 的访问范围：

```bash
# 在特定项目目录中运行
bash pty:true workdir:~/Projects/myapp command:"claude -p 'Fix the login bug'"

# 永远不要在 ~/clawd/ 或 OpenClaw 项目目录中运行！
```

### 3. 选择合适的模式

- **Print mode (`-p`)**：单次查询，程序化调用
- **Interactive**：需要多轮对话时
- **Background + PTY**：长时间任务

### 4. JSON 输出用于解析

当需要解析 Claude Code 的输出时，使用 JSON 格式：

```bash
bash pty:true command:"claude -p --output-format json 'What is the main function?'" | jq -r '.result'
```

### 5. 设置合理的限制

```bash
# 限制预算
bash pty:true command:"claude -p --max-budget-usd 2.00 'Your task'"

# 限制回合数
bash pty:true command:"claude -p --max-turns 5 'Your task'"
```

## 常见用例

### 代码审查助手

```bash
# 启动审查会话
bash pty:true workdir:~/project background:true command:"claude -p 'Review all changes since last commit. Focus on security and performance issues.'"

# 检查进度
process action:log sessionId:XXX
```

### 自动化 Bug 修复

```bash
# 查找并修复 bug
bash pty:true workdir:~/project command:"claude -p 'Find and fix the memory leak in src/memory.rs'"

# 使用 Claude Code 的自动批准模式
bash pty:true workdir:~/project command:"claude -p --permission-mode auto 'Fix all lint errors'"
```

### 文档生成

```bash
# 生成 README
bash pty:true workdir:~/project command:"claude -p 'Generate a comprehensive README.md with installation, usage, and API documentation'"

# 生成 API 文档
bash pty:true workdir:~/project command:"claude -p --output-format json 'Document all public functions in src/api/' | jq '.functions[] | {name, params, description}'"
```

### 迁移与重构

```bash
# 代码迁移
bash pty:true workdir:~/project command:"claude -p 'Migrate from callbacks to async/await in src/handlers/'"

# 大规模重构
bash pty:true workdir:~/project command:"claude -p --max-turns 10 'Refactor the entire auth module to use JWT tokens'"
```

## MCP 服务器集成

### 加载 MCP 配置

```bash
# 从 JSON 文件加载 MCP 服务器
bash pty:true command:"claude --mcp-config ./mcp.json -p 'Your task'"

# 严格模式（只使用指定配置）
bash pty:true command:"claude --strict-mcp-config --mcp-config ./mcp.json -p 'Your task'"
```

### 常见 MCP 用途

- **GitHub**：PR 创建、Issue 管理
- **Google Drive**：读取设计文档
- **Figma**：查看设计稿
- **Jira**：更新工单

## 输出格式详解

### Text 格式（默认）

```bash
claude -p 'Explain this code'
# 输出纯文本描述
```

### JSON 格式

```bash
claude -p --output-format json 'Your query'
# 输出结构化 JSON，便于程序解析
```

### Stream JSON 格式

```bash
claude -p --output-format stream-json --include-partial-messages 'Your query'
# 流式输出 JSON 事件，适合实时显示进度
```

## 与 OpenClaw 集成

### 通知完成

长时间任务完成后，让 Claude Code 通知 OpenClaw：

```bash
bash pty:true workdir:~/project background:true command:"claude -p 'Build the REST API.

When completely finished, run: openclaw gateway wake --text \"Done: Built REST API with CRUD endpoints\" --mode now'"
```

### 错误处理

```bash
# 设置超时
bash pty:true command:"claude -p 'Your task'" timeout:60

# 检查退出码
bash pty:true command:"claude -p 'Your task'" && echo "Success" || echo "Failed"
```

## 注意事项

1. **首次使用需要登录**：运行 `claude` 并按提示完成认证
2. **工作目录敏感**：Claude Code 会读取目录中的所有文件
3. **权限提示**：首次使用某些功能会请求权限
4. **API 配额**：使用 Claude API 的用户会有配额限制
5. **成本控制**：建议设置 `--max-budget-usd` 避免意外支出

## 相关资源

- [Claude Code 官方文档](https://code.claude.com/docs)
- [CLI 参考](https://code.claude.com/docs/en/cli-reference)
- [快速开始指南](https://code.claude.com/docs/en/quickstart)
- [Subagents 文档](https://code.claude.com/docs/en/sub-agents)
- [MCP 服务器](https://code.claude.com/docs/en/mcp)
