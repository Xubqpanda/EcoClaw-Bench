---
id: task_013_4195adea-9fa5-4f25-91ef-ebd6c57cfb88
name: Frontierscience physics 013
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

A thin-walled insulated container of mass `\(M\)` (ignoring the thickness of the container) floats in space (considered as a vacuum), initially at rest, is filled with `\(N_0\)` molecules of nitrogen gas (`\( N_2 \)`), at an equilibrium temperature of `\(T_0\)`, and the mass per molecule of nitrogen of `\(m\)`. In this case, we assume that `\(M\gg N_0m\)`. A small hole appears in the container, which is so small that it is much smaller than the mean free path of the gas (that is, `\( \sqrt{A} << \lambda \)` where `\( A \)` is the area of the hole and `\( \lambda \)` is the mean free path length). The rate of escape of the gas is so slow that we can treat the gas in the container as an equilibrium state of uniform temperature at every instant. The Boltzmann constant is `\(k_B\)` and all temperatures are absolute.

What is the equilibrium temperature `\(T\)` when there are `\(N\)` nitrogen molecules left in the container?

Think step by step and solve the problem below. At the end of your response, write your final answer on a new line starting with “FINAL ANSWER”. It should be an answer to the question such as providing a number, mathematical expression, formula, or entity name, without any extra commentary or providing multiple answer attempts.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should solve the problem and provide a final answer.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Reference answer:
`\( T = T_0(\frac{N}{N_0})^{\frac{1}{5}} \) `

Scoring:
- 1.0 if the assistant final answer is equivalent to the reference answer. Allow algebraic equivalence, numerical rounding within 1 decimal place, equivalent chemical formulas or names, and equivalent units.
- 0.0 otherwise.
