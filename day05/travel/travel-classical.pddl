;; The travel domain of Lecture 10, with the methods thrown away.
;; The four actions are identical to those in travel.hddl. Only the hierarchy is gone,
;; so a classical planner has to find the sequence for itself.
(define (domain travel-classical)
  (:requirements :strips :negative-preconditions)
  (:predicates (at ?x) (airport ?a ?c) (longDistance ?x ?y) (ticket ?x ?y) (hasTaxi ?x))

  (:action getTicket
    :parameters (?x ?y ?xc ?yc)
    :precondition (and (airport ?x ?xc) (airport ?y ?yc))
    :effect (and (ticket ?x ?y)))

  (:action fly
    :parameters (?x ?y ?x1 ?y1)
    :precondition (and (airport ?x ?x1) (airport ?y ?y1) (ticket ?x ?y) (at ?x))
    :effect (and (not (at ?x)) (not (ticket ?x ?y)) (at ?y)))

  (:action getTaxi
    :parameters (?x)
    :precondition (and (at ?x))
    :effect (and (hasTaxi ?x)))

  (:action rideTaxi
    :parameters (?x ?y)
    :precondition (and (at ?x) (not (longDistance ?x ?y)) (hasTaxi ?x))
    :effect (and (not (at ?x)) (not (hasTaxi ?x)) (at ?y)))
)
