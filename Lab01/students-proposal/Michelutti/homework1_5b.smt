;   A --- B
;   | \   |
;   |  \  |
;   |   \ |
;   C --- D

; ENCODING

; color with at most 3 colors
; variables XN
; X (letter) -> node X
; N (number) -> node X has color number N
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

; CONSTRAINTS

; each node must have exactly one color
(assert (or A1 A2 A3))
(assert (=> A1 (and (not A2) (not A3))))
(assert (=> A2 (and (not A1) (not A3))))
(assert (=> A3 (and (not A1) (not A2))))
(assert (or B1 B2 B3))
(assert (=> B1 (and (not B2) (not B3))))
(assert (=> B2 (and (not B1) (not B3))))
(assert (=> B3 (and (not B1) (not B2))))
(assert (or C1 C2 C3))
(assert (=> C1 (and (not C2) (not C3))))
(assert (=> C2 (and (not C1) (not C3))))
(assert (=> C3 (and (not C1) (not C2))))
(assert (or D1 D2 D3))
(assert (=> D1 (and (not D2) (not D3))))
(assert (=> D2 (and (not D1) (not D3))))
(assert (=> D3 (and (not D1) (not D2))))

; two connected nodes can never have same color
; edge AB
(assert (not (or (and A1 B1) (and A2 B2) (and A3 B3))))
; edge AC
(assert (not (or (and A1 C1) (and A2 C2) (and A3 C3))))
; edge AD
(assert (not (or (and A1 D1) (and A2 D2) (and A3 D3))))
; edge BD
(assert (not (or (and D1 B1) (and D2 B2) (and D3 B3))))
; edge CD
(assert (not (or (and C1 D1) (and C2 D2) (and C3 D3))))

(check-sat)
(get-model)
(exit)
