---
id: task_114_60ff38cc-fb55-4c3c-b75c-f59dde5de0c3
name: Frontierscience physics 114
category: frontierscience
grading_type: llm_judge
timeout_seconds: 300
workspace_files: []
---

## Prompt

Context: IceCube neutrino scientists usually calculate confidence intervals on their results by constructing contours based on Wilks' Theorem. For time-integrated neutrino searches, the TS of the neutrino background generally follows Wilks' Theorem with two degrees of freedom. For time-dependent neutrino searches, the TS of the neutrino background generally follows Wilks' Theorem with four degrees of freedom. In order to calculate contours, we construct the variable \( \Delta \)TS by scanning the likelihood space in two dimensions and then subtracting the scanned TS from the best-fit TS (\( \Delta \)TS = TS\( _{best-fit} \) - TS\( _{truth} \)) and creating a 2D histogram of these values with the colorbar being \( \Delta \)TS, the x-axis being dt, and the y-axis being ns. We would then determine the Wilks' contours from the \( \Delta \)TS

If scientific data is filled with background or is bounded by physical conditions, it may be difficult to calculate limits or confidence intervals on such data. In this case, one can utilize the Feldman-Cousins method to ensure that the resulting intervals always cover the true value at the stated confidence level and avoid unphysical or empty intervals.

Say I am running an experiment where I am investigating the AGN NGC 1068 to see if its neutrino flux seems to be flaring or if it seems to be coming from steady emission. This experiment utilizes the maximum likelihood method to find where, given the free parameters gamma (energy spectrum), ns (number of signal events), t0 (the mean time of a Gaussian flare in MJD), and dt (the 1-sigma Gaussian flare duration in days), the most likely combination of the four free parameters in parameter space is. The resulting 2D likelihood space of this data in just ns and dt seems to have a local minimum at small dt and a global minimum at the maximum allowable dt.

I also have the ability to run "trials" or pseudo-experiments with my data by scrambling my dataset. I can run these trials as background trials by just scrambling my dataset, or I can run these trials as signal trials by scrambling my dataset and then injecting a specified number of signal events at a specified gamma, t0, and dt.

I can also scan over my true dataset's likelihood space by seeing what the likelihood (expressed in terms of test statistic) is for a specific combination of parameters.
Question: How would I set confidence intervals on the best-fit dt of the flare if the best-fit dt reaches the max allowed dt of 1960 days?

Specify which method (Wilks' or Feldman Cousins) should be used to calculate confidence intervals in this case and explain in detail why this was chosen over the other option.

If constructing trials, be specific in what parameter combinations should be used and how many combinations should be used. Also be specific in whether we should use background trials only, signal trials only, or both background and signal trials.

For the Feldman-Cousins method, outline exactly how you would construct a 2-D contour on the plot described by the context. Describe how you would construct the TS_best-fit values (minimizer or scan?) and the TS_truth values (for the truth, specify whether you should run a new fit or use the likelihood scan). Explain the construction of pseudo-trial `\( \Delta \)TS` and the true data `\( \Delta \)`TS separately. 

Once you have the best-fit values and the truth values, describe how you would use them to find the 90% included contour of the 2D histogram.

If using `\( \Delta \)`TS as your variable for the Feldman-Cousins method, explain in what circumstances (or parameter combinations) it is more likely to get positive `\( \Delta \)`TS values in the pseudo-trials `\( \Delta \)TS histogram` and in what circumstances it is more likely to get negative `\( \Delta \)`TS values.

Similarly, why might our likelihood minimizer be contributing to `\( \Delta \)TS that are not equal to 0? In your explanation, describe how IceCube's minimizer goes about trying to find the global minimum, using at least one math equation to explain how initial values are chosen, for a time-dependent analysis and explain what is and how the S/B threshold is used in this process. Give one idea on how to make it better at finding the minimum.`

Think step by step and solve the problem below. In your answer, you should include all intermediate derivations, formulas, important steps, and justifications for how you arrived at your answer. Be as detailed as possible in your response.

At the end of your response, write your final answer on a new line starting with "FINAL ANSWER".

## Expected Behavior

The agent should respond to the research problem following the rubric below.

## Grading Criteria

- [ ] Final answer provided
- [ ] Answer quality meets the rubric

## LLM Judge Rubric

Points: 1.0, Item: Correctly explains that the S/B threshold is defined as the event signal over the event background and is used to reduce computational time by not considering events under a specified S/B threshold. No points if solution does not correctly define the S/B threshold. No points if solution mentions that events under the S/B threshold are still used.
Points: 1.0, Item: Correctly states that the true `\( \Delta \)TS must be compared to the trial \( \Delta \)TS distribution. If student tries to compare other `parameters to the distribution then no points are awarded.
Points: 1.0, Item: Correctly states that we should be using signal trials. No points if attempts to use background trials.
Points: 0.5, Item: Correctly states that we should use the Feldman Cousins method instead of the Wilks' Contour method.
Points: 1.0, Item: Explanation of why we should use Feldman-Cousins includes the fact that the best-fit reaches the max allowed dt which means that Wilks' Theorem may not apply here.
Points: 1.0, Item: Must consider computational time when explaining the minimizer or in the explanation of improvement of the minimizer.
Points: 1.0, Item: Specifically describes TS`\( _{best-fit}\) `and TS`\( _{truth}\)` for pseudo-experiments and for true data and mentions that this needs to be done over all four parameters for both TS`\( _{best-fit}\) `and TS`\( _{truth}\)`.
Points: 1.5, Item: Specifies that signal trials must be injected with various combinations of **all** four parameter space values. No points if does not mention that signal needs to be injected over all four parameters (`\( \gamma \), \( T_0 \), dt, ns).`
Points: 2.0, Item: When explaining why positive `\( \Delta \mathrm{TS} \) occurs, the student must say that the best-fit \( \mathrm{TS} \) in this case likes to choose very long flares.`
