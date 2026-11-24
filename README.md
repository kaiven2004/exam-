# AIView 实操考试 · 打牌记分器

一次限时实操考试的完整留痕：题面、实现、断言、答辩素材、版本历史。

- **交付物**：`work.html` —— 单文件、双击可用、断网可用、无任何外链
- **自测**：双击 `_check.html`（同目录，会加载 `work.html` 跑断言）
- **答辩素材**：`NOTES.md`（每个函数一行：入口 / 数据怎么走 / 为什么这么选）
- **题面与变更原文**：`docs/`
- **版本约定**：一次变更 = 一个 commit + 一个 tag（`v0-skeleton` → `v1` → `v2` → `final`）

## 跑起来

```
双击 work.html
```

## 检查

```
双击 _check.html
```

断言覆盖：门槛项钩子、加人上限与重名、`addRound` 三种非法输入、排名降序与 `data-rank`、删除后重算、localStorage 写入。

## 提交约定

```powershell
.\tools\save.ps1 "feat(v1): 局明细 + 删除局 + bestRound" v1
```

`tools/save.ps1` 会自动切到仓库根目录，commit + tag + push；push 失败只提示，不中断。

## 历史

| tag | 内容 |
| --- | --- |
| `v1` | 基线：玩家 / 记一局 / 排行榜 / 统计 / 持久化 / 空态，33 条断言通过 |
