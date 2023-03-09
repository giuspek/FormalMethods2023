;   A --- B
;   | \   |
;   |  \  |
;   |   \ |
;   C --- D

; ENCODING

; color with at most 2 colors
; variables XN
; X (letter) -> node X
; N (number) -> node X has color number N
(declare-const A1 Bool)
(declare-const A2 Bool)
(declare-const B1 Bool)
(declare-const B2 Bool)
(declare-const C1 Bool)
(declare-const C2 Bool)
(declare-const D1 Bool)
(declare-const D2 Bool)

; CONSTRAINTS

; each node must have exactly one color
(assert (or A1 A2))
(assert (=> A1 (not A2)))
(assert (=> A2 (not A1)))
(assert (or B1 B2))
(assert (=> B1 (not B2)))
(assert (=> B2 (not B1)))
(assert (or C1 C2))
(assert (=> C1 (not C2)))
(assert (=> C2 (not C1)))
(assert (or D1 D2))
(assert (=> D1 (not D2)))
(assert (=> D2 (not D1)))

; two connected nodes can never have same color
; edge AB
(assert (or (and A1 B2) (and A2 B1)))
; edge AC
(assert (or (and A1 C2) (and A2 C1)))
; edge AD
(assert (or (and A1 D2) (and A2 D1)))
; edge BD
(assert (or (and D1 B2) (and D2 B1)))
; edge CD
(assert (or (and C1 D2) (and C2 D1)))

(check-sat)
(get-model)
(exit)
