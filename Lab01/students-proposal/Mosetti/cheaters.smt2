(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)

; A: B is guilty and C is innocent
(assert B)
(assert (not C)))

; B: if A is guilty, then C is also guilty
(assert (=> A C))

; C: I am innocent and one of the others, perhaps even the two, are guilty
(assert (not C))
(assert (or A B))

(check-sat)
(get-model)
(exit)
