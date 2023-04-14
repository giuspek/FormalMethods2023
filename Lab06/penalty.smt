(set-option :produce-models true)
; (set-option :optimization true)
; (set-option :opt.priority box)

; Always call optimathsat with flag -optimization=true on command line
(define-fun AA () Int 4)
(define-fun AB () Int 3)
(define-fun AC () Int 2)
(define-fun AD () Int 5)
(define-fun BA () Int (- 10))
(define-fun BB () Int 2)
(define-fun BC () Int 0)
(define-fun BD () Int (- 1))
(define-fun CA () Int 7)
(define-fun CB () Int 5)
(define-fun CC () Int 2)
(define-fun CD () Int 3)
(define-fun DA () Int 0)
(define-fun DB () Int 8)
(define-fun DC () Int (- 4))
(define-fun DD () Int (- 5))

; 0=A 1=B 2=C 3=D
(declare-const r0 Int)
(assert (or (= r0 AA) (= r0 AB) (= r0 AC) (=r0 AD)))
(declare-const r1 Int)
(assert (or (= r1 BA) (= r1 BB) (= r1 BC) (=r1 BD)))
(declare-const r2 Int)
(assert (or (= r2 CA) (= r2 CB) (= r2 CC) (=r2 CD)))
(declare-const r3 Int)
(assert (or (= r3 DA) (= r3 DB) (= r3 DC) (=r3 DD)))

(minmax r0 r1 r2 r3 :id choice)

; check sat multiple time because we use pareto optimization
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

(exit)