; Options
(set-option :produce-models true)
;(set-option :opt.priority box)

; Declarations

(declare-const x Int)
(declare-const y Int)

(define-fun obj () Int (
    *
    x
    (* y y)
))


; Assertions

; Non-negative numbers
; Actually 0 is not a feasible value, as it would make their product 0
(assert (>= x 0))
(assert (>= y 0))

; Their sum is 9
(assert (= (+ x y) 9))

; Objective is constrained in the open range (0, 200)
(assert (and (> obj 0) (< obj 200)))


; Objectives
(maximize obj :id objective)


; Actions
(check-sat)
(get-objectives)
(get-model)
(exit)