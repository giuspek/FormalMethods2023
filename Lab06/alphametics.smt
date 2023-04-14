(set-option :produce-models true)

(declare-const V Int)
(declare-const I Int)
(declare-const O Int)
(declare-const L Int)
(declare-const A Int)
(declare-const N Int)
(declare-const T Int)
(declare-const R Int)
(declare-const S Int)

(assert (distinct V I O L A N T R S))
(assert (not (= V 0)))
(assert (not (= T 0)))
(assert (not (= S 0)))

(assert (>= V 0))
(assert (<= V 9))

(assert (>= I 0))
(assert (<= I 9))

(assert (>= O 0))
(assert (<= O 9))

(assert (>= L 0))
(assert (<= L 9))

(assert (>= A 0))
(assert (<= A 9))

(assert (>= N 0))
(assert (<= N 9))

(assert (>= T 0))
(assert (<= T 9))

(assert (>= R 0))
(assert (<= R 9))

(assert (>= S 0))
(assert (<= S 9))



(define-fun VIOLIN () Int (+ N (* 10 I) (* 100 L) (* 1000 O) (* 10000 I) (* 100000 V)))
(define-fun VIOLA () Int (+ A (* 10 L) (* 100 O) (* 1000 I) (* 10000 V)))
(define-fun SONATA () Int (+ A (* 10 T) (* 100 A) (* 1000 N) (* 10000 O) (* 100000 S)))
(define-fun TRIO () Int (+ O (* 10 I) (* 100 R) (* 1000 T) ))

(assert (= (+ VIOLIN VIOLIN VIOLA) (+ TRIO SONATA)))

; To check uniqueness of the first solution I got
; (assert (not (and (= V 3) (= I 5) (= O 4) (= L 6) (= A 8) (= N 2) (= T 1) (= R 9) (= S 7) )))

(check-sat)
(get-model)

(exit)
