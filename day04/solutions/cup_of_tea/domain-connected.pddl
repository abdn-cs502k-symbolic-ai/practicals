; deliver cup to a person in a room, with rooms joined by doorways
; Reference solution for Tutorial 4, question 7(b).
; Only the additions to the question 2 solution are commented.
(define (domain cup-delivery)
    (:requirements :typing)

    (:types
        cup person room
    )

    (:predicates
        (ontable ?c - cup ?r - room)
        (in ?r - room)
        (handempty)
        (holding ?c - cup)
        (inperson ?p - person ?r - room)
        (delivered ?c - cup ?p - person)
        (connected ?from - room ?to - room) ; a doorway leads from ?from to ?to
    )

    (:action pick-up
        :parameters (?c - cup ?r - room)
        :precondition (and
            (in ?r)
            (ontable ?c ?r)
            (handempty)
        )
        :effect (and
            (holding ?c)
            (not (ontable ?c ?r))
            (not (handempty))
        )
    )

    (:action move
        :parameters (?from - room ?to - room)
        :precondition (and
            (in ?from)
            (connected ?from ?to) ; the robot can only walk through a doorway
        )
        :effect (and
            (in ?to)
            (not (in ?from))
        )
    )

    (:action deliver
        :parameters (?c - cup ?p - person ?r - room)
        :precondition (and
            (in ?r)
            (inperson ?p ?r)
            (holding ?c)
        )
        :effect (and
            (delivered ?c ?p)
            (not (holding ?c))
            (handempty)
        )
    )
)
