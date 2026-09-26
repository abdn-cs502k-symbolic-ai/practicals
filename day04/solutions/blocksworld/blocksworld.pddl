;; Blocks world with an explicit gripper, so that two or more grippers can be used.
;; Reference solution for Tutorial 4, question 5.
;; Compare against the skeleton: every change is marked CHANGED or NEW.

(define (domain blocksworld)

    (:requirements :typing :negative-preconditions)

    (:types
        block
        gripper ; NEW: the gripper stops being implicit and becomes an object
    )

    (:predicates
        (on ?a ?b - block) ; block `?a` is on top of block `?b`
        (clear ?a - block) ; there is nothing on top of block `?a`
        (ontable ?a - block) ; block `?a` is on table
        (holding ?g - gripper ?a - block) ; CHANGED: which gripper holds `?a`
        (free ?g - gripper) ; CHANGED: `handempty' becomes per-gripper
    )

    (:action pickup ; this action is only for picking from table
        :parameters (?g - gripper ?a - block) ; CHANGED: which gripper picks up
        :precondition (and
            (ontable ?a)
            (free ?g)
            (clear ?a)
        )
        :effect (and
            (holding ?g ?a)
            (not (free ?g))
            (not (clear ?a))
            (not (ontable ?a))
        )
    )
    (:action unstack ; only suitable for picking from block
        :parameters (?g - gripper ?a ?b - block)
        :precondition (and
            (on ?a ?b)
            (free ?g)
            (clear ?a)
        )
        :effect (and
            (holding ?g ?a)
            (not (free ?g))
            (not (clear ?a))
            (clear ?b)
            (not (on ?a ?b))
        )
    )

    (:action putdown
        :parameters (?g - gripper ?a - block)
        :precondition (and
            (holding ?g ?a)
        )
        :effect (and
            (ontable ?a)
            (not (holding ?g ?a))
            (free ?g)
            (clear ?a)
        )
    )

    (:action stack
        :parameters (?g - gripper ?a ?b - block)
        :precondition (and
            (holding ?g ?a)
            (clear ?b)
        )
        :effect (and
            (on ?a ?b)
            (not (holding ?g ?a))
            (free ?g)
            (not (clear ?b))
            (clear ?a)
        )
    )
)
