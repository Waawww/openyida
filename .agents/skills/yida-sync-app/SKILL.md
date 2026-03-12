---
name: yida-sync-app
description: 同步已经接入到本地工作台的宜搭存量应用。默认会弹出浏览器，让用户从“我的应用”列表中选择要同步的应用；选定后重新拉取线上页面导航和 Schema，与本地 `.cache/<app>-schema.json` 对比，生成页面与字段差异，并覆盖更新本地 PRD 与 cache。
---

# yida-sync-app

使用这个技能刷新存量应用的本地镜像，并输出差异报告。默认链路是：

1. 弹出浏览器
2. 让用户选择宜搭应用
3. 根据选择结果重新同步线上结构

## 推荐命令

```bash
node .agents/skills/yida-sync-app/scripts/sync-app.js
```

不传 `appType` 时，脚本会自动进入“浏览器选应用”模式。

## 其他命令

```bash
node .agents/skills/yida-sync-app/scripts/sync-app.js <appType> [--output-name 输出名]
node .agents/skills/yida-sync-app/scripts/sync-app.js --select-app [--output-name 输出名]
node .agents/skills/yida-sync-app/scripts/sync-app.js <appType> [--manifest 文件路径] [--output-name 输出名]
```

## 输出

- 覆盖更新 `prd/<app>.md`
- 覆盖更新 `.cache/<app>-schema.json`
- 生成 `prd/<app>-sync.md`

## 同步前提

- 目标应用必须已经通过 `yida-import-app` 导入过
- 本地需要存在对应的 `.cache/<app>-schema.json`

## 真实同步链路

当前版本会复用 `yida-import-app` 的真实发现链路：

- 在“我的应用”页获取可选应用
- 在应用后台页获取真实页面导航
- 拉取每个页面最新 Schema
- 对比本地旧 cache 和新结果，输出差异报告

## 适用场景

- 线上应用已被人工改过
- 多人同时维护同一个宜搭应用
- 本地 PRD 与线上结构疑似脱节
