# Output Reduction — 输出缩减方法

通过指令注入或行为引导，减少 agent 生成的 output token。

## 包含的方法

| 方法 | 目录 | 机制 | 标签 |
|------|------|------|------|
| **Concise Output** | `../concise/` | 系统提示注入简洁回复指令 | `concise-only` |

## 组合方法

| 组合 | 标签 | 说明 |
|------|------|------|
| Concise + Slim Prompt | `concise-slim` | 同时减少输入和输出 token |

## 特点

- 无额外依赖和计算开销
- 通过 prompt engineering 引导模型行为
- 主要节省 output token（通常比 input token 更贵）
- 可能影响回复的详细程度和可读性