---
id: task_046_4f1cf869-3ea3-400c-8fa3-e4d3f6fe1cdf
name: Frontierscience physics 046
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

Two uniform balls of radius `\(r\)` and density `\(ρ\)` are in contact with each other, and they revolve around a uniform ball of radius `\(R_0\)` and density `\(ρ_M\)` with the same angular velocity. The centers of the three balls remain collinear, and the orbit of the revolution is circular. Suppose `\(ρ_M R_0^3≫ρr^3\)` and the distance between the point of contact of the two small spheres and the center of the large sphere `\(R \gg r\)`. We can assume that the large ball is not moving at all due to its huge mass. The only force of interaction between the bodies that we consider here is gravity. Find the critical value for `\( R \)` denoted as `\( R_C \)` such that the two small balls keep in touch. Express your answer in terms of the constants defined above.

Think step by step and solve the problem below. At the end of your response, write your final answer on a new line starting with “FINAL ANSWER”. It should be an answer to the question such as providing a number, mathematical expression, formula, or entity name, without any extra commentary or providing multiple answer attempts.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should solve the problem and provide a final answer.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Reference answer:
`\(R_C=R_0 \left(\frac{12 \ρ_M}{\ρ} \right)^{1/3}\)`

Scoring:
- 1.0 if the assistant final answer is equivalent to the reference answer. Allow algebraic equivalence, numerical rounding within 1 decimal place, equivalent chemical formulas or names, and equivalent units.
- 0.0 otherwise.
