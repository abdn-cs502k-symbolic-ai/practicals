# Symbolic AI: Practicals

Practical material for **Symbolic Artificial Intelligence (CS502K / CS507K)** at the University of
Aberdeen. Six teaching days, weeks 9 to 14, delivered by Felipe Meneguzzi.

The lecture decks and the course-wide planning documents live in a separate repository,
`Symbolic AI/lectures`. Two files there govern this one:

- `Lectures-2026.md`: the running order, the practical mapping and the assessment timeline.
- `Practicals-Redesign.md`: the analysis behind the current rebuild, and the authority on what
  each practical is for.

> **This repository is mid-redesign.** The 2026-27 catalogue dropped Local Search, Adversarial
> Search and Reinforcement Learning, and added Planning Heuristics, HTN and Solving MDPs. Day 5
> still holds the retired local-search notebook. See
> [Status](#status).

## Schedule

Two practical sessions a week, Monday and Tuesday, except where an assessment takes one.
Practical names follow `Lectures-2026.md` and are **provisional**.

| Week | Day folder | Lectures | Practical |
| ---- | ---------- | -------- | --------- |
| 9  | `day01` | 1 Introduction, 2 Agents and Environments | Agents, rationality and problem formulation |
| 10 | `day02` | 3 Uninformed Search, 4 Informed Search | Search: paper tutorial and pathfinder coding |
| 11 | `day03` | 5 Propositional Logic, 6 First-Order Logic | Logic 1 (propositional) and Logic 2 (first-order) |
| 12 | `day04` | 7 Planning Formalism, 8 Planning Algorithms | PDDL modelling. Assessment 1 takes the Tuesday slot |
| 13 | `day05` | 9 Planning Heuristics, 10 Hierarchical Planning | Relaxation heuristics and HTN decomposition |
| 14 | `day06` | 11 MDPs, 12 Solving MDPs | MDPs. Runs alongside the Assessment 3 demos, so it must be self-paced and interruptible. Assessment 2 takes the Tuesday slot |

Folder numbering is by **teaching day**, matching the `dayNN` folders in the lectures repository.
It is not lecture numbering: `day05` serves lectures 9 and 10.

## Catalogue

### `day01`: Agents, Rationality and Problem Formulation

Reworked 2026-08-27, and the first practical rebuilt for the 2026-27 catalogue. Runs over both
sessions of week 9.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-1.tex` | Session 1, pen and paper. Twelve questions: five on AIMA Ch 1 (what counts as AI, the Turing test, evolution and rationality, science or engineering, "computers only do what they are told"), four on Ch 2 (true/false on rationality, PEAS, agent functions versus agent programs, stochastic vacuum worlds), one comparing the Wumpus World with the vacuum world, and one pointing at the notebook |
| `tutorial1-problem-formulation.ipynb` | Session 2, and **self-contained**: it defines the `Problem` class in a cell and imports nothing from this repository. Read a formulation of the 8-puzzle, write one for the vacuum world of Lecture 2, check the resulting state space against the lecture's graph, then generalise to n rooms. Carries **no search algorithm**, because students implement those in Tutorial 2 |

The notebook replaces `8-Puzzle.ipynb`, which was eight code cells of AIMA 4e with no markdown,
no exercise and no connection to any question in the tutorial.

### `day02`: Search

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-2.tex` | Pen-and-paper tutorial. World state versus state description versus search node, the two-friends-meeting formulation with an admissibility question, the three-jugs formulation, an exercise on the PathFinding.js visualiser, and an `aima-python` exploration task |

No code. The lectures for this day are the two search lectures, so this is the thinnest coverage
on the course relative to what is taught.

### `day03`: Logic

Rebuilt 2026-09-15 from the 2025-26 CS502K tutorials III and IV. One tutorial per session, both
pen and paper.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-3a.tex` | Session 1, Logic 1, propositional. Syntax against the grammar, English readings, truth tables for validity, following the model-enumeration entailment algorithm by hand, contradiction and contingency, evaluating $I(m, \alpha)$, a CNF procedure in pseudo-code, and an `aima-python` `PropKB` exercise |
| `CS502K-tutorial-week-3b.tex` | Session 2, Logic 2, first-order. Interpretations for quantified formulae, most general unifiers, representations for Generalised Modus Ponens, Skolemisation and the occurs check, a backward-chaining proof, a resolution refutation of Russell's paradox, resolution for validity and unsatisfiability, and an `aima-python` `FolKB` exercise |

No code of our own. The last question of each tutorial sends students to `aima-python`'s
`logic.ipynb`, which reorganised upstream in 2026 and needs its paths checked before the session.

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
`Answer:` appears. Take that check seriously: a student-facing PDF did once ship with five worked
answers in it, after someone left the answer toggle switched on.

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

- `day01`, `day02` and `day03` build a separate `-solutions.pdf` from the same source. All are
  gitignored.
- `day04` has no reference solution at all.
- `day06` ships worked code inline, since it is a walkthrough rather than an exercise.

The sibling course CS3033 keeps a public practicals repository and a private solutions
repository. Adopting that split is an open question in `Practicals-Redesign.md` §5.

## Status

| Day | State |
| --- | --- |
| `day01` | **Reworked 2026-08-27.** Problem formulation now covered and the notebook rebuilt. No worked solution for the notebook yet |
| `day02` | Live, paper only. Wants a coding half |
| `day03` | **Rebuilt 2026-09-15**, paper only. Wants a coded half of its own rather than pointing at `aima-python` |
| `day04` | Live. Assessment-critical, and missing the challenge/solution structure it needs |
| `day05` | Retired content in place, replacement not designed |
| `day06` | Live. Wants signposting for the L11/L12 split and an automated test |

`Practicals-Redesign.md` in the lectures repository carries the full analysis, the comparison
against CS3033, and the priority order.
