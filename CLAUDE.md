# 路径兼容说明

本仓库当前统一使用 `.agents/skills/` 作为技能目录标准路径。

- 标准路径：`.agents/skills/<skill-name>/`
- 历史路径：`.claude/skills/`
- 历史路径：`.Codex/skills/`

`CLAUDE.md` 保留仅用于兼容旧入口和历史引用，不再作为主维护文档。

请优先阅读以下文件：

- `AGENTS.md`：当前主开发指南
- `.agents/skills/`：当前技能目录

如果你在旧文档、脚本或对话里看到 `.claude/skills` 或 `.Codex/skills`，请统一替换理解为 `.agents/skills`。
