(set-option :produce-models true)

; -- Variables --

(declare-const a Int)
(declare-const b Int)
(declare-const c Int)


; -- Conditions --

; a, b, c are digits
(assert (and (>= a 0) (<= a 9)))
(assert (and (>= b 0) (<= b 9)))
(assert (and (>= c 0) (<= c 9)))

; I could have included the following conditions in the
; previous ones by setting `>` instead of `>=`. However,
; I kept them separated for clarity
(assert (not (= a 0)))
(assert (not (= c 0)))

(assert (=
    (mod
        (+ (* a 100) (* b 10) c) ; abc = a*100 + b*10 + c
        4
    )
    0
))

(assert (=
    (mod
        (+ (* c 100) (* b 10) a) ; cba = c*100 + b*10 + a
        4
    )
    0
))

; -- Closing --

(check-allsat (a b c))
;(get-model)
(exit)