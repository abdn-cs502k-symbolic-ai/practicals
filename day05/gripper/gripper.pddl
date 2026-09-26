;; The gripper domain of Lecture 7, in the untyped STRIPS subset the lecture uses.
;; Types are unary predicates here: (room ?r) asserts that ?r is a room.
(define (domain gripper)
  (:requirements :strips)
  (:predicates (room ?r) (ball ?b) (gripper ?g)
               (at-robby ?r) (at-ball ?b ?r) (free ?g) (carry ?g ?b))

  (:action move
    :parameters (?x ?y)
    :precondition (and (room ?x) (room ?y) (at-robby ?x))
    :effect (and (at-robby ?y) (not (at-robby ?x))))

  (:action pick-up
    :parameters (?x ?y ?z)
    :precondition (and (ball ?x) (room ?y) (gripper ?z)
                       (at-ball ?x ?y) (at-robby ?y) (free ?z))
    :effect (and (carry ?z ?x) (not (at-ball ?x ?y)) (not (free ?z))))

  (:action drop
    :parameters (?x ?y ?z)
    :precondition (and (ball ?x) (room ?y) (gripper ?z)
                       (carry ?z ?x) (at-robby ?y))
    :effect (and (at-ball ?x ?y) (free ?z) (not (carry ?z ?x))))
)
