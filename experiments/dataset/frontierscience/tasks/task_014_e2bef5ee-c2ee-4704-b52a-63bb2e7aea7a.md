---
id: task_014_e2bef5ee-c2ee-4704-b52a-63bb2e7aea7a
name: Frontierscience physics 014
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

A certain region of space has an electric potential \\(V\\) which is cylindrically symmetrical about the \\(z \\)-axis and can be written as \\(V (\\rho, z) \\) , with \\(\\rho \\) the distance from the \\( z \\)-axis. The setup also includes a uniform magnetic field `\(\vec B = B \hat{z} \)` pointing along the `\( z \)-`direction. Gravity can be ignored.\
\
A particle with positive charge \\(q &gt; 0\\) and mass \\( m\\) is released in this potential. We want the potential to be such that there exists a maximum distance from the origin that the particle will ever reach. The potential and magnetic field must satisfy Maxwell's equations in free space.

The potential does not include the potential from the particle itself. We ignore radiation by the particle.

We assume the potential is at most quadratic, of the form\
\\(V(\\rho, z) = a + b \\rho + c z + d \\rho^2 + e z^2\\)\
for some constants \\(a, b, c, d\), and \\(e\).\
\
We also want a charged particle released from rest at the origin to remain at the origin. We drop the constant term in the potential, so \\(a = 0\\).\
\
There are three possible motions of the particle that are motions with a single angular frequency. Find an equation for \\( \\omega\_{\\rm sum}\\) the sum of these three angular frequencies. Give your answer in terms of \\(B, e, q, \\) and \\( m\\).

Think step by step and solve the problem below. At the end of your response, write your final answer on a new line starting with “FINAL ANSWER”. It should be an answer to the question such as providing a number, mathematical expression, formula, or entity name, without any extra commentary or providing multiple answer attempts.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should solve the problem and provide a final answer.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Reference answer:
\\(\\omega\_{\\rm sum} = \\frac{qB}{m} + \\sqrt{ \\frac{2qe}{m} } \\)

Scoring:
- 1.0 if the assistant final answer is equivalent to the reference answer. Allow algebraic equivalence, numerical rounding within 1 decimal place, equivalent chemical formulas or names, and equivalent units.
- 0.0 otherwise.
