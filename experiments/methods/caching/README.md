# Caching — 缓存方法

通过优化上下文结构，提高 LLM provider 层的 prompt cache 命中率。

## 包含的方法

| 方法 | 目录 | 机制 | 标签 |
|------|------|------|------|
| **Prefix Cache** | `../prefix-cache/` | 注入稳定前缀填充触发缓存 | `prefix-cache` |

## 特点

- 利用大模型 API 提供商（如 OpenAI, Anthropic）的自动缓存机制
- 缓存命中的 token 价格大幅降低（通常 50% 折扣）
- 显著减少多轮对话的响应延迟（TTFT）
- 对输出质量零影响，是"免费的午餐"