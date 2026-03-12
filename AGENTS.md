# 宜搭 AI 应用开发指南

本项目通过 AI Coding 工具（Codex / OpenCode 等）+ 宜搭低代码平台，实现从需求分析、应用创建、存量应用导入到页面发布的完整开发链路。

---

## 路径约定

从现在开始，项目内所有技能路径统一以 `.agents/skills/` 为准。

- 标准路径：`.agents/skills/<skill-name>/`
- 历史命名：`.claude/skills/`、`.Codex/skills/`
- 兼容策略：旧路径只视为历史文档或旧环境残留，不再作为新的命令示例和说明依据

如果后续新增技能、补文档或编写自动化脚本，请统一使用 `.agents/skills`。

---

## 项目结构

```text
项目根目录/
├── AGENTS.md                    # 本文档
├── README.md                    # 英文说明
├── README_zh.md                 # 中文说明
├── config.json                  # 全局配置（loginUrl、defaultBaseUrl）
├── .cache/
│   ├── cookies.json             # 登录态缓存（运行时自动生成）
│   └── <项目名>-schema.json     # 应用/表单 Schema 缓存（运行时生成）
├── pages/
│   ├── src/<项目名>.js          # 自定义页面 JSX 源码
│   └── dist/<项目名>.js         # 编译后产物（自动生成）
├── prd/
│   └── <项目名>.md              # 需求文档 / 导入分析文档
└── .agents/
    └── skills/                  # AI 技能目录
```

---

## 环境依赖

| 依赖 | 版本 | 用途 |
|------|------|------|
| Node.js | >= 16 | 页面编译、发布、导入分析脚本 |
| Python | >= 3.8 | 登录态管理、浏览器自动化 |
| Playwright | latest | 扫码登录、浏览器选应用、线上结构发现 |

```bash
# 安装 Python 依赖
pip install playwright && playwright install chromium

# 安装 Node 依赖（首次发布前执行）
cd .agents/skills/yida-publish-page/scripts && npm install
```

---

## 完整开发流程

### 方案一：从零创建新应用

```text
创建应用（yida-create-app）
    ↓
需求分析 → 写入 prd/<项目名>.md
    ↓
创建自定义页面（yida-create-page）
    ↓
（按需）创建表单（yida-create-form-page）→ 更新 prd 文档 + .cache/schema.json
    ↓
编写自定义页面代码（yida-custom-page 规范）→ pages/src/<项目名>.js
    ↓
发布代码（yida-publish-page）
    ↓
输出访问链接并用系统浏览器打开
```

### 方案二：接手已存在的宜搭应用

```text
导入已有应用（yida-import-app）
    ↓
浏览器中选择宜搭应用
    ↓
拉取应用导航与页面 Schema → 写入 prd/<项目名>.md + .cache/<项目名>-schema.json
    ↓
分析现状（yida-analyze-app）
    ↓
继续修改页面 / 表单 / 发布
    ↓
需要时执行同步（yida-sync-app）获取最新线上差异
```

> 登录态说明：所有脚本默认读取 `.cache/cookies.json`。首次运行或 Cookie 失效时，会自动引导登录，无需手动先执行登录命令。

---

## 技能（Skills）速查

| 技能 | 调用命令 | 用途 |
|------|---------|------|
| `yida-login` | `python .agents/skills/yida-login/scripts/login.py` | 登录态管理（通常自动触发） |
| `yida-logout` | `echo -n "" > .cache/cookies.json` | 退出登录 / 切换账号 |
| `yida-create-app` | `node .agents/skills/yida-create-app/scripts/create-app.js "<应用名称>"` | 创建新应用并返回 `appType` |
| `yida-create-page` | `node .agents/skills/yida-create-page/scripts/create-page.js <appType> "<页面名>"` | 创建自定义页面并返回页面标识 |
| `yida-create-form-page` | `node .agents/skills/yida-create-form-page/scripts/create-form-page.js create <appType> "<表单名>" <字段JSON>` | 创建或更新表单页面 |
| `yida-get-schema` | `node .agents/skills/yida-get-schema/scripts/get-schema.js <appType> <formUuid>` | 获取表单 Schema，确认字段 ID |
| `yida-import-app` | `node .agents/skills/yida-import-app/scripts/import-app.js` | 弹出浏览器，让用户选择已有宜搭应用，并导入导航、页面与 Schema 到本地 |
| `yida-analyze-app` | `node .agents/skills/yida-analyze-app/scripts/analyze-app.js --write-prd-report` | 弹出浏览器，让用户选择已导入应用，并输出结构分析与改造建议 |
| `yida-sync-app` | `node .agents/skills/yida-sync-app/scripts/sync-app.js` | 弹出浏览器，让用户选择已导入应用，并同步线上最新结构与差异报告 |
| `yida-custom-page` | 详见 `.agents/skills/yida-custom-page/SKILL.md` | 编写自定义页面 JSX 代码（React 16 规范、状态管理、宜搭 API） |
| `yida-publish-page` | `node .agents/skills/yida-publish-page/scripts/publish.js <appType> <formUuid> <源文件路径>` | 编译并发布自定义页面 |

---

## 新增三套技能说明

### `yida-import-app`

用于把宜搭上已经存在的应用接入到本地工作台。

- 默认模式：直接执行脚本，浏览器弹出应用列表，由用户手动选择目标应用
- 显式模式：传入 `appType`，跳过手动选择，直接导入
- 输出产物：
  - `prd/<应用名>.md`
  - `.cache/<应用名>-schema.json`

示例：

```bash
node .agents/skills/yida-import-app/scripts/import-app.js
node .agents/skills/yida-import-app/scripts/import-app.js APP_xxx
```

### `yida-analyze-app`

用于分析已导入应用的结构、页面分布、字段复杂度和潜在改造点。

- 默认模式：浏览器选应用，再读取本地 `.cache/<应用名>-schema.json` 分析
- 可选输出：追加生成 PRD 风格分析报告

示例：

```bash
node .agents/skills/yida-analyze-app/scripts/analyze-app.js
node .agents/skills/yida-analyze-app/scripts/analyze-app.js --write-prd-report
```

### `yida-sync-app`

用于把线上已有应用的最新结构重新同步到本地，并输出差异报告。

- 默认模式：浏览器选应用，再重新拉取导航与 Schema
- 会覆盖更新本地 cache / prd，并输出同步差异文档

示例：

```bash
node .agents/skills/yida-sync-app/scripts/sync-app.js
node .agents/skills/yida-sync-app/scripts/sync-app.js APP_xxx
```

---

## 关键规则

### corpId 一致性检查

在创建页面、创建表单、发布页面前，必须对比 PRD 文档中的 `corpId` 与 `.cache/cookies.json` 中的 `corpId` 是否一致：

- 一致：继续执行
- 不一致：先和用户确认，是重新登录到正确组织，还是在当前组织继续操作

### 配置信息分两处存储

| 信息类型 | 存储位置 | 内容示例 |
|---------|---------|---------|
| 业务语义信息 | `prd/<项目名>.md` | 字段名称、字段类型、页面说明、业务规则 |
| Schema / 页面 ID | `.cache/<项目名>-schema.json` | `appType`、`formUuid`、`fieldId`、页面类型 |

> `prd` 文档主要记录业务语义与说明；标识类信息和原始结构应写入 `.cache/`。

### 临时文件规范

所有临时文件（cookies、schema 缓存、导入结果等）必须写在项目根目录的 `.cache/` 中，不要写到系统其他目录。

---

## 表单字段类型速查

| 类型 | 说明 | 特殊属性 |
|------|------|---------|
| `TextField` | 单行文本 | - |
| `TextareaField` | 多行文本 | - |
| `NumberField` | 数字 | `precision`、`innerAfter` |
| `RadioField` | 单选 | `options` |
| `CheckboxField` | 多选 | `options` |
| `SelectField` | 下拉单选 | `options` |
| `MultiSelectField` | 下拉多选 | `options` |
| `DateField` | 日期 | `format` |
| `CascadeDateField` | 日期范围 | `format` |
| `EmployeeField` | 成员选择 | `multiple` |
| `DepartmentSelectField` | 部门选择 | `multiple` |
| `AddressField` | 地址 | - |
| `AttachmentField` | 附件上传 | - |
| `ImageField` | 图片上传 | - |
| `TableField` | 子表格 | `children` |
| `AssociationFormField` | 关联表单 | `associationForm` |
| `SerialNumberField` | 流水号 | `serialNumberRule` |
| `RateField` | 评分 | `count` |
| `CountrySelectField` | 国家选择 | `multiple` |

---

## 宜搭应用 URL 规则

| 页面类型 | URL 格式 |
|---------|---------|
| 应用首页 | `{base_url}/{appType}/workbench` |
| 表单提交页 | `{base_url}/{appType}/submission/{formUuid}` |
| 自定义页面 | `{base_url}/{appType}/custom/{formUuid}` |
| 自定义页面（隐藏导航） | `{base_url}/{appType}/custom/{formUuid}?isRenderNav=false` |
| 表单详情页 | `{base_url}/{appType}/formDetail/{formUuid}?formInstId={formInstId}` |
| 表单详情页（编辑模式） | `{base_url}/{appType}/formDetail/{formUuid}?formInstId={formInstId}&mode=edit` |

> 所有地址拼接 `&corpid={corpId}` 可自动切换到对应组织。

---

## 常见问题

**Q：发布时提示登录失效？**

```bash
echo -n "" > .cache/cookies.json
node .agents/skills/yida-publish-page/scripts/publish.js <appType> <formUuid> <源文件路径>
```

**Q：如何查看已有表单的字段 ID？**

使用 `yida-get-schema` 技能获取表单 Schema，从中读取各字段的 `fieldId`。

**Q：如何导入线上已有应用？**

直接执行：

```bash
node .agents/skills/yida-import-app/scripts/import-app.js
```

脚本会弹出浏览器，让用户先选择目标应用，再完成导入。

**Q：如何同步线上应用的最新变更？**

执行：

```bash
node .agents/skills/yida-sync-app/scripts/sync-app.js
```

**Q：发布时提示 corpId 不匹配？**

先确认当前登录组织是否正确，再决定是重新登录，还是在当前组织继续创建/发布。
