; deliver cup to a person in a room
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
    )

    (:action pick-up
        :parameters (?c - cup ?r - room)
        :precondition (and (in ?r) (handempty) (ontable ?c ?r))
        :effect (and (holding ?c))
    )

    (:action magic_everything
        :parameters (?c - cup ?p - person)
        :precondition (and (handempty))
        :effect (and (delivered ?c ?p))
    )

    ; TODO move action

    ; TODO deliver cup action

)