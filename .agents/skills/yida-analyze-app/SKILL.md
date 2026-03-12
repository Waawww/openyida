---
name: yida-analyze-app
description: 分析已经导入到本地工作台的宜搭存量应用。默认会弹出浏览器，让用户从“我的应用”列表中选择要分析的应用；选定后读取本地 `.cache/<app>-schema.json` 和对应 PRD，输出页面结构、字段统计、风险与改造建议，帮助后续 AI 开发快速建立上下文。
---

# yida-analyze-app

在存量应用已经通过 `yida-import-app` 接入后，使用这个技能生成分析报告。默认链路是：

1. 弹出浏览器
2. 让用户选择宜搭应用
3. 根据选择结果读取本地 cache 并生成分析

## 推荐命令

```bash
node .agents/skills/yida-analyze-app/scripts/analyze-app.js --write-prd-report
```

不传 `appType` 时，脚本会自动进入“浏览器选应用”模式。

## 其他命令

```bash
node .agents/skills/yida-analyze-app/scripts/analyze-app.js <appType> [--report-name 输出名] [--write-prd-report]
node .agents/skills/yida-analyze-app/scripts/analyze-app.js --select-app [--report-name 输出名] [--write-prd-report]
```

## 输出

- 默认输出 JSON 分析结果到 stdout
- 传入 `--write-prd-report` 时，额外生成 `prd/<app>-analysis.md`

## 分析内容

- 页面数量与类型分布
- 字段总数、字段类型分布、必填字段数量
- 潜在结构风险
- 自定义页面与表单页面覆盖情况
- 后续适合使用的开发技能建议

## 前提

- 目标应用必须已经通过 `yida-import-app` 导入
- 本地需要存在对应的 `.cache/<app>-schema.json`

## 说明

浏览器选择阶段只用于确定分析目标；真正的分析仍然基于本地已导入的 cache，而不是直接从线上读取 Schema。
