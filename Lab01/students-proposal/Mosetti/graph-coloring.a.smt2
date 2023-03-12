(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)

; A -- B
(assert (xor A B))

; A -- C
(assert (xor A C))

; A -- D
(assert (xor A D))

; B -- D
(assert (xor B D))

; C -- D
(assert (xor C D))

(check-sat)
(get-model)
(exit)
