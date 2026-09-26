;; Two balls, one gripper, two rooms. Small enough to compute a heuristic by hand.
(define (problem two-balls)
  (:domain gripper)
  (:objects rooma roomb ball1 ball2 left)
  (:init (room rooma) (room roomb) (ball ball1) (ball ball2) (gripper left)
         (at-robby rooma) (at-ball ball1 rooma) (at-ball ball2 rooma) (free left))
  (:goal (and (at-ball ball1 roomb) (at-ball ball2 roomb)))
)
