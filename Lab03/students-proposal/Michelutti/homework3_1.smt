; Use semi columns for comments
(set-option :produce-models true)

; digits
(declare-const c Int)
(declare-const a Int)
(declare-const b Int)

(declare-const abc Int)
(declare-const cba Int)

; digits must be in 0..9 
(assert (and (>= a 0) (<= a 9)))
(assert (and (>= b 0) (<= b 9)))
(assert (and (>= c 0) (<= c 9)))

; a and c cant be 0
(assert (not (= a 0)))
(assert (not (= c 0)))

; computing abc and cba
(assert (= cba (+ (+ (* 100 c) (* 10 b)) a)))
(assert (= abc (+ (+ (* 100 a) (* 10 b)) c)))

; checking that abc and cba are divisible by 4
(assert (= (mod abc 4) 0))
(assert (= (mod cba 4) 0))

(check-allsat())
(get-model)
(exit)