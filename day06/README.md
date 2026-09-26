# CS502K: Symbolic Artificial Intelligence

## Tutorial 06: Markov Decision Processes

Follows Lecture 11 and Lecture 12, and runs in the single practical session of its week.
That week has one session rather than two, because Assessment 2 takes the other slot, and the remaining session is shared with the Assessment 3 demonstrations.

This is the only day still on pre-redesign material, and it predates the split of its two lectures.
The rebuild has to signpost which half of the session serves which lecture, and to re-size the material for a session students are pulled out of one at a time.

### Goals

- State the Bellman equation and say what each term does
- Implement value iteration
- Implement policy iteration
- Read what the discount factor and the transition probabilities do to the resulting policy

### The session

Work through `tutorial6-mdp.ipynb`, either in [Colab](https://colab.research.google.com/github/abdn-cs502k-symbolic-ai/practicals/blob/main/day06/tutorial6-mdp.ipynb) or locally:

```sh
cd day06 && jupyter notebook tutorial6-mdp.ipynb
```

No question depends on the previous one having been finished, because students leave the room for their Assessment 3 demonstration and return.

### Files

| File | What it is |
| --- | --- |
| `tutorial6-mdp.ipynb` | The notebook. `MDP` and `GridMDP` are given; the bodies of `value_iteration`, `best_policy` and `expected_utility` are left as `### Your code here` stubs |
| `utils4e.py`, `notebook.py` | Vendored from `aima-python`. Library code, not coursework: do not refactor it |

### Notes for the lecturer

The rebuild is outstanding, and `Practicals-Redesign.md` section 6 in the lectures repository is the authority on it.
Three pieces are named there: signpost the Lecture 11 and Lecture 12 split, take CS3033's `week08/test_mdp.py`, and re-size the session for the shared, interruptible slot it actually has.

There is no solutions notebook for this day, and there never has been.
The three stubs have no worked version anywhere in the repository or its history, which makes this the only exercise here a demonstrator cannot check an answer against.

The notebook gives the University's Level 0 statement and the metadata, and no instruction to AI assistants.
That was recorded on the understanding that the notebook sets no exercise, which is wrong: a model fills all three stubs in seconds.
Adding the refusal, naming those three functions, is part of the rebuild.
