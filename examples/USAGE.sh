#!/usr/bin/env bash
# Claude Code OpenClaw Skill - 常用示例

# ⭐ 最基础用法 - 快速查询
bash pty:true command:"claude -p 'What does this project do?'"

# 指定工作目录
bash pty:true workdir:~/myproject command:"claude -p 'Explain the authentication flow'"

# 代码生成
bash pty:true workdir:~/myproject command:"claude -p 'Add a hello world function'"

# Bug 修复
bash pty:true workdir:~/myproject command:"claude -p 'Fix the bug where the button does nothing'"

# JSON 输出（适合解析）
bash pty:true command:"claude -p --output-format json 'List all exported functions' | jq"

# 只读模式（预览，不修改）
bash pty:true workdir:~/myproject command:"claude --permission-mode plan -p 'Review my changes'"

# 限制预算
bash pty:true command:"claude -p --max-budget-usd 1.00 'Your task'"

# 自定义提示词
bash pty:true command:"claude --system-prompt 'You are a Rust expert' -p 'Create a new module'"

# 追加规则
bash pty:true workdir:~/myproject command:"claude --append-system-prompt 'Always use TypeScript' -p 'Create a new component'"

# Git 操作
bash pty:true workdir:~/myproject command:"claude commit"
bash pty:true workdir:~/myproject command:"claude -p 'Create a new branch called feature/x'"

# 长时间任务（后台运行）
bash pty:true workdir:~/myproject background:true command:"claude -p 'Refactor the entire auth module'"

# 继续之前的对话
bash pty:true workdir:~/myproject command:"claude --continue"
bash pty:true workdir:~/myproject command:"claude -c -p 'Continue from where we left off'"
