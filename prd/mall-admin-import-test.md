# 商城管理系统后台 需求文档

## 应用配置

| 配置项 | 值 |
| --- | --- |
| appType | APP_MS2VXWY18MPXFBNVOIRK |
| corpId | dingb73b195142daa876f5bf40eda33b7ba0 |
| baseUrl | https://nf6taj.aliwork.com |
| appName | 商城管理系统后台 |

## 接入信息

- 导入时间：2026-03-12T12:57:38.074Z
- 页面发现来源：browser-formnav
- 是否使用 manifest：否

## 页面清单

| 页面名称 | 页面类型 | formUuid | 字段数 | 说明 |
| --- | --- | --- | --- | --- |
| 营销活动表 | form | FORM-9395F7019717423397706F561F8A88E56ANZ | 8 | browser-formnav |
| 会员管理表 | form | FORM-BEC1863FAD434261888B45542944EA04KS5C | 8 | browser-formnav |
| 订单管理表 | form | FORM-1AFBEF171D7C43D2BABB47D184C6EAA5RKHQ | 8 | browser-formnav |
| 商品管理表 | form | FORM-338F10089C5C421D9A6BB616B062C03AIP1U | 8 | browser-formnav |
| 商品分类表 | form | FORM-3F14ABDD41F543758FA8FC1A0F4BD1C6QPGY | 6 | browser-formnav |
| 后台首页 | custom | FORM-1FA8498C7F9B4492AF836830CE30CB43Y36B | 0 | browser-formnav |
| 营销活动管理页 | custom | FORM-6EE73B8031494460AFB0908747FA651514W0 | 0 | browser-formnav |
| 会员管理页 | custom | FORM-93DFD9DF58EA4BA38BE1F0CCBD7CDD74NYPC | 0 | browser-formnav |
| 订单管理页 | custom | FORM-DAE0219D9B28419E9618336013F5093E1VJ0 | 0 | browser-formnav |
| 商品管理页 | custom | FORM-FCD2E978032543CA868715B168BDC9DF7BHF | 0 | browser-formnav |
| 商品分类管理页 | custom | FORM-A64A07DF91DF4E32BE083000A5DC5FEDBCYO | 0 | browser-formnav |

## 页面与表单配置

### 营销活动表（表单页面）

| 字段名称 | 字段类型 | fieldId | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| 活动名称 | TextField | textField_euhl9hia | 是 |  |
| 活动类型 | SelectField | selectField_euhlciac | 是 |  |
| 开始时间 | DateField | dateField_euhl5wku | 是 |  |
| 结束时间 | DateField | dateField_euhlcre0 | 是 |  |
| 活动状态 | SelectField | selectField_euhl5i15 | 是 |  |
| 预算金额 | NumberField | numberField_euhlk8ko | 否 |  |
| 负责人 | TextField | textField_euhlbqt6 | 否 |  |
| 活动说明 | TextareaField | textareaField_euhl74gt | 否 |  |

### 会员管理表（表单页面）

| 字段名称 | 字段类型 | fieldId | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| 会员姓名 | TextField | textField_ev1t56nx | 是 |  |
| 手机号 | TextField | textField_ev1t9w9h | 是 |  |
| 会员等级 | SelectField | selectField_ev1t2er3 | 是 |  |
| 积分余额 | NumberField | numberField_ev1to5p9 | 是 |  |
| 注册日期 | DateField | dateField_ev1tdc3p | 是 |  |
| 会员状态 | SelectField | selectField_ev1tv8of | 是 |  |
| 最近消费日期 | DateField | dateField_ev1t2yiv | 否 |  |
| 备注 | TextareaField | textareaField_ev1ttrzq | 否 |  |

### 订单管理表（表单页面）

| 字段名称 | 字段类型 | fieldId | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| 订单号 | TextField | textField_evg6cnkw | 是 |  |
| 下单时间 | DateField | dateField_evg6waxq | 是 |  |
| 会员姓名 | TextField | textField_evg64rb0 | 是 |  |
| 手机号 | TextField | textField_evg6zq7w | 是 |  |
| 订单金额 | NumberField | numberField_evg6yeq3 | 是 |  |
| 订单状态 | SelectField | selectField_evg6w4qk | 是 |  |
| 支付状态 | SelectField | selectField_evg7dx0q | 是 |  |
| 收货地址 | TextareaField | textareaField_evg79thh | 是 |  |

### 商品管理表（表单页面）

| 字段名称 | 字段类型 | fieldId | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| 商品名称 | TextField | textField_evusgcv4 | 是 |  |
| 商品编码 | TextField | textField_evusi74s | 是 |  |
| 商品分类 | SelectField | selectField_evusrbf0 | 是 |  |
| 销售价 | NumberField | numberField_evuti6j3 | 是 |  |
| 库存数量 | NumberField | numberField_evutyv3a | 是 |  |
| 商品状态 | SelectField | selectField_evutvg0z | 是 |  |
| 主图链接 | TextField | textField_evuti22l | 否 |  |
| 商品简介 | TextareaField | textareaField_evutz6s3 | 否 |  |

### 商品分类表（表单页面）

| 字段名称 | 字段类型 | fieldId | 必填 | 说明 |
| --- | --- | --- | --- | --- |
| 分类名称 | TextField | textField_ew6465ms | 是 |  |
| 分类编码 | TextField | textField_ew64wr3y | 是 |  |
| 父级分类 | TextField | textField_ew64iz1o | 否 |  |
| 排序值 | NumberField | numberField_ew64i6bd | 否 |  |
| 启用状态 | SelectField | selectField_ew64yxby | 是 |  |
| 分类描述 | TextareaField | textareaField_ew64pg37 | 否 |  |

## 当前应用现状

- 已识别页面数：11
- 自定义页面数：6
- 表单页面数：5
- 已识别字段数：38
- 本文档由导入脚本逆向生成，可作为后续 AI 改造的基础版本。
