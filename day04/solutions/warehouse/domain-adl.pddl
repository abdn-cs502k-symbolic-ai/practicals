;; The same warehouse, written with ADL conditional effects instead of a
;; successor predicate. The charge levels are constants of the domain rather
;; than objects of the problem, the drain lives in three (when ...) clauses, and
;; recharging is a single action that resets to full.

(define (domain warehouse-adl)
  (:requirements :typing :adl)

  (:types forklift pallet bay level - object)

  (:constants full half low empty - level)

  (:predicates
    (at ?f - forklift ?b - bay)
    (pallet-at ?p - pallet ?b - bay)
    (carrying ?f - forklift ?p - pallet)
    (free ?f - forklift)
    (connected ?from - bay ?to - bay)
    (charger ?b - bay)
    (charge ?f - forklift ?l - level))

  (:action drive
    :parameters (?f - forklift ?from - bay ?to - bay)
    :precondition (and (at ?f ?from)
                       (connected ?from ?to)
                       (not (charge ?f empty)))
    :effect (and (not (at ?f ?from))
                 (at ?f ?to)
                 (when (charge ?f full)
                       (and (not (charge ?f full)) (charge ?f half)))
                 (when (charge ?f half)
                       (and (not (charge ?f half)) (charge ?f low)))
                 (when (charge ?f low)
                       (and (not (charge ?f low)) (charge ?f empty)))))

  (:action pick-up
    :parameters (?f - forklift ?p - pallet ?b - bay)
    :precondition (and (at ?f ?b) (pallet-at ?p ?b) (free ?f))
    :effect (and (not (pallet-at ?p ?b)) (carrying ?f ?p) (not (free ?f))))

  (:action put-down
    :parameters (?f - forklift ?p - pallet ?b - bay)
    :precondition (and (at ?f ?b) (carrying ?f ?p))
    :effect (and (pallet-at ?p ?b) (not (carrying ?f ?p)) (free ?f)))

  (:action recharge
    :parameters (?f - forklift ?b - bay)
    :precondition (and (at ?f ?b) (charger ?b))
    :effect (and (charge ?f full)
                 (not (charge ?f half))
                 (not (charge ?f low))
                 (not (charge ?f empty)))))
