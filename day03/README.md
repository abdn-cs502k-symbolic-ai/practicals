# CS502K: Symbolic Artificial Intelligence

## Tutorial 03: Logic and Inference

Follows Lecture 5 (Propositional Logic) and Lecture 6 (First-Order Logic), and runs over both practical sessions of week 11.
There is one tutorial per session: Logic 1 covers propositional logic, Logic 2 covers first-order logic.
Both sessions share a single notebook.

Both tutorials were rebuilt from the 2025-26 CS502K tutorials III and IV, and extended on 2026-09-15.

### Goals

- Decide whether a formula is well formed, and say which grammar rule makes it so
- Read a formula back into English, and write English back into a formula
- Prove validity, satisfiability and contradiction by truth table, and say what each one means
- Follow the model-enumeration entailment algorithm by hand, and then implement it
- Decide what an agent may conclude in the Wumpus world, and what it may not
- Convert a formula to conjunctive normal form, and say why the order of the steps matters
- Construct a resolution refutation, in propositional and in first-order logic
- Trace forward and backward chaining over a Horn knowledge base, and say when each is the one to reach for
- Give an interpretation that makes a first-order formula true, and say what it means
- Unify a pair of atomic sentences, or say why no unifier exists
- Skolemise, convert to clausal form, and explain what the occurs check buys

### Session 1: Logic 1, propositional logic

Work through `CS502K-tutorial-week-3a.pdf`, which draws on Chapter 7 of Russell and Norvig.
Build the PDFs from the repository root:

```sh
make            # the student PDFs, then verify none of them contains an answer
make solutions  # the worked answers, for the lecturer
```

### Session 2: Logic 2, first-order logic

Work through `CS502K-tutorial-week-3b.pdf`, which draws on Chapters 8 and 9 of Russell and Norvig.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-3a.tex` | Session 1, propositional logic. Syntax, English readings, truth tables, model enumeration, the Wumpus knowledge base, CNF, resolution, and forward and backward chaining |
| `CS502K-tutorial-week-3b.tex` | Session 2, first-order logic. Interpretations, unification, Generalised Modus Ponens, Skolemisation and the occurs check, forward and backward chaining, and resolution |
| `tutorial3-logic.ipynb` | The coded half, spanning both sessions. Stubs and failing tests |
| `tutorial3-logic-solutions.ipynb` | The worked notebook. 35 tests, all passing. Release at the end of the week |

Each tutorial builds to a student PDF and a solutions PDF from one source.
The variant is chosen on the command line, never in the source.

### Notes for the lecturer

Every question carries a `%% SOURCE:` comment, as in day 1 and day 2, but the provenance here is weaker and the header block of each file says so.
Days 1 and 2 cite 3rd-edition exercise numbers checked against the 3e Instructor's Manual.
That manual could not be obtained when day 3 was annotated, so nothing here claims a printed exercise number.
The `aima-exercises` labels that are cited were checked by matching the exercise text and are reliable.
Filling in the printed numbers from the book is a ten-minute job for whoever has it to hand.

Five question groups had no lecture behind them before 2026-09-15.
Resolution was commented out of Lecture 5, and CNF, the propositional grammar, validity and satisfiability, and Skolemisation appeared nowhere in either deck, while the tutorials assumed all five.
Both lectures are already over budget, so the material went into a **bonus deck** in `../../lectures/day03` rather than into the lectures:
`ai-lecture05-bonus-slides-normal-forms` (18pp, 8 content frames in three sections).
It was briefly two decks, one per session, and was merged the same day: both lectures precede both sessions, so no student ever needs half of it.

The bonus deck is self-study, and this practical is the enforcement mechanism.
Both tutorials open by naming it and saying how long it takes, its second frame lists which tutorial question needs which slide across both sessions, and the questions genuinely cannot be answered without it.
A student who arrives without having read the deck will be stuck rather than merely underprepared, which costs session time.
Worth saying out loud in the lecture beforehand.

The bonus deck is not examined, settled 2026-09-15.
The objective test covers the lectures only, and `../../mcq/topics` has no question on resolution, CNF, Skolemisation, the occurs check or factoring, so nothing there needs changing.
It is offered as depth; this practical is the only place it is required, which is worth saying in the lecture beforehand.

Lecture 6's summary frame advertised resolution under propositional inference, which Lecture 5 did not deliver.
That line now points at the bonus deck.

The forward-chaining half of the arithmetic question is AIMA's, restored.
The inherited tutorial kept only the backward-chaining half, so nothing exercised the forward-chaining algorithm that Lecture 6 teaches.

The notebook's `to_cnf` is tested by equivalence, not by string comparison.
Several correct CNFs exist for one input and they differ in clause order, so a string test would fail correct work.
The final test in that section checks that resolution and model enumeration agree, which is the one most likely to catch a real bug.

### On generative AI

A language model answers most of these questions, and answers them well.
We know, and we set them anyway, because the point is to commit to a position and defend it in the session.
Assessment 1 is invigilated and Assessment 2 is proctored, so you sit both with no model available, and Assessment 3 ends in a defence of what you submitted.
Argue with a model if it helps; do not let it answer for you.
