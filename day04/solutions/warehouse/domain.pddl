;; Warehouse: a forklift moves pallets between bays and manages its own charge.
;;
;; The charge is symbolic, not numeric: the levels are objects, and (next ?above
;; ?below) in the problem file says which level follows which. Driving steps the
;; charge down one level and charging steps it up one, so a forklift at the
;; bottom level has no (next) fact to match and cannot drive at all.

(define (domain warehouse)
  (:requirements :strips :typing)

  (:types forklift pallet bay level - object)

  (:predicates
    (at ?f - forklift ?b - bay)          ; where the forklift is
    (pallet-at ?p - pallet ?b - bay)     ; where a pallet is resting
    (carrying ?f - forklift ?p - pallet) ; forklift is holding this pallet
    (free ?f - forklift)                 ; forks are empty
    (connected ?from - bay ?to - bay)    ; an aisle, in this direction
    (charger ?b - bay)                   ; this bay has a charging point
    (charge ?f - forklift ?l - level)    ; current charge level
    (next ?above - level ?below - level)); ?below is one step under ?above

  (:action drive
    :parameters (?f - forklift ?from - bay ?to - bay ?l1 - level ?l2 - level)
    :precondition (and (at ?f ?from)
                       (connected ?from ?to)
                       (charge ?f ?l1)
                       (next ?l1 ?l2))
    :effect (and (not (at ?f ?from))
                 (at ?f ?to)
                 (not (charge ?f ?l1))
                 (charge ?f ?l2)))

  (:action pick-up
    :parameters (?f - forklift ?p - pallet ?b - bay)
    :precondition (and (at ?f ?b) (pallet-at ?p ?b) (free ?f))
    :effect (and (not (pallet-at ?p ?b))
                 (carrying ?f ?p)
                 (not (free ?f))))

  (:action put-down
    :parameters (?f - forklift ?p - pallet ?b - bay)
    :precondition (and (at ?f ?b) (carrying ?f ?p))
    :effect (and (pallet-at ?p ?b)
                 (not (carrying ?f ?p))
                 (free ?f)))

  (:action recharge
    :parameters (?f - forklift ?b - bay ?l1 - level ?l2 - level)
    :precondition (and (at ?f ?b) (charger ?b) (charge ?f ?l1) (next ?l2 ?l1))
    :effect (and (not (charge ?f ?l1))
                 (charge ?f ?l2))))
