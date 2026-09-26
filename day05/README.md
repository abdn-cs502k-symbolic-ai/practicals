# CS502K: Symbolic Artificial Intelligence

## Tutorial 05: Planning Heuristics and Hierarchical Planning

Follows Lecture 9 (Planning Heuristics) and Lecture 10 (Hierarchical Planning), and runs over both practical sessions of week 13.
There is one tutorial per session: 5a covers heuristics, 5b covers HTN planning.

Built 2026-09-16, and new: this is the slot the retired local search practical used to occupy.

### Goals

- Apply the delete relaxation to a set of action schemas, and say what is left of each one
- Compute h-max and h-add on a small task by hand, and say which is admissible and which is informative
- Build a relaxed planning graph, read h-max off its layers, and extract a relaxed plan for h-FF
- Check a hand-computed heuristic value against the planner's own, and know what to do when they disagree
- Run one domain under three planner configurations and explain the differences in terms of the domain
- Write a paragraph that makes a benchmark table into an argument, which is what Assessment 3 marks
- Read an HDDL domain, and say what a task, a method and a task network are
- Write a method with partially ordered subtasks, and say what an ordering constraint buys
- Trace TFD by hand over a decomposition
- Say what domain knowledge in an HTN domain actually carries, beyond search control

### Session 1: Planning heuristics

Work through `CS502K-tutorial-week-5a.pdf`, which draws on Section 11.3 of Russell and Norvig.
Build the PDFs from the repository root:

```sh
make            # the student PDFs and handout archives, then verify no answers leaked
make solutions  # the worked answers, for the lecturer
```

This session needs Fast Downward, which students build in question 7 of Tutorial 4.
It also needs their two-gripper blocks world from question 5 of that tutorial; the reference version in `../day04/solutions/blocksworld/` covers anyone who did not finish it.

### Session 2: Hierarchical planning

Work through `CS502K-tutorial-week-5b.pdf`, which draws on Section 11.4 of Russell and Norvig and Chapter 11 of Ghallab, Nau and Traverso.

This session needs Ruby and nothing else.
The planner is [HyperTensioN](https://github.com/Maumagnaguagno/HyperTensioN), which students clone and run directly: it is pure Ruby with no dependencies and no compile step.
MacOS and Linux ship Ruby; Windows needs RubyInstaller or WSL.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-5a.tex` | Session 1, heuristics. Delete relaxation, h-max and h-add by hand, the relaxed planning graph, h-FF, checking against the planner, the three-configuration comparison, and the student's own Assessment 3 domain |
| `CS502K-tutorial-week-5b.tex` | Session 2, HTN. Reading an HDDL domain, writing a partially ordered method, ordering constraints, TFD on paper, and the same domain with the hierarchy removed |
| `gripper/` | The gripper domain of Lecture 7 and a two-ball instance, small enough to compute a heuristic by hand and large enough for Fast Downward to confirm it |
| `travel/` | The travel domain of Lecture 10 in HDDL, with `travel-by-plane` removed for question 2, its two problems, and the same domain as classical PDDL for question 5 |
| `solutions/` | Reference method, plans and worked fragments. The tutorials `\verbatiminput` these into the solutions PDFs, so the PDFs and the solutions archive cannot drift apart |

Each tutorial builds to a student PDF and a solutions PDF from one source.
The variant is chosen on the command line, never in the source.
Both sessions share one handout archive, `tutorial-week-5-files.zip`, which the `Makefile` builds and leak-checks.

### Notes for the lecturer

Every number in both solutions PDFs was produced by running the tools.
The heuristic values in 5a questions 2 and 3 were computed by fixpoint iteration and then confirmed against Fast Downward's own `hmax()`, `add()` and `ff()` evaluators: 2, 6 and 5 respectively against an optimal cost of 7.
Every plan in 5b came out of HyperTensioN or Fast Downward on 2026-09-16.

Tutorial 5a question 5 was question 6 of Tutorial 4 until 2026-09-16.
It moved because week 12 has one practical session rather than two, Assessment 1 having taken the Tuesday slot, and because interpreting a benchmark belongs after the heuristics lecture rather than before it.
Tutorial 4 is now formalisation and debugging, and ends with the toolchain setup.

Lecture 10's HDDL frame had two errors, found by making the domain run.
It wrote ordering constraints infix, `(task0 < task2)`, where HDDL is prefix, `(< task0 task2)`; and it ordered `task0` before `task2` twice while never ordering `task1` at all.
The deck was corrected on 2026-09-16.
Question 3(a) of tutorial 5b now has students reproduce the parse error deliberately, because the traceback it produces names a Ruby method and says nothing about ordering, and reading an error of that shape once is worth more than being handed the right syntax.

Question 5 of tutorial 5b is the one to protect if the session runs short.
Removing the methods from the travel domain and running it classically returns a four-action plan that takes a taxi from Porto Alegre to São Paulo's airport, 1,100 kilometres, because `longDistance` is asserted between cities and never between a city and another city's airport.
The hierarchy had been hiding an incomplete action model, and no method ever proposed the journey that exposes it.
This was found by running it rather than designed, it is the best argument on the course for what methods actually carry, and it pairs exactly with Tutorial 4's `cheating/` domain: there the plan was absurd and visible, here it was hidden by the hierarchy.

Tutorial 5b is deliberately self-contained, question by question.
It runs on the Tuesday of week 13, two days before Assessment 3 is due, and it is examined only in the objective test.
Students will be triaging their time, so no question depends on the previous one having worked, and a student pulled away after question 2 has still had the point of the lecture.

Neither tutorial has been delivered.
So has neither lecture, in this shape. Treat the first delivery as the measurement.

### On generative AI

A model computes these heuristic values correctly and writes the missing method in one go.
The questions are set anyway, and each tutorial says why in its own preamble: 5a because a model will also write you a paragraph of benchmark analysis that reads well and says nothing, which is the failure mode Assessment 3 marks against; 5b because question 5's result is one most models get wrong when asked to predict it.
Assessment 2 is proctored and Assessment 3 ends in a defence.
