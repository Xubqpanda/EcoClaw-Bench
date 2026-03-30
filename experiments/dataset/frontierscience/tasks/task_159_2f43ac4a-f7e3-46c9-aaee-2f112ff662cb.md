---
id: task_159_2f43ac4a-f7e3-46c9-aaee-2f112ff662cb
name: Frontierscience biology 159
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

Context: You are working with colorectal cancer cells harboring a KRAS G12D mutation. A batch of inhibitors targeting the MAPK signaling pathway has been mislabeled, and you must identify which tube contains which drug based solely on signaling outcomes.

The original set of inhibitors included:

- SCH722984
- BVD-523
- LY3214996
- AZD6244 (Selumetinib)
- LY3009120

You treat KRAS G12D SW48 cells for 24 hours and observe the following Western blot and phenotypic effects:

Inhibitor A

- p-ERK1/2 unchanged
- p-RSK reduced
- Total ERK1/2 stable
- S6 phosphorylation is unaffected

Inhibitor B

- ERK2 is progressively lost, ERK1 is stable
- p-RSK reduced
- p-ERK1/2 increased
- Feedback target (DUSP6) reduced
- Ubiquitinated ERK2 is detectable after 8 hours

Inhibitor C

- p-ERK1/2 drops initially, but rebounds at 8–12 h
- p-RSK and p-S6 are reduced at 4 h, return by 24 h
- ERK1/2 levels are stable
- MEK phosphorylation increases over time

Inhibitor D

- p-ERK1/2 is absent throughout
- p-MEK levels are low
- Loss of both ERK1 and ERK2 nuclear accumulation occurs
- Co-IP shows reduced MEK–ERK complex formation occurs

Inhibitor E

- Increase in p-ERK1/2
- p-RSK is unchanged
- Banding pattern inconsistent across replicates
- mRNA for ERK2 is unchanged, protein is reduced
Question: A. Using the known mechanisms of each drug, match Inhibitors A–E to their correct compound names. Justify your answer

B. Inhibitor B selectively reduces ERK2, but not ERK1. Propose two mechanistic explanations for this. How could you test whether this is due to targeted degradation vs epitope unmasking or aggregation?

C. Inhibitor C shows rebound in p-ERK1/2 and p-S6 at later timepoints. Explain why?

Think step by step and solve the problem below. In your answer, you should include all intermediate derivations, formulas, important steps, and justifications for how you arrived at your answer. Be as detailed as possible in your response.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should respond to the research problem following the rubric below.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Points: 0.75, Item: Award 0.75 for correctly identifying inhibitor D as LY3009120
Points: 0.75, Item: Award 0.75 marks for a correct justification for inhibitor D as LY3009120. At least 2 of any of the following justifications:

- p-ERK absent- complete loss of p-ERK indicates something upstream is inhibited
- p-MEK low- low p-MEK could indicate a MEK inhibitor but also could indicate something upstream
- ERK–MEK complex disrupted- preventing MEK-ERK complex indicates something upstream of MEK
- Loss of nuclear ERK accumulation- indicative of something upstream
- Since we are confident that our MEK inhibitor is inhibitor C and this cant be an ERK inhibitor so inhibitor D must be our RAF inhibitor: LY3009120.
Points: 0.75, Item: Award 0.75 marks for a correct justification that inhibitor A is SCH722984. Justification:

- Kidger et al showed that dual mechanism inhibitors caused a gradual recovery of p-ERK1/2 over time in pathway rebound whereas LY3214996 induced a strong accumulation of p-ERK1/2 indicating that inhibitor A is SCH722984
Points: 0.75, Item: Award 0.75 marks for a correctly justification for Inhibitor C as AZD6244. Any of the following justifications:

- ERK drops then rebounds- characteristic of Selumetinib, a MEK1/2 inhibitor, which initially reduces ERK phosphorylation.
- p-RSK and p-S6 transiently reduced- The rescue of p-RSK and p-S6 is consistent with reactivation of the pathway.
- MEK phosphorylation increases- confirms feedback reactivation and is commonly observed see Duncan et al., 2012
Points: 0.75, Item: Award 0.75 marks for correctly identifying inhibitor A as SCH722984
Points: 0.75, Item: Award 0.75 marks for correctly identifying inhibitor B as BVD-523
Points: 0.75, Item: Award 0.75 marks for correctly identifying inhibitor C as AZD6244
Points: 0.75, Item: Award 0.75 marks for correctly identifying inhibitor E as LY3214996
Points: 0.75, Item: Award 0.75 marks for the correct justification for inhibitor E as LY3214996. Justification: 

- LY321996 is an ATP competitive inhibitor and has been shown to increase p-ERK which correlates with inhibitor E
Points: 0.75, Item: Award 0.75 marks for the correct justification that inhibitor B is BVD-523. Any of the following justifications: 

- Ubiquitinated ERK2 detected- indicative of proteosomal degradation as described in Balmano et al., 2023
- All 3 of these ERK inhibitors have been reported to cause ERK2 degradation but BVD-523 the strongest 
- BVD-523 also inhibits ERK1/2 catalytic activity but not its pT-E-pY phosphorylation by MEK1/2 so we should see an increase in p-ERK.
Points: 1.0, Item: Award 1 mark for a description of MEK reactivation: can include: 

- Initial MEK inhibition by AZD6244 blocks ERK phosphorylation → p-ERK and p-RSK drop.
- This suppresses DUSP6 and SPRY1/2, which are negative feedback regulators of RAS–RAF signalling.
- Without feedback, RAS–RAF signalling increases, leading to: MEK hyperphosphorylation, rebound ERK activation and reactivation of downstream effectors like RSK

Award 0.5 marks if the same points/description are present but the description is about a different inhibitor. 
Points: 1.0, Item: Award 1 marks for at least 2 of the following techniques to test mechanism of degradation:

- 
  - Proteasome inhibition (e.g. with MG132): If ERK2 is rescued, the loss is due to proteasomal degradation.
  - Cycloheximide chase: Monitor ERK2 turnover rate ± BVD-523 to confirm half-life reduction.
  - Immunoprecipitation + western blot for ubiquitin-conjugated ERK2.
  - RT-qPCR confirms mRNA levels are stable — rules out transcriptional repression.

partial marks, 0.5 marks for each correct technique
Points: 0.5, Item: Part B award 0.5 marks for correctly identifying 2 mechanisms: 

1. Drug-induced conformational change exposes a degron in ERK2, leading to selective ubiquitination.
2. Loss of stabilising protein–protein interactions (e.g., MEK–ERK2 scaffold) causes ERK2 to be targeted for degradation.

partial marks:

award 0.25 marks for each correct mechanism
