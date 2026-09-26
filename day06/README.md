# CS502K: Symbolic Artificial Intelligence

## Tutorial 06: Markov Decision Processes

Follows Lecture 11 (MDPs) and Lecture 12 (Solving MDPs), and runs in the single practical session of its week.
That week has one session rather than two, because Assessment 2 takes the other slot, and the remaining session is shared with the Assessment 3 demonstrations.

The paper tutorial was built on 2026-09-26 from the Chapter 17 exercises of Russell and Norvig, with the answers copied from the third-edition Instructor's Manual.
The notebook predates the redesign, and gained its solutions copy and its instruction to AI assistants the same day.

### Goals

- Compute where a stochastic action sequence can take an agent, and with what probability
- Say what stationary preferences require, and why additive discounted rewards satisfy it
- Write the Bellman equation in the AIMA form, $R(s)$, and in the Sutton and Barto form, $R(s, a)$, and convert one into the other
- Prove that the Bellman update is a contraction, which is why value iteration converges
- Run value iteration in code and read the policy it produces against the reward that produced it
- Say what the discount factor decides, with a case where a threshold value of $\gamma$ flips the decision
- Run policy iteration by hand, and say what an undiscounted MDP with a bad initial policy does to it
- Show that a dominant strategy equilibrium is a Nash equilibrium, find one by iterated dominance, and say whether it is Pareto optimal

### The session

Work through `CS502K-tutorial-week-6.pdf` and `tutorial6-mdp.ipynb` in whichever order suits.
The tutorial's question 5 uses the notebook's code, and the notebook's own checks are the check on question 10.
No question depends on the previous one having been finished, because students leave the room for their Assessment 3 demonstration and return.

Build the PDFs from the repository root:

```sh
make            # the student PDFs, then verify none of them contains an answer
make solutions  # the worked answers, for the lecturer
```

Run the notebook either in [Colab](https://colab.research.google.com/github/abdn-cs502k-symbolic-ai/practicals/blob/main/day06/tutorial6-mdp.ipynb) or locally:

```sh
cd day06 && jupyter notebook tutorial6-mdp.ipynb
```

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-6.tex` | The paper tutorial. Builds to a student PDF and a solutions PDF from one source. Nine questions from AIMA Chapter 17 and one pointing at the notebook: reachability under stochastic actions, stationary preferences, the three reward formulations, the contraction proof, a $3 \times 3$ world under four rewards, the $101 \times 3$ pollution world, policy iteration by hand on a three-state MDP, dominant strategy versus Nash equilibrium, and the Fed versus the politicians |
| `tutorial6-mdp.ipynb` | The notebook. `MDP` and `GridMDP` are given; the bodies of `value_iteration`, `best_policy` and `expected_utility` are left as `### Your code here` stubs |
| `tutorial6-mdp-solutions.ipynb` | The notebook with the three stubs filled. Every cell runs, and the `expected_utility` check passes. Release after the session |
| `utils4e.py`, `notebook.py` | Vendored from `aima-python`. Library code, not coursework: do not refactor it |
| `img/` | The two grid-world figures the notebook shows |

### Notes for the lecturer

Every question in the `.tex` has a `%% SOURCE:` comment giving its third-edition exercise number, and every answer marked verbatim was copied from the 3e Instructor's Manual on 2026-09-26 from the page images, not from a text extraction, because the extraction mangles the mathematics.
The manual's text is reproduced as printed, slips included, and the SOURCE comment on each question says where the slips are.

Question 7, the three-state policy iteration, has the one that matters.
The manual's second value determination prints $u_2 = -15$; the equation it writes, $u_2 = -2 + 0.8u_1 + 0.2u_2$ with $u_1 = -10$, gives $u_2 = -12.5$, and the four action values that follow are wrong with it.
The policy comparison comes out the same way, so the conclusion stands and the numbers on the page do not.
Decide before releasing the solutions whether to ship the manual's numbers or the corrected ones; the source comment has both.

Every number that could be recomputed was: the occupancy table in question 1, all five policies in question 5, the indifference discount in question 6, and both rounds of question 7, using the notebook's own `GridMDP` and the reference `value_iteration`.
That check found the `GridMDP` trap: the vendored class tests each grid entry for truth when it builds the state set, so a reward of exactly 0 deletes the square, and question 5(c) cannot be run as the book states it.
The question tells students to use 0.001 instead, which returns the manual's policy exactly.
The vendored code is left as it is.

The notebook had no solutions before 2026-09-26, and was recorded everywhere as a walkthrough with nothing to solve.
It has three stubs, and the same belief had left it as the only notebook without an instruction to AI assistants.
Both are fixed.

Still outstanding from `Practicals-Redesign.md`: CS3033's `week08/test_mdp.py` has not been taken, and the notebook is not signposted for which of its halves serves which lecture.

### On generative AI

A language model answers every question here, and fills all three notebook stubs, in seconds.
We set them anyway, because Assessment 2 is proctored and covers this material, and a value iteration you have run by hand once is one you can run again under the clock.
Argue with a model if it helps; do not let it answer for you.
