# 三方协作机制总览

> 每个会话开工前:判断自己是哪个角色 → 读 `docs/roles/<role>.md` + `docs/PROJECT.md`(宪法)。

## 模型与角色映射

| 角色 | 模型 | 文档 | 产出目录 |
|---|---|---|---|
| 设计方 | {{DESIGNER_MODEL}}(Claude 会话,设计任务) | roles/designer.md | docs/designs/ |
| 写码方 | {{CODER_MODEL}}(实现任务) | roles/coder.md | docs/devlogs/ |
| 审阅方 | {{REVIEWER_MODELS}}(可多个,认领制) | roles/reviewer.md | docs/reviews/ |

## 客座模型(非三方正选)

不属于上述映射的模型(不在 kernel.config.md 映射内的)一律视为**客座**,只做**顾问式审阅**:

| 事项 | 客座 | 正式审阅方 |
|---|---|---|
| 全仓/架构/安全静态审阅,产出 docs/reviews/ | ✅ | ✅ |
| PR 审阅 + squash 合并 / 删分支 | ❌ | ✅ 独占 |
| 出 spec / 写实现提示词 | ❌ | ❌(设计方独占) |
| 改运行代码 / TDD 实现 / 开实现 PR | ❌ | ❌(写码方独占) |

客座产出写入 `docs/reviews/YYYY-MM-DD-HH-MM-<model-slug>.md`(带模型标识);结论交设计方/审阅方裁定后由写码方实现。

## 职责矩阵

| 事项 | 设计方 | 写码方 | 审阅方 |
|---|---|---|---|
| 产品/架构/交互设计,出 spec 与提示词 | ✅ | ❌ | ❌ |
| 代码 + TDD(含 App UI) | ❌ | ✅ | ❌ |
| devlog(docs/devlogs/) | ❌ | ✅(写) | ✅(审) |
| 独立验证(复跑 test/脚本/截图) | ❌ | ✅(交付前自验附证据) | ✅(核验+抽查) |
| 审阅 + PR squash 合并/删分支 | ❌ | ❌(只 push 自己分支) | ✅ |
| 打回/评分/出整改提示词 | ❌ | ❌ | ✅ |
| 裁定设计提请 | ✅ | ❌ | ❌ |

## 三条铁律(所有角色遵守)

1. **TDD 不可拆分,整体归写码方**。没有"设计方给参考实现、写码方贴上去"的捷径。
2. **写码方 ≠ 审阅方**。审阅方独立于设计与实现,必须实证核验,被授权打回,绝不做橡皮图章。
3. **红线不可破**(kernel.config.md §4)。

## 收件箱工作流

```
设计方 ──spec全文→ designs/,提示词→ inbox/coder.md
   ↑                                    ↓
   │ 设计提请                    「读收件箱,开工」
   │ → inbox/designer.md               ↓
   │(仅限:spec 缺失/矛盾/         写码方 TDD 实现
   │  验收无法客观判定)           → devlogs/ + 开 PR
   │                              → PR号写入 inbox/reviewer.md
   │                                    ↓
   │                             「读收件箱,审阅」
   │                                    ↓
   └──────────────────── 审阅方审阅 → reviews/ 落盘
                          ├─ 通过 → squash 合并,inbox/coder.md 写"无整改"
                          └─ 打回 → 整改提示词写入 inbox/coder.md
```

**三句口令**(用户唯一需要说的话):

| 会话 | 口令 |
|---|---|
| 设计方 | 读收件箱,设计 |
| 写码方 | 读收件箱,开工 |
| 审阅方 | 读收件箱,审阅 |

收件箱规则:条目 = 指针 + 摘要(全文在产出目录);处理完由处理方删除;每次写入/清空随当次工作 commit,git 即消息总线。

## 标准闭环

设计方出 spec + 提示词入 coder 收件箱 → 写码方从 origin/master 拉分支、TDD 实现、写 devlog、push、开 PR、PR 号入 reviewer 收件箱 → 审阅方审阅落盘,通过则 squash 合并,下一步指令入 coder 收件箱 → 循环。用户只出三句口令 + 做外部决策。
