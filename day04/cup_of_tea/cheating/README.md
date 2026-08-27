# The cheating domain

A deliberately broken formalisation of the cup-of-tea domain, kept as a teaching
example. Run it against the problem file one directory up:

```sh
# in editor.planning.domains, or with a local planner
<planner> cheating/domain.pddl problem.pddl
```

The planner returns a one-step plan:

```
(magic_everything cup-of-tea grandpa)
```

Two things are wrong, and they are the two failure modes students hit in the
assignment:

1. **`magic_everything` achieves the goal directly.** Its only precondition is
   `(handempty)`, so nothing in the domain forces the robot to pick the cup up,
   move, or be in the same room as grandpa. An action whose preconditions do not
   mention the objects it claims to act on is almost always a modelling error.
2. **`pick-up` has no delete effects.** It adds `(holding ?c)` but leaves
   `(handempty)` and `(ontable ?c ?r)` true, so the robot can hold every cup at
   once and the cups stay on the table while it does.

The lesson: a plan coming back is not evidence that the model is right. The
planner will exploit anything you leave under-constrained. Check the plan against
what the domain description actually says, and use a validator.
