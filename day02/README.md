# CS502K: Symbolic Artificial Intelligence

## Tutorial 02: Search

Follows Lecture 3 (Uninformed Search) and Lecture 4 (Informed Search), and runs over both practical sessions of week 10.

### Goals

- Distinguish a world state, a state description and a search node, and say why the distinction matters
- Formulate an unfamiliar problem as a search problem, and judge whether a proposed heuristic is admissible
- Trace uniform-cost, greedy best-first and A\* search by hand, counting the nodes each expands
- Implement those algorithms against the `Problem` interface from week 9
- Measure what a dominating heuristic buys, and read the measurement

### Session 1: pen and paper

Work through `CS502K-tutorial-week-2.pdf`.
Questions 1 to 4 come from Chapter 3 of Russell and Norvig.
Question 5 is the hand trace that session 2 checks your code against, and question 6 sets up the heuristics half of that notebook.

Build the PDF from the repository root:

```sh
make            # the student PDFs
make solutions  # the worked answers, for the lecturer
```

### Session 2: implementing search

Work through `tutorial2-search.ipynb`, either in [Colab](https://colab.research.google.com/github/abdn-cs502k-symbolic-ai/practicals/blob/main/day02/tutorial2-search.ipynb) or locally:

```sh
cd day02 && jupyter notebook tutorial2-search.ipynb
```

The notebook is self-contained.
Everything it uses is defined in its own cells, so it runs wherever you open it, whether you clone this repository or download the notebook by itself.

Week 9 gave students the `Problem` class and no search algorithm.
This notebook supplies the other half: they write one best-first graph search loop, then define uniform-cost, greedy and A\* as that loop under different node orderings, and breadth-first search separately because it tests for the goal on generation.
The checks compare the result against the hand trace from session 1.

### Files

| File | What it is |
| --- | --- |
| `CS502K-tutorial-week-2.tex` | Session 1. Builds to a student PDF and a solutions PDF from one source |
| `tutorial2-search.ipynb` | Session 2, with the algorithms left as stubs |
| `tutorial2-search-solutions.ipynb` | Session 2 worked, including answers to the discussion questions. Release after the session |

Every question in the `.tex` carries a `%% SOURCE:` comment giving its Russell and Norvig third-edition exercise number, checked against the 3e Instructor's Manual on 2026-09-15.

### Notes for the lecturer

The Romania expansion counts the notebook asserts are 12 for uniform-cost search, 3 for greedy and 5 for A\*, and the solution costs are 418, 450 and 418.
Those counts hold under every tie-breaking rule tested (insertion order, reverse insertion order, alphabetical by state, and `Node.__lt__`), so a correct student implementation reaches them regardless of how its priority queue resolves equal `f` values.

The 8-puzzle counts in Part 2 are **not** tie-break invariant, which is why that cell reports them instead of asserting them.
On the reference implementation the instance `(7, 2, 4, 5, 0, 6, 8, 3, 1)` gives 49039 expansions with no heuristic, 3666 with $h_1$ and 282 with $h_2$, all returning a 20-move solution.
The ordering is the point, and the ordering is stable.

Question 5(e) and Exercise 3 both turn on counting expansions the same way the lectures do: a node is expanded when its successors are generated, so the goal node is selected and returned without ever being expanded.
Most disagreements with the lecture's figures are this off-by-one.

**Lecture 4 contradicts itself on two heuristic values, and the tutorial follows the table.** The `h_SLD` table printed beside the Romania map gives Fagaras 178 and Pitesti 98, which are the AIMA 2e values.
The four A\* tree figures in the same lecture print `415 = 239 + 176` and `417 = 317 + 100`, which are the 3e values.
The tutorial and the notebook both use the table's numbers, because the table is what students read `h` off.

The only thing this changes is which of Fagaras and Pitesti A\* expands fourth.
With the table, Pitesti (415) comes before Fagaras (417); the tree figures draw the reverse.
A\* expands the same five nodes, takes the same five expansions and returns the same 418 km path either way, so every count asserted above holds regardless.
Question 5(c) states the caveat to students and tells them to accept either order.
Left in place by decision on 2026-09-15; the deck carries a `%% FRM NOTE` comment recording it.
