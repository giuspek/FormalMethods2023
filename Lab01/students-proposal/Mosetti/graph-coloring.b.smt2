(declare-const A1 Bool)
(declare-const A2 Bool)
(declare-const A3 Bool)

(declare-const B1 Bool)
(declare-const B2 Bool)
(declare-const B3 Bool)

(declare-const C1 Bool)
(declare-const C2 Bool)
(declare-const C3 Bool)

(declare-const D1 Bool)
(declare-const D2 Bool)
(declare-const D3 Bool)

; exactly one color per node
(assert (or
  (and A1 (not A2) (not A3))
  (and A2 (not A1) (not A3))
  (and A3 (not A2) (not A1))
))

(assert (or
  (and B1 (not B2) (not B3))
  (and B2 (not B1) (not B3))
  (and B3 (not B2) (not B1))
))

(assert (or
  (and C1 (not C2) (not C3))
  (and C2 (not C1) (not C3))
  (and C3 (not C2) (not C1))
))

(assert (or
  (and D1 (not D2) (not D3))
  (and D2 (not D1) (not D3))
  (and D3 (not D2) (not D1))
))

; A -- B
(assert (or
  (xor A1 B1)
  (xor A2 B2)
  (xor A3 B3)
))

; A -- C
(assert (or
  (xor A1 C1)
  (xor A2 C2)
  (xor A3 C3)
))

; A -- D
(assert (or
  (xor A1 D1)
  (xor A2 D2)
  (xor A3 D3)
))

; B -- D
(assert (or
  (xor B1 D1)
  (xor B2 D2)
  (xor B3 D3)
))

; C -- D
(assert (or
  (xor C1 D1)
  (xor C2 D2)
  (xor C3 D3)
))

(check-sat)
(get-model)
(exit)
