; Options
(set-option :produce-models true)

; Declarations

(declare-const x1 Int)
(declare-const x2 Int)
(declare-const x3 Int)
(declare-const x4 Int)
(declare-const x5 Int)
(declare-const x6 Int)
(declare-const x7 Int)
(declare-const x8 Int)

(declare-const overall_colors Int)

; Counting how many different colors
(define-fun any_different ((x Int)) Int (+
    (ite (not (= x x1)) 1 0)
    (ite (not (= x x2)) 1 0)
    (ite (not (= x x3)) 1 0)
    (ite (not (= x x4)) 1 0)
    (ite (not (= x x5)) 1 0)
    (ite (not (= x x6)) 1 0)
    (ite (not (= x x7)) 1 0)
    (ite (not (= x x8)) 1 0)
))

(define-fun count_diff () Int (+
    (any_different x1)
    (any_different x2)
    (any_different x3)
    (any_different x4)
    (any_different x5)
    (any_different x6)
    (any_different x7)
    (any_different x8)
))

(define-fun count_colors () Int (+
    (ite (> (any_different x1) 0) 1 0)
    (ite (> (any_different x2) 0) 1 0)
    (ite (> (any_different x3) 0) 1 0)
    (ite (> (any_different x4) 0) 1 0)
    (ite (> (any_different x5) 0) 1 0)
    (ite (> (any_different x6) 0) 1 0)
    (ite (> (any_different x7) 0) 1 0)
    (ite (> (any_different x8) 0) 1 0)
))


; Assertions

; Color representation should be a positive numbers
; Not an actual constraint, but it seems a better representation
(assert (>= x1 0))
(assert (>= x2 0))
(assert (>= x3 0))
(assert (>= x4 0))
(assert (>= x5 0))
(assert (>= x6 0))
(assert (>= x7 0))
(assert (>= x8 0))

; x1 borders with x1 and x2
(assert (and (not (= x1 x2)) (not (= x1 x3))))

; x2 borders with x1, x3 and x4
(assert (and (not (= x2 x1)) (not (= x2 x3)) (not (= x2 x4))))

; x3 borders with x1, x2, x4, x5, x6 and x8
(assert (and
    (not (= x3 x1))
    (not (= x3 x2))
    (not (= x3 x4))
    (not (= x3 x5))
    (not (= x3 x6))
    (not (= x3 x8))
))

; x4 borders with x2, x3 and x5
(assert (and (not (= x4 x2)) (not (= x4 x3)) (not (= x4 x5))))

; x5 borders with x3, x4, x6 and x7
(assert (and
    (not (= x5 x3))
    (not (= x5 x4))
    (not (= x5 x6))
    (not (= x5 x7))
))

; x6 borders with x3, x5, x7 and x8
(assert (and
    (not (= x6 x3))
    (not (= x6 x5))
    (not (= x6 x7))
    (not (= x6 x8))
))

; x7 borders with x5, x6 and x8
(assert (and (not (= x7 x5)) (not (= x7 x6)) (not (= x7 x8))))

; x8 borders with x3, x6 and x7
(assert (and (not (= x8 x3)) (not (= x8 x6)) (not (= x8 x7))))

(assert (= overall_colors count_colors))

; Objectives
(minimize count_diff :id count_diff)


; Actions
(check-sat)
(get-objectives)
(get-model)
(exit)