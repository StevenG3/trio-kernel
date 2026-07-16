#!/usr/bin/env bash
# 用法:在新工程根目录执行 bash <trio-kernel 路径>/bootstrap.sh .
set -euo pipefail
TARGET="${1:?用法: bootstrap.sh <目标工程目录>}"
SRC="$(cd "$(dirname "$0")" && pwd)/template"
cp -Rv "$SRC/." "$TARGET/"
echo ""
echo "✔ 模板已就位。下一步:"
echo "  1. 编辑 $TARGET/docs/kernel.config.md(填 {{占位符}})"
echo "  2. 编辑 $TARGET/CLAUDE.md 与 docs/PROJECT.md 的占位符"
echo "  3. git add + commit,开三个模型会话,各说一句口令即可运转"
