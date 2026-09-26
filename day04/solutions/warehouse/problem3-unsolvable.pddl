;; Unsolvable, and a student should be able to say why before running anything.
;; Five bays in a line, no charging point anywhere, and a full charge is three
;; drives. The dock is four drives from goods-in. Fast Downward explores the
;; whole state space and reports no solution rather than timing out, which is
;; itself worth seeing.

(define (problem warehouse-flat-battery)
  (:domain warehouse)

  (:objects
    fork1                               - forklift
    pal1                                - pallet
    goods-in aisle-a aisle-b aisle-c dock - bay
    full half low empty                 - level)

  (:init
    (next full half) (next half low) (next low empty)

    (at fork1 goods-in) (charge fork1 full) (free fork1)

    (connected goods-in aisle-a) (connected aisle-a goods-in)
    (connected aisle-a aisle-b)  (connected aisle-b aisle-a)
    (connected aisle-b aisle-c)  (connected aisle-c aisle-b)
    (connected aisle-c dock)     (connected dock aisle-c)

    (pallet-at pal1 goods-in))

  (:goal (pallet-at pal1 dock)))
