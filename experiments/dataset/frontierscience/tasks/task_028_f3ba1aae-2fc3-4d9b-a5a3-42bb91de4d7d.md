---
id: task_028_f3ba1aae-2fc3-4d9b-a5a3-42bb91de4d7d
name: Frontierscience physics 028
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

Consider a uniform three-dimensional object of elliptical cross section with mass `\(m\)`, the semi-major axis and semi-minor axis of the cross-section, `\(A\)` and `\(B\)`, respectively. It is placed on a horizontal ground, with stable equilibrium established. A perturbation is applied to the object to make a small pure rolling oscillation on the ground (without slipping). Find the period of this oscillation given by `\(\omega\)`, with the acceleration due to gravity as `\(g\)`. Assume there are no energy losses, and the only energy input comes from the perturbation.

Think step by step and solve the problem below. At the end of your response, write your final answer on a new line starting with “FINAL ANSWER”. It should be an answer to the question such as providing a number, mathematical expression, formula, or entity name, without any extra commentary or providing multiple answer attempts.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should solve the problem and provide a final answer.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Reference answer:
`\( \omega = \pi\sqrt{\frac{\left(A^{2}+5B^{2}\right)B}{g\left(A^{2}-B^{2}\right)}}\)`

Scoring:
- 1.0 if the assistant final answer is equivalent to the reference answer. Allow algebraic equivalence, numerical rounding within 1 decimal place, equivalent chemical formulas or names, and equivalent units.
- 0.0 otherwise.
