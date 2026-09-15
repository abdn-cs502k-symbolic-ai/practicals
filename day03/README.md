# CS502K: Symbolic Artificial Intelligence

## Tutorial 03: Logic and Inference

Follows Lecture 5 (Propositional Logic) and Lecture 6 (First-Order Logic), and runs over both
practical sessions of week 11. There is one tutorial per session: Logic 1 covers propositional
logic, Logic 2 covers first-order logic.

Both were rebuilt from the 2025-26 CS502K tutorials III and IV.

### Goals

- Decide whether a formula is well formed, and say which grammar rule makes it so
- Read a formula back into English, and write English back into a formula
- Prove validity, satisfiability and contradiction by truth table, and say what each one means
- Follow the model-enumeration entailment algorithm by hand
- Convert a formula to conjunctive normal form, and say why the order of the steps matters
- Give an interpretation that makes a first-order formula true, and say what it means
- Unify a pair of atomic sentences, or say why no unifier exists
- Skolemise, convert to clausal form, and construct a resolution refutation
- Give a backward-chaining proof from a fixed set of axioms

### Session 1: Logic 1, propositional logic

Work through `CS502K-tutorial-week-3a.pdf`. The questions come from Chapters 7 and 8 of Russell
and Norvig. Build the PDF from the repository root:

```sh
make            # the student PDFs
make solutions  # the worked answers, for the lecturer
```

### Session 2: Logic 2, first-order logic

Work through `CS502K-tutorial-week-3b.pdf`. The questions come from Chapters 9 and 12 of Russell
and Norvig.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-3a.tex` | Session 1, propositional logic. Syntax, English readings, truth tables, model enumeration, interpretations, CNF, and an `aima-python` `PropKB` exercise |
| `CS502K-tutorial-week-3b.tex` | Session 2, first-order logic. Interpretations, unification, Generalised Modus Ponens, Skolemisation and the occurs check, backward chaining, resolution, and an `aima-python` `FolKB` exercise |

Each builds to a student PDF and a solutions PDF from one source. The variant is chosen on the
command line, never in the source.

### Open items

- The last question of each tutorial points at `aima-python`'s `logic.ipynb` rather than at a
  notebook of our own. Upstream reorganised in 2026, so the paths in those questions need
  checking against the current repository before the session.
- No coded half. Every other day with a coding component ships a notebook; this one sends
  students to somebody else's.

### On generative AI

A language model answers most of these questions, and answers them well. We know, and we set them
anyway, because the point is to commit to a position and defend it in the session. Assessment 1 is
invigilated and Assessment 2 is proctored, so you sit both with no model available, and Assessment
3 ends in a defence of what you submitted. Argue with a model if it helps; do not let it answer
for you.
