# Symbolic AI: Practicals

Practical material for Symbolic Artificial Intelligence (CS502K / CS507K) at the University of Aberdeen.
Six teaching days, delivered by Felipe Meneguzzi.

The lecture decks and the course-wide planning documents live in a separate repository, `Symbolic AI/lectures`.
Two files there govern this one:

- `Lectures-2026.md`: the running order, the practical mapping and the assessment timeline.
- `Practicals-Redesign.md`: the analysis behind the current rebuild, and the authority on what each practical is for.

This repository is mid-redesign.
The 2026-27 catalogue dropped Local Search, Adversarial Search and Reinforcement Learning, and added Planning Heuristics, HTN and Solving MDPs.
Day 5 was rebuilt for the new lectures on 2026-09-16 and the local-search notebook moved to [`archive/`](archive/).
Day 6 is the last one still to be revised, and [Status](#status) has the detail.

## Schedule

Two practical slots a week, Monday and Tuesday, and each assessment sat in a slot costs one of them.
Two of the six weeks therefore run a single practical each, and the other four run two, which is ten sessions in all.
`Lectures-2026.md` has the slot table and is the authority on it.

| Week | Day folder | Lectures | Practical |
| ---- | ---------- | -------- | --------- |
| 9  | `day01` | 1 Introduction, 2 Agents and Environments | Agents, rationality and problem formulation |
| 10 | `day02` | 3 Uninformed Search, 4 Informed Search | Search: paper tutorial and pathfinder coding |
| 11 | `day03` | 5 Propositional Logic, 6 First-Order Logic | Logic 1 (propositional) and Logic 2 (first-order) |
| 12 | `day04` | 7 Planning Formalism, 8 Planning Algorithms | PDDL modelling, one session, because Assessment 1 takes the Tuesday slot |
| 13 | `day05` | 9 Planning Heuristics, 10 Hierarchical Planning | Heuristics and benchmarking (Mon), HTN in HDDL (Tue). Assessment 3 is due on the Thursday |
| 14 | `day06` | 11 MDPs, 12 Solving MDPs | MDPs, one session, run alongside the Assessment 3 demos, so it must be self-paced and interruptible. Assessment 2 takes the Tuesday slot |

The week numbers above are the 2026-27 ones and move from year to year, so nothing outside this table depends on them.
Folder numbering is by teaching day, matching the `dayNN` folders in the lectures repository.
It is not lecture numbering: `day05` serves lectures 9 and 10.

## Catalogue

### `day01`: Agents, Rationality and Problem Formulation

Reworked 2026-08-27, and the first practical rebuilt for the 2026-27 catalogue.
Runs over both sessions of its week.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-1.tex` | Session 1, pen and paper. Eleven questions: five on AIMA Ch 1 (what counts as AI, the Turing test, evolution and rationality, science or engineering, "computers only do what they are told"), four on Ch 2 (true/false on rationality, PEAS, agent functions versus agent programs, stochastic vacuum worlds), one comparing the Wumpus World with the vacuum world, and one pointing at the notebook |
| `tutorial1-problem-formulation-solutions.ipynb` | The worked version of the notebook, instructor copy |
| `tutorial1-problem-formulation.ipynb` | Session 2, and self-contained: it defines the `Problem` class in a cell and imports nothing from this repository. Read a formulation of the 8-puzzle, write one for the vacuum world of Lecture 2, check the resulting state space against the lecture's graph, then generalise to n rooms. It contains no search algorithm, because students implement those in Tutorial 2 |

The notebook replaces `8-Puzzle.ipynb`, which was eight code cells of AIMA 4e with no markdown, no exercise and no connection to any question in the tutorial.

### `day02`: Search

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-2.tex` | Pen-and-paper tutorial. World state versus state description versus search node, the two-friends-meeting formulation with an admissibility question, the three-jugs formulation, an exercise on the PathFinding.js visualiser, and an `aima-python` exploration task |
| `tutorial2-search.ipynb` | The coded half. Breadth-first, depth-first and A\* over the maps in the notebook |

The coding half was written fresh on 2026-09-14 rather than imported from CS3033.

### `day03`: Logic

Rebuilt 2026-09-15 from the 2025-26 CS502K tutorials III and IV.
One tutorial per session, both pen and paper.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-3a.tex` | Session 1, Logic 1, propositional. Syntax against the grammar, English readings, truth tables for validity, following the model-enumeration entailment algorithm by hand, contradiction and contingency, evaluating $I(m, \alpha)$, a CNF procedure in pseudo-code, and an `aima-python` `PropKB` exercise |
| `CS502K-tutorial-week-3b.tex` | Session 2, Logic 2, first-order. Interpretations for quantified formulae, most general unifiers, representations for Generalised Modus Ponens, Skolemisation and the occurs check, a backward-chaining proof, a resolution refutation of Russell's paradox, resolution for validity and unsatisfiability, and an `aima-python` `FolKB` exercise |

No code of our own.
The last question of each tutorial sends students to `aima-python`'s `logic.ipynb`, which reorganised upstream in 2026 and needs its paths checked before the session.

### `day04`: Planning Formalisms

Converted from markdown to the LaTeX student and solutions build on 2026-09-16, and trimmed the same day to fit a single session, because Assessment 1 takes the Tuesday slot the next morning.

The two hours are split, since 2026-09-25.
The first is questions 1 to 5, in the online editor.
The second is question 6 on its own, the Assessment 1 rehearsal, which gives a warehouse in prose and no skeleton and asks for the four files Assessment 1 asks for, written against the clock.
Questions 7 and 8 go home.
The toolchain build is an expectation rather than a task, which is to arrive at the next tutorial having built it or having brought the error to a demonstrator.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-4.tex` | The tutorial. Eight questions: grounding and typing on the lecture's gripper domain, completing the cup-of-tea domain, diagnosing the `cheating/` model, validating a plan by hand, extending blocksworld to two grippers, modelling the warehouse from prose, building the toolchain, and two take-home extensions |
| `setting-up-a-local-planner.md` | Fast Downward, VAL and ENHSP, on all three platforms. On the critical path: question 7 is this guide, and so is Assessment 3 |
| `cup_of_tea/` | Deliver a cup of tea to grandpa. `domain.pddl` is a skeleton with `pick-up` blank and two TODO actions; `problem.pddl` and `solution.plan` are given |
| `cup_of_tea/cheating/` | A deliberately broken model, question 3: an action that achieves the goal in one step, and a `pick-up` with no delete effects. Shows that a returned plan is not evidence the model is right |
| `blocksworld/` | Extend blocksworld to two or more grippers. `blocksworld.pddl`, `demo.pddl`, and a JS visualiser |
| `solutions/` | Reference PDDL for questions 1, 2, 5, 6 and 8. The tutorial prints these files into the solutions PDF with `\pddlfile`, so the PDF and the solutions archive cannot drift apart |
| `solutions/warehouse/` | Question 6's reference, in both encodings: `domain.pddl` with the battery as levels and a `next` predicate, `domain-adl.pddl` with conditional effects, the scale-floor instance, the two-pallet check, an unsolvable instance, and the plans |
| `tutorial4-pddl.md` | Superseded by the `.tex`. Kept as the record of where the material came from |

This is the assessment-critical practical, because Assessments 1 and 3 both examine PDDL modelling.
Every reference solution was run under Fast Downward and checked with VAL on 2026-09-16 rather than reasoned about.

The toolchain setup went home on 2026-09-25, when the second hour became the modelling rehearsal, because a failed build must cost neither hour.
Demonstrators are free during question 6 for anyone who finishes early, and that is the last demonstrator contact before the next tutorial.
The three-configuration benchmark question moved to `day05` on 2026-09-16, because it needs Lecture 9.

### `day05`: Planning Heuristics and Hierarchical Planning

Built 2026-09-16, in the slot the retired local search practical used to occupy.
One tutorial per session, and the two are deliberately different in character: Monday feeds Assessment 3, which is due that Thursday, and Tuesday does not.

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-5a.tex` | Session 1, heuristics. The delete relaxation applied by hand, h-max and h-add on a two-ball gripper task, the relaxed planning graph, h-FF, a check against Fast Downward's own evaluators, the three-configuration comparison on the blocks world they wrote in Tutorial 4, and finally the same treatment of their own Assessment 3 domain |
| `CS502K-tutorial-week-5b.tex` | Session 2, HTN. Reading an HDDL domain, writing a partially ordered method, what ordering constraints buy, TFD on paper, and the same domain with the hierarchy removed |
| `gripper/` | The gripper domain of Lecture 7 and a two-ball instance: small enough to compute a heuristic by hand, and checkable against the planner |
| `travel/` | The travel domain of Lecture 10 in HDDL with `travel-by-plane` removed, its two problems, and the same domain as classical PDDL |
| `solutions/` | The reference domains, the plans, and the worked fragments the solutions PDFs print |

The planner for session 2 is [HyperTensioN](https://github.com/Maumagnaguagno/HyperTensioN), which is pure Ruby with no dependencies and no compile step, and which reads the HDDL the lecture slides show.
Session 1 uses the Fast Downward the students built in Tutorial 4.

Making the lecture's travel domain actually run found two errors on Lecture 10's HDDL frame, both corrected in the deck on 2026-09-16.
Ordering constraints were written infix where HDDL is prefix, and one of the three constraints was a duplicate while a fourth subtask was left unordered.

### `day06`: MDPs

| File | What it is |
| --- | --- |
| `tutorial6-mdp.ipynb` | `MDP` and `GridMDP` defined inline, then three stubs to fill: the body of `value_iteration`, `best_policy` and `expected_utility`. Around them, the value-iteration visualisation, the effect of the discount factor, policy iteration, and four comparison cases |
| `utils4e.py`, `notebook.py` | Vendored from `aimacode/aima-python` |
| `img/` | Figures |

The strongest coded practical here.
It predates the split of Lectures 11 and 12 and is not yet signposted for it.

### `archive/`

Material cut from the course, kept rather than deleted, mirroring the lectures repository's own `archive/`.
Currently `day05-local-search`: the N-Queens and TSP notebook that served the Local Search lecture until the 2026-27 redesign dropped it.
Nothing there is released or maintained.

## Building the LaTeX tutorials

Two variants come from one source, and the variant is chosen on the command line, never in the source.
The `\answer` macro is guarded by `\ifdefined\showanswers`, which only the Makefile's solutions rule defines.

```sh
make            # student PDFs and handout archives, then check none contains an answer
make solutions  # instructor PDFs, suffixed -solutions, banner-marked SOLUTIONS, plus the
                # solutions archives
make all        # both
make archives   # just the four zip files
make verify     # re-run the leak check
make clean      # remove latexmk auxiliary files
make distclean  # also remove the PDFs and the archives
```

Days 4 and 5 hand out a PDF and an archive of the files the student edits, and release a solutions PDF and an archive of the reference files.
`make` builds all four, and `verify-archive` fails the build if a student archive ever contains a reference solution or a completed skeleton.

`make verify` extracts the text of each student PDF and fails the build if the string `Answer:` appears.
Take that check seriously: a student-facing PDF did once ship with five worked answers in it, after someone left the answer toggle switched on.

All PDFs are gitignored.
Distribution happens through MyAberdeen, so the leak check is the only check standing between an edit and the cohort.
Run `make`, not `pdflatex`.

## Running the notebooks

The notebooks open in Colab and bootstrap themselves by cloning this repository, or run locally from within their day folder, since they import sibling modules by relative import:

```sh
cd day06 && jupyter notebook tutorial6-mdp.ipynb
```

There is no dependency file yet.
The notebooks currently need `numpy`, `matplotlib`, `seaborn` and `ipython`.

The Colab bootstrap cells hard-code the day folder in a `%cd`, so renaming or renumbering a day folder breaks them silently.
Grep for `%cd` before moving anything.

## Generative AI notice

Every student-facing tutorial and notebook states the University of Aberdeen Level 0 statement, no AI-generated content, alongside an instruction telling a coding assistant not to answer the exercises.
Applied across all six days on 2026-09-25.
One wording serves all of them, and it lives in [student-ai-instructions.md](student-ai-instructions.md): the verbatim policy text, ready-to-paste blocks for markdown, notebook metadata and LaTeX, and the list of files already using it.
Copy from there rather than rewriting, and add a line to that list when you apply it somewhere new.

## Solutions

Inconsistent, and being settled as part of the redesign:

- `day01` to `day05` build a separate `-solutions.pdf` from the same source. All are gitignored.
- `day04` and `day05` also have `solutions/`, reference files that the solutions PDF prints and that ship as a second archive.
- `day06` has no solutions at all, and never has. Its notebook leaves `value_iteration`, `best_policy` and `expected_utility` as `### Your code here` stubs, so it is the only exercise in the repository with no worked version anywhere.

The sibling course CS3033 keeps a public practicals repository and a private solutions repository.
Adopting that split is an open question in `Practicals-Redesign.md` section 5.

## Status

| Day | State |
| --- | --- |
| `day01` | **Reworked 2026-08-27.** Problem formulation covered, the notebook rebuilt, and a worked notebook alongside it |
| `day02` | Live. Paper tutorial plus a coding notebook, written 2026-09-14 |
| `day03` | **Rebuilt 2026-09-15.** Two paper tutorials and a shared notebook |
| `day04` | **Complete, 2026-09-25.** Converted to LaTeX 2026-09-16; the prose-only modelling task is now question 6 and fills the second hour. Both PDFs and both archives build, leak checks pass, and every reference domain is planner-verified. Outstanding: the planner setup guide has still not been tested on student machines |
| `day05` | **Built 2026-09-16.** Two tutorials, both planner-verified. Never delivered |
| `day06` | Live, and the last on pre-redesign material. Serves two lectures in one shared, interruptible session. Wants the signposting for Lectures 11 and 12, an automated test, and re-sizing for the slot it actually has |

`Practicals-Redesign.md` in the lectures repository has the full analysis, the comparison against CS3033, and the priority order.
