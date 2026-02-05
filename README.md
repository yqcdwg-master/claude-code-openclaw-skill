# Claude Code OpenClaw Skill

## 安装

```bash
# 确保 Claude Code 已安装
claude --version

# 首次使用需要登录
claude
```

## 基础使用

```bash
# 快速查询（最常用⭐）
bash pty:true command:"claude -p 'Your task here'"

# 指定项目目录
bash pty:true workdir:~/your-project command:"claude -p 'Explain this codebase'"
```

## 常用命令速查

| 场景 | 命令 |
|------|------|
| 解释代码 | `claude -p 'Explain this function'` |
| 添加功能 | `claude -p 'Add a login feature'` |
| 修复 bug | `claude -p 'Fix the crash on line 42'` |
| 代码审查 | `claude -p 'Review my changes'` |
| 编写测试 | `claude -p 'Write unit tests'` |
| 重构代码 | `claude -p 'Refactor to use async/await'` |
| 创建提交 | `claude commit` |
| 查看更改 | `claude -p 'What changed?'` |

## 进阶用法

```bash
# JSON 输出（适合解析）
claude -p --output-format json 'List all functions' | jq

# 自定义模型
claude --model claude-sonnet-4 -p 'Your task'

# 自定义提示词
claude --system-prompt 'You are a Python expert' -p 'Create an API'

# 限制预算
claude -p --max-budget-usd 2.00 'Your task'

# 只读模式（预览）
claude --permission-mode plan -p 'Your task'
```

## 文档

- **完整文档**: [SKILL.md](./SKILL.md)
- **快速参考**: [examples/QUICK_REFERENCE.md](./examples/QUICK_REFERENCE.md)
- **官方文档**: https://code.claude.com/docs
