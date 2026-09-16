; two cups, two grandparents, two rooms
; Reference solution for Tutorial 4, question 7(a). The domain is unchanged.
(define (problem tea-and-coffee)
    (:domain cup-delivery)
    (:objects
        cup-of-tea cup-of-coffee - cup
        grandpa grandma - person
        kitchen living-room - room
    )
    (:init
        (ontable cup-of-tea kitchen)
        (ontable cup-of-coffee kitchen)
        (handempty)
        (in kitchen)
        (inperson grandpa living-room)
        (inperson grandma kitchen)
    )

    (:goal
        (and
            (delivered cup-of-tea grandpa)
            (delivered cup-of-coffee grandma)
        )
    )
)
