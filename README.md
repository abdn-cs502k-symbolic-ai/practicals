# Symbolic AI: Practicals

Practical material for **Symbolic Artificial Intelligence (CS502K / CS507K)** at the University of
Aberdeen. Six teaching days, weeks 9 to 14, delivered by Felipe Meneguzzi.

The lecture decks and the course-wide planning documents live in a separate repository,
`Symbolic AI/lectures`. Two files there govern this one:

- `Lectures-2026.md`: the running order, the practical mapping and the assessment timeline.
- `Practicals-Redesign.md`: the analysis behind the current rebuild, and the authority on what
  each practical is for.

> **This repository is mid-redesign.** The 2026-27 catalogue dropped Local Search, Adversarial
> Search and Reinforcement Learning, and added Planning Heuristics, HTN and Solving MDPs. Day 3
> has no material yet and Day 5 still holds the retired local-search notebook. See
> [Status](#status).

## Schedule

Two practical sessions a week, Monday and Tuesday, except where an assessment takes one.
Practical names follow `Lectures-2026.md` and are **provisional**.

| Week | Day folder | Lectures | Practical |
| ---- | ---------- | -------- | --------- |
| 9  | `day01` | 1 Introduction, 2 Agents and Environments | Agents, rationality and problem formulation |
| 10 | `day02` | 3 Uninformed Search, 4 Informed Search | Search: paper tutorial and pathfinder coding |
| 11 | `day03` | 5 Propositional Logic, 6 First-Order Logic | Logic, entailment and SAT |
| 12 | `day04` | 7 Planning Formalism, 8 Planning Algorithms | PDDL modelling. Assessment 1 takes the Tuesday slot |
| 13 | `day05` | 9 Planning Heuristics, 10 Hierarchical Planning | Relaxation heuristics and HTN decomposition |
| 14 | `day06` | 11 MDPs, 12 Solving MDPs | MDPs. Runs alongside the Assessment 3 demos, so it must be self-paced and interruptible. Assessment 2 takes the Tuesday slot |

Folder numbering is by **teaching day**, matching the `dayNN` folders in the lectures repository.
It is not lecture numbering: `day05` serves lectures 9 and 10.

## Catalogue

### `day01`: Introduction and Agents

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-1.tex` | Pen-and-paper tutorial. Ten live questions: four on AIMA Ch 1 (what counts as AI, evolution and rationality, science or engineering, "computers only do what they are told"), five on Ch 2 (true/false on rationality, a PEAS description exercise, agent functions versus agent programs, agent programs for stochastic vacuum worlds), and two on getting started with `aima-python`. Much of the file is commented-out material from earlier years, including the Turing test question |
| `8-Puzzle.ipynb` | Eight code cells lifted from AIMA 4e: `Problem`, `Node`, the queues, breadth-first search and `EightPuzzle`. **No markdown, no exercise, no instructions.** Unattached to any question in the tutorial |

### `day02`: Search

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-2.tex` | Pen-and-paper tutorial. World state versus state description versus search node, the two-friends-meeting formulation with an admissibility question, the three-jugs formulation, an exercise on the PathFinding.js visualiser, and an `aima-python` exploration task |

No code. The lectures for this day are the two search lectures, so this is the thinnest coverage
on the course relative to what is taught.

### `day03`: Reasoning

`README.md` only. **There is no material.** A full teaching day, two lectures, no practical.

### `day04`: Planning Formalisms

| File | What it is |
| --- | --- |
| `tutorial4-pddl.md` | The walkthrough. Two modelling tasks, with links to the editor and to video tutorials |
| `setting-up-a-local-planner.md` | Offline route, via the VSCode PDDL plugin |
| `cup_of_tea/` | Deliver a cup of tea to grandpa. `domain.pddl` is a skeleton with `pick-up` blank and two TODO actions; `problem.pddl` and `solution.plan` are given |
| `cup_of_tea/cheating/` | A deliberately broken model kept as a teaching example: an action that achieves the goal in one step, and a `pick-up` with no delete effects. Shows that a returned plan is not evidence the model is right |
| `blocksworld/` | Extend blocksworld to two or more grippers. `blocksworld.pddl`, `demo.pddl`, and a JS visualiser |

This is the assessment-critical practical: Assessments 1 and 3 both examine PDDL modelling.
There is currently **no reference solution** for either task.

### `day05`: Local Search (retired)

| File | What it is |
| --- | --- |
| `tutorial5-local-search.ipynb` | N-Queens by hill climbing, random restarts and simulated annealing, plus a TSP genetic algorithm |
| `localSearch.py`, `nqueens.py`, `printBoard.py` | Supporting modules |
| `tsp/` | Five TSPLIB instances |

**Orphaned.** Local search left the syllabus in the 2026-27 redesign. The folder is where the
heuristics and HTN practical will go; the notebook should be archived, not deleted.

### `day06`: MDPs

| File | What it is |
| --- | --- |
| `tutorial6-mdp.ipynb` | `MDP` and `GridMDP` defined inline, value iteration with a visualisation, the effect of the discount factor, policy iteration, and four comparison cases |
| `utils4e.py`, `notebook.py` | Vendored from `aimacode/aima-python` |
| `img/` | Figures |

The strongest coded practical here. It predates the L11/L12 split and is not yet signposted for it.

## Building the LaTeX tutorials

Two variants come from one source. **The variant is chosen on the command line, never in the
source**: the `\answer` macro is guarded by `\ifdefined\showanswers`, which only the Makefile's
solutions rule defines.

```sh
make            # student PDFs, then check none of them contains an answer
make solutions  # instructor PDFs, suffixed -solutions, banner-marked SOLUTIONS
make all        # both
make verify     # re-run the leak check
make clean      # remove latexmk auxiliary files
make distclean  # also remove the PDFs
```

`make verify` extracts the text of each student PDF and **fails the build** if the string
`Answer:` appears. This is a backstop, not a formality: a student-facing PDF did once ship with
five worked answers in it, because the toggle was a comment someone forgot to restore.

All PDFs are gitignored. Distribution happens through MyAberdeen, so **the leak check is the only
thing standing between an edit and the cohort**. Run `make`, not `pdflatex`.

## Running the notebooks

The notebooks open in Colab and bootstrap themselves by cloning this repository, or run locally
from within their day folder, since they import sibling modules by relative import:

```sh
cd day06 && jupyter notebook tutorial6-mdp.ipynb
```

There is no dependency file yet. The notebooks currently need `numpy`, `matplotlib`, `seaborn`
and `ipython`.

Note that the Colab bootstrap cells hard-code the day folder in a `%cd`, so **renaming or
renumbering a day folder breaks them silently**. Grep for `%cd` before moving anything.

## Solutions

Inconsistent, and being settled as part of the redesign:

- `day01` and `day02` build a separate `-solutions.pdf` from the same source. Both are gitignored.
- `day04` has no reference solution at all.
- `day06` ships worked code inline, since it is a walkthrough rather than an exercise.

The sibling course CS3033 keeps a public practicals repository and a private solutions
repository. Adopting that split is an open question in `Practicals-Redesign.md` §5.

## Status

| Day | State |
| --- | --- |
| `day01` | Live. Needs a problem-formulation exercise: the topic moved into Lecture 2 and no question covers it |
| `day02` | Live, paper only. Wants a coding half |
| `day03` | **Empty.** Highest-priority new material after `day04` |
| `day04` | Live. Assessment-critical, and missing the challenge/solution structure it needs |
| `day05` | Retired content in place, replacement not designed |
| `day06` | Live. Wants signposting for the L11/L12 split and an automated test |

`Practicals-Redesign.md` in the lectures repository carries the full analysis, the comparison
against CS3033, and the priority order.
