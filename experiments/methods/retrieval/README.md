# Retrieval — 检索增强方法

通过检索相关知识并注入 agent context，减少 agent 自行探索的 token 消耗。

## 包含的方法

| 方法 | 目录 | 机制 | 标签 |
|------|------|------|------|
| **QMD (BM25)** | `../qmd/` | BM25 全文检索 | `qmd-only` |
| **QMD (Vector)** | `../qmd/` | 向量语义检索 | `qmd-vsearch` |
| **QMD (Hybrid)** | `../qmd/` | BM25 + 向量 + 重排序混合检索 | `qmd-query` |
| **CCR** | `../ccr/` | LangChain ContextualCompressionRetriever（检索+压缩） | `ccr-only` |

## 特点

- 在 agent 执行前注入相关上下文，减少试错和探索
- QMD 支持三种检索模式（BM25/向量/混合）
- CCR 结合了检索和压缩，先检索再用 LLM 提取关键信息
- 需要预先建立索引（QMD 需要 `qmd collection add`，CCR 需要 FAISS 索引）