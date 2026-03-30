---
id: task_097_eeb31abb-41cb-4fe6-9864-f98fdcef338d
name: Frontierscience biology 097
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

Molecular cloning is a technique that enables the generation of recombinant plasmids that can induce exogenous expression of certain genes. The first step of molecular cloning is to reverse transcribe the mRNA of the gene of interest into single-stranded cDNA. In an experiment, this was achieved through the use of oligo dT primers that specifically anneal to the poly-A tail of mRNA molecules, which is then extended by reverse transcriptase enzyme. The resultant cDNA molecules are then amplified through PCR and the products were visualized using agarose gel electrophoresis to ensure that the gene of interest was correctly amplified. However, the observed DNA band was estimated to be ~1 kb in size, which is far below the expected 3.7 kb of the gene of interest. After some troubleshooting steps, it was determined that this discrepancy was due to the type of reverse transcriptase enzyme selected for the experiment. What specific characteristic of the enzyme can explain this discrepancy?

Think step by step and solve the problem below. At the end of your response, write your final answer on a new line starting with “FINAL ANSWER”. It should be an answer to the question such as providing a number, mathematical expression, formula, or entity name, without any extra commentary or providing multiple answer attempts.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should solve the problem and provide a final answer.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Reference answer:
The enzyme contains an RNAse H domain

Scoring:
- 1.0 if the assistant final answer is equivalent to the reference answer. Allow algebraic equivalence, numerical rounding within 1 decimal place, equivalent chemical formulas or names, and equivalent units.
- 0.0 otherwise.
