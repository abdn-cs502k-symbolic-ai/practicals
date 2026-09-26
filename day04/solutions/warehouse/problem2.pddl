;; The two-pallet check. One forklift, two pallets in the same bay, both wanted
;; in another. A correct domain ferries them one at a time. A domain whose
;; pick-up forgets (not (free ?f)), or whose put-down forgets to stop carrying,
;; picks both up at once and returns a plan that is two actions short.

(define (problem warehouse-two-pallets)
  (:domain warehouse)

  (:objects
    fork1            - forklift
    pal1 pal2        - pallet
    goods-in dock    - bay
    full half low    - level)

  (:init
    (next full half) (next half low)
    (charge fork1 full)
    (at fork1 goods-in)
    (free fork1)
    (charger goods-in)
    (charger dock)
    (connected goods-in dock) (connected dock goods-in)
    (pallet-at pal1 goods-in)
    (pallet-at pal2 goods-in))

  (:goal (and (pallet-at pal1 dock) (pallet-at pal2 dock))))
