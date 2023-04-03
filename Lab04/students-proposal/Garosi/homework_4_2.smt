(set-option :produce-models true)

; -- Variables --

; Tasks - Value for task represents the time instant it is executed in
(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)

; -- Constraints --

(assert (> A D)) ; A is executed after D has finished
(assert (and (> B C) (> B E))) ; B is executed after both C and E have finished
(assert (or (> E B) (> E D))) ; E is executed after either B or D have finished
(assert (> C A)) ; C is executed after A has finished

; Make sure that no tasks are executed in the same time slot
(assert (distinct A B C D E)) ; Not sure about this constraint

; Each task has to be given an order
(assert (and (>= A 1) (<= A 5)))
(assert (and (>= B 1) (<= B 5)))
(assert (and (>= C 1) (<= C 5)))
(assert (and (>= D 1) (<= D 5)))
(assert (and (>= E 1) (<= E 5)))


; -- Closing --
(check-sat)
(get-model)
(exit)