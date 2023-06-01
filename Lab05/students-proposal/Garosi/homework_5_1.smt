; Options
(set-option :produce-models true)

; Declarations

; Each variable represents a node.
; It is true iff it is part of the solution
; Edges are represented implicitly using the constraints (assertions)
(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)
(declare-const E Bool)
(declare-const F Bool)
(declare-const G Bool)

; Count how many vertices in the solution
(define-fun count_vertices () Int (
    +
    (ite A 1 0)
    (ite B 1 0)
    (ite C 1 0)
    (ite D 1 0)
    (ite E 1 0)
    (ite F 1 0)
    (ite G 1 0)
))


; Assertions

(assert (or A B))
(assert (or B C))
(assert (or C D))
(assert (or C E))
(assert (or D E))
(assert (or D F))
(assert (or E D))
(assert (or D G))


; Objectives

(minimize count_vertices :id vertex_cover)


; Actions
(check-sat)
(get-objectives)
(get-model)
(exit)