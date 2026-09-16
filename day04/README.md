# CS502K: Symbolic Artificial Intelligence

## Tutorial 04: Planning Formalisms

Follows Lecture 7 (Planning Formalism) and Lecture 8 (Planning Algorithms), and runs in the single practical session of week 12.
**Week 12 has one session rather than two**, because Assessment 1 takes the Tuesday slot the following morning.

Converted from markdown to the LaTeX student and solutions build on 2026-09-16, and trimmed the same day when the benchmark question moved to Tutorial 5a.

### Goals

- Ground a set of action schemas by hand, and say what typing buys and what it does not
- Complete a partial PDDL domain from a description of the world
- Diagnose a domain that returns a valid plan for a model that is wrong
- Validate a plan by hand, step by step, and then against VAL
- Extend a domain to a resource it did not have, and deal with what that breaks
- Build a local planner and validator, and know the two errors that most often stop them working

### The session

Work through `CS502K-tutorial-week-4.pdf`.
Build the PDFs and the handout archives from the repository root:

```sh
make            # the student PDFs and archives, then verify no answers leaked
make solutions  # the worked answers and the solutions archive, for the lecturer
```

The handout is a PDF **plus** `tutorial-week-4-files.zip`, because the deliverable is partly files the student edits.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-4.tex` | The tutorial. Seven questions: grounding and typing on the lecture's gripper domain, completing the cup-of-tea domain, diagnosing the `cheating/` model, validating a plan by hand and with VAL, extending blocksworld to two grippers, building the toolchain, and two take-home extensions |
| `setting-up-a-local-planner.md` | Fast Downward, VAL and ENHSP, on all three platforms. On the critical path: question 6 is this guide, and so is Assessment 3 |
| `cup_of_tea/` | Deliver a cup of tea to grandpa. `domain.pddl` is a skeleton with `pick-up` blank and two TODO actions; `problem.pddl` and `solution.plan` are given |
| `cup_of_tea/cheating/` | A deliberately broken model, question 3: an action that achieves the goal in one step, and a `pick-up` with no delete effects |
| `blocksworld/` | Extend blocksworld to two or more grippers. `blocksworld.pddl`, `demo.pddl`, and a JS visualiser |
| `solutions/` | Reference PDDL for questions 1, 2, 5 and 7, pulled into the solutions PDF with `\verbatiminput` |
| `tutorial4-pddl.md` | **Superseded** by the `.tex`. Kept as the record of where the material came from |

### Notes for the lecturer

**This is the assessment-critical practical.** Assessments 1 and 3 both examine PDDL modelling, and between them they carry 70% of the course.
Every reference solution was run under Fast Downward and checked with VAL on 2026-09-16 rather than reasoned about.

**The toolchain setup is question 6, and it is last on purpose.**
Week 12 is a single block, so a compile that goes wrong has to cost the end of the session rather than the start of it.
Questions 1 to 5 all run in the online editor.
This reversed the earlier instruction to install before arriving, on 2026-09-16, when the session lost its second half.

**The blocks-world benchmark question moved to Tutorial 5a** on the same day.
It was the only question here that needed a built planner and multiple runs, and it asks students to interpret heuristics that Lecture 9 had not yet taught when this session runs.

**VAL rejects Fast Downward's plan files outright.**
It requires a time stamp in front of every action and Fast Downward writes none, so `sas_plan` fails to parse and VAL reports `Bad plan description!` and nothing else.
The setup guide said the opposite until 2026-09-16.
Question 6's answer and the guide's troubleshooting section both now carry the one-line conversion.
This matters more than it looks, because question 4 sends students to VAL and the error names nothing that would help them.
