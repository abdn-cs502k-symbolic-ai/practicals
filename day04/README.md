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
- **Model a domain from prose alone**, choosing the predicates, representing a resource without
  numbers, and writing an instance that makes the resource bite
- Build a local planner and validator, and know the two errors that most often stop them working

### The session

Two hours, split since 2026-09-25.

| | What runs | Where |
| --- | --- | --- |
| Hour 1 | Questions 1 to 5 | `editor.planning.domains`, nothing installed |
| Hour 2 | Question 6, the warehouse, on its own | The same editor, but from an empty file |
| Home | Questions 7 and 8 | Their own machine |

Question 6 is the Assessment 1 rehearsal and the reason the session is split. It gives a prose
scenario and no skeleton, names the same four deliverables Assessment 1 names, and times the hour
on the page. Question 7, the toolchain build, is stated as an expectation rather than a task:
students arrive in week 13 having built it or having brought the error to a demonstrator, and this
session is their last demonstrator contact before then. Anyone who finishes question 6 early
should start the build in the room.

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
| `CS502K-tutorial-week-4.tex` | The tutorial. Eight questions: grounding and typing on the lecture's gripper domain, completing the cup-of-tea domain, diagnosing the `cheating/` model, validating a plan by hand, extending blocksworld to two grippers, modelling the warehouse from prose, building the toolchain, and two take-home extensions |
| `setting-up-a-local-planner.md` | Fast Downward, VAL and ENHSP, on all three platforms. On the critical path: question 7 is this guide, and so is Assessment 3 |
| `cup_of_tea/` | Deliver a cup of tea to grandpa. `domain.pddl` is a skeleton with `pick-up` blank and two TODO actions; `problem.pddl` and `solution.plan` are given |
| `cup_of_tea/cheating/` | A deliberately broken model, question 3: an action that achieves the goal in one step, and a `pick-up` with no delete effects |
| `blocksworld/` | Extend blocksworld to two or more grippers. `blocksworld.pddl`, `demo.pddl`, and a JS visualiser |
| `solutions/` | Reference PDDL for questions 1, 2, 5, 6 and 8, pulled into the solutions PDF with `\verbatiminput` |
| `solutions/warehouse/` | Question 6's reference. `domain.pddl` keeps the battery as level objects with a `next` predicate, in pure STRIPS; `domain-adl.pddl` does the same job with conditional effects and a resetting recharge, which is the encoding the Assessment 1 reference itself uses. `problem1.pddl` is the scale-floor instance, `problem2.pddl` the two-pallet check, `problem3-unsolvable.pddl` the one students should be able to call unsolvable before running it |
| `tutorial4-pddl.md` | **Superseded** by the `.tex`. Kept as the record of where the material came from |

### Notes for the lecturer

**This is the assessment-critical practical.** Assessments 1 and 3 both examine PDDL modelling, and between them they carry 70% of the course.
Every reference solution was run under Fast Downward and checked with VAL on 2026-09-16, and question 6's on 2026-09-25, rather than reasoned about.
For the record on question 6: Fast Downward returns a 30-step plan for `problem1.pddl` under the STRIPS encoding with seven recharges, and 27 steps with four under the ADL one, both validated; `problem3-unsolvable.pddl` is proved unsolvable by exhaustion rather than timing out.

**Question 6 answers the gap that mattered.** Until 2026-09-25 nothing in this practical asked a student to choose a predicate vocabulary from prose, to model a resource without numbers, or to write a word about why they modelled something the way they did. Assessment 1 marks all three. Question 2 hands over the vocabulary and question 5 hands over a working domain to edit, so both rehearse the easier half.

**The toolchain setup is question 7, and it goes home.**
It was question 6 and in-session until 2026-09-25, when the second hour became the modelling rehearsal.
A build that goes wrong must eat neither hour, so it leaves the room with them, with the expectation stated in the question and again in the preamble: arrive in week 13 having built it, or having brought the error to a demonstrator.
Questions 1 to 6 all run in the online editor, so nothing in the session depends on the build.
This is the second revision of that instruction: students were told to install before arriving until 2026-09-16, when the session lost its second half.

**The blocks-world benchmark question moved to Tutorial 5a** on the same day.
It was the only question here that needed a built planner and multiple runs, and it asks students to interpret heuristics that Lecture 9 had not yet taught when this session runs.

**VAL rejects Fast Downward's plan files outright.**
It requires a time stamp in front of every action and Fast Downward writes none, so `sas_plan` fails to parse and VAL reports `Bad plan description!` and nothing else.
The setup guide said the opposite until 2026-09-16.
Question 6's answer and the guide's troubleshooting section both now carry the one-line conversion.
This matters more than it looks, because question 4 sends students to VAL and the error names nothing that would help them.
