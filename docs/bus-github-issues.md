# 总线变体:GitHub Issues(可插拔,替代文件收件箱)

> 默认总线是文件收件箱(`docs/inbox/*.md`,零依赖、状态与代码同 commit)。本变体在**多机协作/高并发写入**场景更优,按需切换。两者不混用。

## 何时选 Issues 总线

| 信号 | 文件总线 | Issues 总线 |
|---|---|---|
| 多个会话共享一个工作目录/频繁推送竞争 | 有落错分支与 push 冲突风险(需 worktree 纪律) | ✅ 原子操作,无竞争 |
| 三方各自 clone、跨机器 | 需频繁 pull 同步 | ✅ 平台侧单一真相 |
| 任务状态与代码变更要同 commit 原子耦合、git 即完整审计轨迹 | ✅ 天然满足 | ✗ 状态在平台侧,与代码两笔账 |
| 离线/非 GitHub 平台 | ✅ 零依赖 | ✗ 强绑 GitHub API |

> 诚实结论:Issues 在并发原子性上更优,但**不是严格更优**——它放弃了"删条目随工作 commit"的原子耦合与 in-repo 审计。按项目形态选。

## 映射规则(机制不变,载体替换)

| 内核概念 | Issues 实现 |
|---|---|
| coder FIFO 队列 | label `queue:coder` 的 open issues,按 issue 编号升序取队首 |
| ⚡ 抢占区 | label `preempt`(叠加 `queue:coder`);存在即优先于一切队列任务 |
| 水线 3 | `gh issue list -l queue:coder --state open` 计数 ≥3 时设计方不写不建 |
| 阻塞门 | 不变:`gh pr list --state open` 自查,与总线无关 |
| designer/reviewer 收件箱 | label `inbox:designer` / `inbox:reviewer` |
| 认领制(多审阅方) | issue assignee(原生,优于文件标注) |
| 取任务/处理完删除 | close issue(关闭原因写 comment:commit/PR 链接,补回审计) |
| 条目 = 指针 + 摘要 | issue body = spec/devlog 路径 + 摘要(全文仍在 docs/,不变) |

## 口令语义不变

「读收件箱,开工」→ 写码方执行:`gh pr list --state open`(阻塞门)→ `gh issue list -l "queue:coder" -l preempt` → 非空取首;否则 `gh issue list -l queue:coder` 取编号最小者;开工时 close issue 并在 comment 留分支名。其余角色同理。

## 切换成本

kernel.config.md 增加一行 `总线:file | issues`;角色文档中"收件箱"操作按本文件映射执行。永久文档协议(designs/devlogs/reviews)不受总线选择影响。
