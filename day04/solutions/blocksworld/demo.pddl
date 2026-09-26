; Reference solution for Tutorial 4, question 5. The problem file changes too.
; Compare against the skeleton demo.pddl.

(define (problem demo)(:domain blocksworld)

(:objects
    red green blue yellow brown pink - block
    left right - gripper ; NEW: the grippers are objects now
    )

(:init
    ;tower
    (ontable red) ; Block red
    (on green red) ; Block green
    (on blue green)(clear blue) ; Block blue
    ;tower
    (ontable yellow) ; Block yellow
    (on brown yellow) ; Block brown
    (on pink brown)(clear pink) ; Block pink

    (free left)(free right) ; CHANGED: `handempty' held for the one implicit gripper
)

(:goal (and
    (on red brown)
    (on green red)
    (holding left yellow) ; CHANGED: `holding' now has to say which gripper
))
)
