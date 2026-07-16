# CLAUDE.md — 会话入口(AI 会话自动加载)

{{PROJECT_NAME}}:三角色协作开发({{ONE_LINER}})。协作内核:https://github.com/StevenG3/trio-kernel

## 第一步:判断本会话角色,只读 3 份文档

| 你是 | 读 |
|---|---|
| 设计方({{DESIGNER_MODEL}}) | `docs/roles/designer.md` |
| 写码方({{CODER_MODEL}}) | `docs/roles/coder.md` |
| 审阅方({{REVIEWER_MODELS}}) | `docs/roles/reviewer.md` |
| 其他模型 | `docs/roles/README.md` 客座节(仅顾问式审阅) |

再读:`docs/kernel.config.md`(配置)+ `docs/PROJECT.md`(宪法)。

## 口令

用户说「读收件箱,设计 / 开工 / 审阅」→ 读 `docs/inbox/<你的角色>.md`,照条目办;处理完删除条目并随工作 commit。写码方注意 FIFO 阻塞门(收件箱头部规则)。

## 铁律

TDD 整体归写码方;写码方≠审阅方,审阅必须实证;红线见 kernel.config.md §4。squash 合并;永久文档命名 `YYYY-MM-DD-HH-MM-<topic-slug>.md`。
