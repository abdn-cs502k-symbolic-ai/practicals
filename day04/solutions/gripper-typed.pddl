; The gripper domain of Lecture 7, rewritten in the typed subset.
; Reference solution for Tutorial 4, question 1(b).
; The tutorial prints lines 6 to 26 only, the requirements through the schemas.
(define (domain gripper-typed)

  (:requirements :typing)
  (:types room ball gripper)

  (:predicates (at-robby ?r - room)
               (at-ball ?b - ball ?r - room)
               (free ?g - gripper)
               (carry ?g - gripper ?b - ball))

  (:action move :parameters (?x ?y - room)
     :precondition (at-robby ?x)
     :effect       (and (at-robby ?y) (not (at-robby ?x))))

  (:action pick-up :parameters (?x - ball ?y - room ?z - gripper)
     :precondition (and (at-ball ?x ?y) (at-robby ?y) (free ?z))
     :effect       (and (carry ?z ?x)
                        (not (at-ball ?x ?y)) (not (free ?z))))

  (:action drop :parameters (?x - ball ?y - room ?z - gripper)
     :precondition (and (carry ?z ?x) (at-robby ?y))
     :effect       (and (at-ball ?x ?y) (free ?z)
                        (not (carry ?z ?x))))
)
