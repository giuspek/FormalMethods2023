;    A     B     C
;   -+-   -+-   -+-
;   / \   / \   / \

; ENCODING

; GX -> student X is guilty
; IX -> studemt X is innocent
(declare-const GA Bool)
(declare-const GB Bool)
(declare-const GC Bool)
(declare-const IA Bool)
(declare-const IB Bool)
(declare-const IC Bool)

; CONSTRAINTS

; 1 - each student is either guilty or innocent, never both
(assert (or GA IA))
(assert (=> GA (not IA)))
(assert (=> IA (not GA)))
(assert (or GB IB))
(assert (=> GB (not IB)))
(assert (=> IB (not GB)))
(assert (or GC IC))
(assert (=> GC (not IC)))
(assert (=> IC (not GC)))

; 2 - there is at least someone that is guilty
(assert (or GA GB GC))

; 3 - assertions
; A says: B guilty, C innocent
(assert (and GB IC))
; B says: if A guilty, then C guilty
(assert (=> GA GC))
; C says: C innocent, either A or B or both guilty
(assert (and IC (or GA GB)))

; UNIQUENESS

; uncomment to check if model found (GB IA IC) is unique
; (assert (not (and GB IA IC)))
; unsat -> solution is unique -> only B cheated

(check-sat)
(get-model)
(exit)