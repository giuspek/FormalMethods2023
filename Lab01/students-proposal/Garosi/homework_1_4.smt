; -- Variables --
; Naming: x_ij, i being the slot, j being the number placed in that slot

; Slot 1
(declare-const x_11 Bool)
(declare-const x_12 Bool)
(declare-const x_13 Bool)
(declare-const x_14 Bool)

; Slot 2
(declare-const x_21 Bool)
(declare-const x_22 Bool)
(declare-const x_23 Bool)
(declare-const x_24 Bool)

; Slot 3
(declare-const x_31 Bool)
(declare-const x_32 Bool)
(declare-const x_33 Bool)
(declare-const x_34 Bool)


; -- Constraints --

; Password should be even
(assert (not x_31))
(assert (not x_33))

; We cannot use the same digit three times
; Number 1
(assert (=> (and x_11 x_21) (not x_31)))
(assert (=> (and x_11 x_31) (not x_21)))
(assert (=> (and x_21 x_31) (not x_11)))

; Number 2
(assert (=> (and x_12 x_22) (not x_31)))
(assert (=> (and x_12 x_32) (not x_22)))
(assert (=> (and x_22 x_32) (not x_12)))

; Number 3
(assert (=> (and x_13 x_23) (not x_33)))
(assert (=> (and x_13 x_33) (not x_23)))
(assert (=> (and x_23 x_33) (not x_13)))

; Number 4
(assert (=> (and x_14 x_24) (not x_34)))
(assert (=> (and x_14 x_34) (not x_24)))
(assert (=> (and x_24 x_34) (not x_14)))

; It is possible to repeat the same digit twice, just make sure the two digits are not adjacent
; Number 1
(assert (=> x_11 (not x_21)))
(assert (=> x_21 (not x_11)))
(assert (=> x_21 (not x_31)))
(assert (=> x_31 (not x_21)))

; Number 2
(assert (=> x_12 (not x_22)))
(assert (=> x_22 (not x_12)))
(assert (=> x_22 (not x_32)))
(assert (=> x_32 (not x_22)))

; Number 3
(assert (=> x_13 (not x_23)))
(assert (=> x_23 (not x_13)))
(assert (=> x_23 (not x_33)))
(assert (=> x_33 (not x_23)))

; Number 4
(assert (=> x_14 (not x_24)))
(assert (=> x_24 (not x_14)))
(assert (=> x_24 (not x_34)))
(assert (=> x_34 (not x_24)))


; -- Hidden constraints --

; At least one number per cell
(assert (or x_11 x_12 x_13 x_14))
(assert (or x_21 x_22 x_23 x_24))
(assert (or x_31 x_32 x_33 x_34))

; At most one number per cell
; Cell 1
(assert (=> x_11 (and (not x_12) (not x_13) (not x_14))))
(assert (=> x_12 (and (not x_11) (not x_13) (not x_14))))
(assert (=> x_13 (and (not x_11) (not x_12) (not x_14))))
(assert (=> x_14 (and (not x_11) (not x_12) (not x_13))))

; Cell 2
(assert (=> x_21 (and (not x_22) (not x_23) (not x_24))))
(assert (=> x_22 (and (not x_21) (not x_23) (not x_24))))
(assert (=> x_23 (and (not x_21) (not x_22) (not x_24))))
(assert (=> x_24 (and (not x_21) (not x_22) (not x_23))))

; Cell 3
(assert (=> x_31 (and (not x_32) (not x_33) (not x_34))))
(assert (=> x_32 (and (not x_31) (not x_33) (not x_34))))
(assert (=> x_33 (and (not x_31) (not x_32) (not x_34))))
(assert (=> x_34 (and (not x_31) (not x_32) (not x_33))))


; -- Uniqueness --
; Model 314 was found
(assert (not (and x_13 x_21 x_34)))
; Model 134 was found, therefore the solution is not unique
; (assert (not (and x_11 x_23 x_34)))

; -- Closing --
(check-sat)
(get-model)
(exit)