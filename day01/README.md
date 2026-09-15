# CS502K: Symbolic Artificial Intelligence

## Tutorial 01: Agents, Rationality and Problem Formulation

Follows Lecture 1 (Introduction) and Lecture 2 (Agents and Environments), and runs over both practical sessions of week 9.

### Goals

- Argue about what makes a system intelligent, and about what the Turing test measures
- Give a PEAS description of a task environment and classify it
- Distinguish an agent function from an agent program
- Formulate a task as a search problem: initial state, actions, transition model, goal test, path cost
- Read a state space you have written and check it against the one in the lecture

### Session 1: pen and paper

Work through `CS502K-tutorial-week-1.pdf`.
The questions come from Chapters 1 and 2 of Russell and Norvig, and every one of them is meant to be argued rather than answered, so bring a position to the session.

Build the PDF from the repository root:

```sh
make            # the student PDFs
make solutions  # the worked answers, for the lecturer
```

### Session 2: problem formulation

Work through `tutorial1-problem-formulation.ipynb`, either in [Colab](https://colab.research.google.com/github/abdn-cs502k-symbolic-ai/practicals/blob/main/day01/tutorial1-problem-formulation.ipynb) or locally:

```sh
cd day01 && jupyter notebook tutorial1-problem-formulation.ipynb
```

The notebook is self-contained.
Everything it uses is defined in its own cells, so it runs wherever you open it, whether you clone this repository or download the notebook by itself.

You read a complete formulation of the 8-puzzle, write your own formulation of the two-room vacuum world, and check the state space you get against the graph on the *Example: Vacuum world state space graph* slide.
The notebook carries its own checks: run them, and get all six to pass.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-1.tex` | Session 1. Builds to a student PDF and a solutions PDF from one source |
| `tutorial1-problem-formulation.ipynb` | Session 2, with the formulations left as stubs |
| `tutorial1-problem-formulation-solutions.ipynb` | Session 2 worked, including answers to the discussion questions. Release after the session |

### Notes for the lecturer

Every question in the `.tex` carries a `%% SOURCE:` comment giving its Russell and Norvig third-edition exercise number, checked against the 3e Instructor's Manual on 2026-09-15.
Do not cite numbers from the online exercise set at `aimacode.github.io/aima-exercises`: that is the fourth edition and numbers the same exercises differently.

The vacuum-world solution offers all three actions in every state, which gives **8 states and 24 transitions** and matches the lecture's state-space figure exactly, self-loops included.
A student who offers only the actions that change something gets 13 transitions instead.
Both formulations are correct and admit the same solutions; Exercise 3 is written to make the difference surface.

The notebook defines the `Problem` class in a cell and contains no search algorithm.
You implement those in Tutorial 2, and shipping one here would hand you that answer.
You check a formulation by applying its transition model, without solving it.

### On generative AI

A language model writes every formulation in this tutorial correctly and in seconds.
We know, and we set the exercises anyway, because deciding what belongs in a state is a judgement that stays yours.
Assessment 1 is invigilated and Assessment 2 is proctored, so you sit both with no model available, and Assessment 3 ends in a defence of what you submitted.
Argue with a model if it helps; do not let it answer for you.
