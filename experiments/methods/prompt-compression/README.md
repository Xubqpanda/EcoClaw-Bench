# Prompt Compression — 输入压缩方法

压缩 agent 的输入 context（工具输出、系统提示等），减少 input token 消耗。

## 包含的方法

| 方法 | 目录 | 机制 | 标签 |
|------|------|------|------|
| **LLMLingua-2** | `../llmlingua/` | 微软 xlm-roberta 模型做 token 级压缩 | `llmlingua-only` |
| **Selective Context** | `../selective-context/` | 基于 GPT-2 自信息量移除低信息内容 | `selctx-only` |
| **Slim Prompt** | `../slim-prompt/` | 截断工具输出 + 注入效率指令 | `slim-prompt` |

## 特点

- 直接减少发送给 LLM 的 token 数量
- 可能影响信息完整性，需要在压缩率和质量之间权衡
- LLMLingua-2 和 Selective Context 需要本地模型推理
- Slim Prompt 是纯规则方法，无额外依赖