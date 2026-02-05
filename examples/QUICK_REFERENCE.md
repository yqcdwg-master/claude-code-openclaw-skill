# Claude Code 快速调用示例

> 这些示例可以直接复制到 OpenClaw 中使用

## 基础查询

```bash
# 解释代码库结构
bash pty:true workdir:~/project command:"claude -p 'What does this project do?'"

# 查找主入口文件
bash pty:true workdir:~/project command:"claude -p 'Where is the main entry point?'"

# 解释技术栈
bash pty:true workdir:~/project command:"claude -p 'What technologies are used in this project?'"
```

## 代码生成

```bash
# 添加新功能
bash pty:true workdir:~/project command:"claude -p 'Add a user registration endpoint to the API'"

# 创建新文件
bash pty:true workdir:~/project command:"claude -p 'Create a new component called Button in src/components/'"

# 实现算法
bash pty:true workdir:~/project command:"claude -p 'Implement a binary search algorithm in src/algorithms.ts'"
```

## Bug 修复

```bash
# 描述 bug 并修复
bash pty:true workdir:~/project command:"claude -p 'Fix the bug: clicking the submit button does nothing'"

# 修复错误
bash pty:true workdir:~/project command:"claude -p 'Fix the TypeError: Cannot read property of undefined'"

# 性能优化
bash pty:true workdir:~/project command:"claude -p 'Optimize this slow database query'"
```

## 代码审查

```bash
# 审查更改
bash pty:true workdir:~/project command:"claude -p 'Review my recent changes for security issues'"

# 代码质量检查
bash pty:true workdir:~/project command:"claude -p 'Check this code for best practices and suggest improvements'"

# 查找潜在问题
bash pty:true workdir:~/project command:"claude -p 'Find potential bugs or issues in src/auth.ts'"
```

## 重构与优化

```bash
# 代码重构
bash pty:true workdir:~/project command:"claude -p 'Refactor this function to be more readable'"

# 清理代码
bash pty:true workdir:~/project command:"claude -p 'Remove dead code and unused imports'"

# 添加测试
bash pty:true workdir:~/project command:"claude -p 'Write unit tests for the payment module'"
```

## Git 操作

```bash
# 创建特性分支
bash pty:true workdir:~/project command:"claude -p 'Create a new branch called feature/user-profile'"

# 创建提交
bash pty:true workdir:~/project command:"claude commit"

# 查看更改
bash pty:true workdir:~/project command:"claude -p 'What files have been changed?'"
```

## 文档

```bash
# 生成文档
bash pty:true workdir:~/project command:"claude -p 'Generate API documentation for all endpoints'"

# 更新 README
bash pty:true workdir:~/project command:"claude -p 'Update the README with installation instructions'"

# 添加代码注释
bash pty:true workdir:~/project command:"claude -p 'Add JSDoc comments to all exported functions'"
```

## 高级用法

### JSON 输出解析

```bash
# 获取结构化数据
bash pty:true workdir:~/project command:"claude -p --output-format json 'List all exported functions with their signatures'" | jq '.functions'
```

### 自定义提示词

```bash
# 使用特定角色
bash pty:true command:"claude --system-prompt 'You are a senior Python developer specializing in Django. Always use type hints and follow PEP 8.' -p 'Create a new Django model'"

# 添加额外规则
bash pty:true workdir:~/project command:"claude --append-system-prompt 'Always use arrow functions in JavaScript' -p 'Create a new utility module'"
```

### 限制与控制

```bash
# 预算限制
bash pty:true command:"claude -p --max-budget-usd 1.00 'Your task'"

# 回合限制
bash pty:true command:"claude -p --max-turns 5 'Your task'"

# 只读模式
bash pty:true workdir:~/project command:"claude --permission-mode plan -p 'Review my code'"
```

## 批量操作

### 多个查询并行

```bash
# 并行运行多个 Claude Code 实例
bash pty:true workdir:~/project background:true command:"claude -p 'Fix all ESLint errors'"
bash pty:true workdir:~/project background:true command:"claude -p 'Add type annotations'"
bash pty:true workdir:~/project background:true command:"claude -p 'Update dependencies'"

# 查看进度
process action:list
```

### 顺序执行

```bash
# 步骤 1: 分析
bash pty:true workdir:~/project command:"claude -p 'Analyze the codebase and identify files that need updates'"

# 步骤 2: 更新
bash pty:true workdir:~/project command:"claude -p 'Apply the updates identified in the previous step'"

# 步骤 3: 验证
bash pty:true workdir:~/project command:"claude -p 'Run tests and verify the changes work correctly'"
```

## 常见问题排查

### 权限问题

```bash
# 跳过权限检查（谨慎使用）
bash pty:true command:"claude -p --dangerously-skip-permissions 'Your task'"

# 或使用计划模式
bash pty:true command:"claude --permission-mode plan -p 'Your task'"
```

### 登录问题

```bash
# 确保已登录
claude

# 或重新登录
claude /login
```

### 输出问题

```bash
# 详细模式（调试用）
bash pty:true command:"claude -p --verbose 'Your task'"

# JSON 格式（便于解析）
bash pty:true command:"claude -p --output-format json 'Your task'"
```

## 与其他工具集成

### GitHub Actions

```bash
# 在 CI 中运行 Claude Code
bash pty:true command:"claude -p --permission-mode plan 'Review the changes in this PR'"
```

### 代码审查流水线

```bash
# 1. 获取 PR 差异
bash pty:true command:"gh pr diff <PR#> | claude -p 'Review these changes'"

# 2. 添加评论
bash pty:true command:"gh pr comment <PR#> --body \"$(claude -p --output-format json 'Summarize your review' | jq -r '.summary)')\""
```

## 模板：标准问题修复流程

```bash
#!/usr/bin/env bash
# 用法: ./fix-bug.sh "Bug description"

set -e

TASK="$1"
PROJECT_DIR="~/project"

echo "🔍 分析问题..."
bash pty:true workdir:$PROJECT_DIR command:"claude -p 'Investigate: $TASK. Find the root cause and explain what needs to be fixed.'"

echo "🔧 应用修复..."
bash pty:true workdir:$PROJECT_DIR command:"claude -p 'Fix the issue: $TASK. Make the necessary code changes.'"

echo "✅ 验证修复..."
bash pty:true workdir:$PROJECT_DIR command:"claude -p 'Verify the fix: $TASK. Run tests and confirm it works.'"

echo "✨ 完成！"
```

## 模板：代码审查流程

```bash
#!/usr/bin/env bash
# 用法: ./review-pr.sh <PR_number>

set -e

PR_NUM="$1"

echo "📋 检出 PR #$PR_NUM..."
gh pr checkout $PR_NUM

echo "🔍 开始代码审查..."
bash pty:true workdir:. command:"claude -p 'Review the changes in this PR. Check for:
1. Security issues
2. Performance concerns
3. Code quality and best practices
4. Potential bugs
5. Test coverage

Provide a detailed review summary.'"

echo "✨ 审查完成！"
```

## 使用提示

1. **保持任务单一**：每次调用只做一件事，便于追踪和理解
2. **使用工作目录**：始终指定 `workdir` 避免 Claude Code 访问无关文件
3. **设置限制**：对于敏感操作，使用 `--permission-mode plan` 先预览
4. **JSON 输出**：需要解析结果时使用 `--output-format json`
5. **记录结果**：重要输出重定向到文件保存
