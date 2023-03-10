; -- Variables --
; Naming: x_ij, i being the node {A, B, C, D}, j being the color {R, G}

; Node A
(declare-const x_AR Bool)
(declare-const x_AG Bool)

; Node B
(declare-const x_BR Bool)
(declare-const x_BG Bool)

; Node C
(declare-const x_CR Bool)
(declare-const x_CG Bool)

; Node D
(declare-const x_DR Bool)
(declare-const x_DG Bool)


; -- Constraints --

; Nodes connected by an edge cannot have the same color
; From node A
(assert (=> x_AR (and (not x_BR) (not x_CR) (not x_DR))))
(assert (=> x_AG (and (not x_BG) (not x_CG) (not x_DG))))

; From node B
(assert (=> x_BR (and (not x_AR) (not x_DR))))
(assert (=> x_BG (and (not x_AG) (not x_DG))))

; From node C
(assert (=> x_CR (and (not x_AR) (not x_DR))))
(assert (=> x_CG (and (not x_AG) (not x_DG))))

; From node D
(assert (=> x_DR (and (not x_AR) (not x_BR) (not x_CR))))
(assert (=> x_DG (and (not x_AG) (not x_BG) (not x_CG))))


; -- Hidden constraints --

; At least one color per node
(assert (or x_AR x_AG))
(assert (or x_BR x_BG))
(assert (or x_CR x_CG))
(assert (or x_DR x_DG))

; At most one color per node
; Node A
(assert (=> x_AR (not x_AG)))
(assert (=> x_AG (not x_AR)))

; Node B
(assert (=> x_BR (not x_BG)))
(assert (=> x_BG (not x_BR)))

; Node C
(assert (=> x_CR (not x_CG)))
(assert (=> x_CG (not x_CR)))

; Node D
(assert (=> x_DR (not x_DG)))
(assert (=> x_DG (not x_DR)))

; -- Closing --
(check-sat)
(get-model)
(exit)