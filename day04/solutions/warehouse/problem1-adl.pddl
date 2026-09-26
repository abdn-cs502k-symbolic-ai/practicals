;; The same shift as problem1.pddl, for the ADL domain. The level objects and
;; the (next ...) facts are gone: the levels are constants of that domain and
;; the drain is in the conditional effects of drive.

(define (problem warehouse-shift-adl)
  (:domain warehouse-adl)

  (:objects
    fork1 fork2                    - forklift
    pal1 pal2 pal3 pal4 pal5       - pallet
    goods-in aisle-a aisle-b dock  - bay)

  (:init
    (charger goods-in) (charger dock)

    (connected goods-in aisle-a) (connected aisle-a goods-in)
    (connected aisle-a dock)     (connected dock aisle-a)
    (connected goods-in aisle-b) (connected aisle-b goods-in)
    (connected aisle-b dock)     (connected dock aisle-b)

    (at fork1 goods-in) (charge fork1 full) (free fork1)
    (at fork2 dock)     (charge fork2 full) (free fork2)

    (pallet-at pal1 goods-in)
    (pallet-at pal2 goods-in)
    (pallet-at pal3 goods-in)
    (pallet-at pal4 aisle-a)
    (pallet-at pal5 dock))

  (:goal (and
    (pallet-at pal1 dock)
    (pallet-at pal2 dock)
    (pallet-at pal3 dock)
    (pallet-at pal4 dock)
    (pallet-at pal5 goods-in))))
