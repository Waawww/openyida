---
name: yida-import-app
description: 导入并接管宜搭上已存在的应用。默认会弹出浏览器，让用户从“我的应用”列表中选择要导入的应用；选定后自动读取真实应用列表、页面导航和 Schema，在本地生成 PRD 文档和 schema 缓存，供后续 AI 分析、字段修改、自定义页面开发和发布使用。
---

# yida-import-app

使用这个技能把线上已有的宜搭应用接入当前工作台。默认链路是：

1. 弹出浏览器
2. 让用户选择宜搭应用
3. 根据选择结果自动导入

## 推荐命令

```bash
node .agents/skills/yida-import-app/scripts/import-app.js
```

不传 `appType` 时，脚本会自动进入“浏览器选应用”模式。

## 其他命令

```bash
node .agents/skills/yida-import-app/scripts/import-app.js <appType> [--output-name 输出名] [--force]
node .agents/skills/yida-import-app/scripts/import-app.js --select-app [--output-name 输出名] [--force]
node .agents/skills/yida-import-app/scripts/import-app.js <appType> [--manifest 文件路径] [--output-name 输出名] [--force]
```

## 执行顺序

1. 运行 `scripts/import-app.js`
2. 若未传 `appType`，浏览器会打开应用选择器
3. 用户点击一个应用卡片
4. 脚本自动进入该应用后台，读取真实页面导航
5. 脚本拉取各页面 Schema，并生成本地产物

## 输出

- `prd/<app>.md`
- `.cache/<app>-schema.json`

## 真实导入链路

当前版本优先通过浏览器态访问真实页面和接口：

- 在“我的应用”页调用真实应用列表接口，拿到可选应用
- 在应用后台页调用真实导航接口，拿到页面清单
- 再通过 HTTP 拉取每个页面的 `getFormSchema`

## manifest 何时需要

只有在自动发现页面不完整，或者你已经明确知道需要导入的页面清单时，才使用 `manifest` 兜底。

manifest 示例：

```json
{
  "appName": "薪资计算器",
  "pages": [
    {
      "name": "首页",
      "type": "custom",
      "formUuid": "FORM-AAA"
    },
    {
      "name": "薪资参数表",
      "type": "form",
      "formUuid": "FORM-BBB"
    }
  ]
}
```

## 接入后的建议动作

1. 用 `yida-analyze-app` 生成结构分析报告
2. 根据分析结果调整 PRD
3. 用现有 `yida-custom-page` / `yida-create-form-page` 继续迭代
4. 用 `yida-sync-app` 定期刷新线上变更

## 读取哪些文件

- 必读：`scripts/import-app.js`
- 浏览器选应用与真实发现：`scripts/discover-live.py`
- 需要理解缓存结构时：`references/app-model.md`
