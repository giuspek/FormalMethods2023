(set-option :opt.priority pareto)

; x1 = n. of ads
; x2 = n. of appearances
(declare-const x1 Int)
(declare-const x2 Int)

; Hidden constraint: no negative number for both variables!

(assert (>= x1 0))
(assert (>= x2 0))

; N. minimum customers constraint
(assert (>= (+ (* 2 x1) (* 2 x2)) 16))
(assert (>= (+ (* 1 x1) (* 5 x2)) 28))

(minimize (+ (* 2000 x1) (* 500 x2)) :id cost)
(minimize (+ (* 1 x1) (* 2 x2)) :id time)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)


