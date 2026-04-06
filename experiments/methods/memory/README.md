# Memory — 记忆管理方法

通过对话历史压缩或结构化记忆管理，减少长对话的 context 膨胀。

## 包含的方法

| 方法 | 目录 | 机制 | 标签 |
|------|------|------|------|
| **Compaction** | `../compaction/` | OpenClaw 内置 safeguard 历史压缩 | `compaction` |
| **Compaction + LCM** | `../compaction-lcm/` | safeguard + lossless-claw 无损上下文引擎 | `compaction-lcm` |
| **LycheeMem** | `../LycheeMem/` | 结构化长期记忆（Working Memory + Semantic Memory） | `lycheemem` |

## 特点

- 针对多轮对话场景，防止历史消息导致 context 爆炸
- Compaction 在接近 token 上限时自动总结旧历史
- LCM 在 compaction 基础上做"无损"压缩（移出大 tool result、budget pass）
- LycheeMem 是独立的记忆框架，通过双阈值 token 管理和知识提取实现压缩
- LycheeMem 需要启动独立后端服务