# kernel.config.md — 唯一配置入口(启动新工程时填这一份)

> 三角色文档(roles/*.md)与收件箱模板开箱即用;所有按工程定制项集中在此。

## 1. 项目

- 项目名 / 一句话定位:`{{PROJECT_NAME}}` — `{{ONE_LINER}}`
- 远端仓库:`{{REPO_URL}}`(默认分支 `{{DEFAULT_BRANCH}}`)

## 2. 角色 → 模型映射

| 角色 | 本工程使用的模型 | 会话入口 |
|---|---|---|
| 设计方 | `{{DESIGNER_MODEL}}`(最高能力档) | 口令:读收件箱,设计 |
| 写码方 | `{{CODER_MODEL}}`(低成本走量档) | 口令:读收件箱,开工 |
| 审阅方 | `{{REVIEWER_MODELS}}`(中能力档,可多个,认领制) | 口令:读收件箱,审阅 |

客座模型(不在映射内的)只做顾问式审阅,产出入 `docs/reviews/`(带模型标识),无合并权、不出 spec、不写实现。

## 3. 验证入口(CI)

- 权威单命令:`{{VERIFY_CMD}}`(例:`./Scripts/ci.sh`;必须确定性、可重复、末行输出明确的 PASS/FAIL 标记)
- 内环快速模式:`{{VERIFY_QUICK_CMD}}`(例:`./Scripts/ci.sh --quick`;不可作交付证据)
- 自动执行者:`{{RUNNER}}`(例:self-hosted runner,push/PR 触发跑同一脚本;为空则审阅方本地全量复跑)
- CI 内部顺序要求:便宜守卫最前,最贵测试最后(fail-fast)。

## 4. 红线(违反即打回,按工程增删)

1. 密钥/真实个人数据不入库。
2. `{{REDLINE_2}}`(例:样例数据坐标必须真实)
3. `{{REDLINE_3}}`(例:UI 禁硬编码色值,一律走 Theme token)
4. `{{REDLINE_4}}`(例:工程描述文件唯一真相源,禁手改生成物)
5. `{{REDLINE_5}}`(例:资源目录禁位图照片)

## 5. 分支与合并

- 写码方从最新 `origin/{{DEFAULT_BRANCH}}` 拉分支;单 PR 单主题;squash 合并(PR 标题即最终提交信息);合并后删分支。
- 合并权:审阅方独占。

## 6. 文档命名

- 永久文档:`docs/{designs,devlogs,reviews}/YYYY-MM-DD-HH-MM-<topic-slug>.md`(全英文小写 kebab-case,只增不删不覆盖)。
- `docs/PROJECT.md`:唯一原地更新文档(宪法:红线/当前状态/环境陷阱)。

## 7. 环境陷阱(随发现追加)

- `{{ENV_NOTE_1}}`
