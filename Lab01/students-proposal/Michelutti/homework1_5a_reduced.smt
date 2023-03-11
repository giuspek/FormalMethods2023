;   A --- B
;   | \   |
;   |  \  |
;   |   \ |
;   C --- D

; ENCODING

; color with at most 2 colors
; suppose the two colors are "colored" and "not colored"
; Supposing A is colored, I do not need a variable for A
; if var X true  -> node X is colored
; if var X false -> node X is not colored
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)

; CONSTRAINTS

; 1 - each node must have exactly one color
; given by the fact that a boolean variable is either T or F

; 2 - two connected nodes can never have same color
; edge AB
(assert (not B))
; edge AC
(assert (not C))
; edge AD
(assert (not D))
; edge BD
(assert (or (and B (not D)) (and D (not B))))
; edge CD
(assert (or (and C (not D)) (and D (not C))))

(check-sat)
(get-model)
(exit)
