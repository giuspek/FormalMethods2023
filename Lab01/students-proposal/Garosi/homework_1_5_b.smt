; -- Variables --
; Naming: x_ij, i being the node {A, B, C, D}, j being the color {R, G, B}

; Node A
(declare-const x_AR Bool)
(declare-const x_AG Bool)
(declare-const x_AB Bool)

; Node B
(declare-const x_BR Bool)
(declare-const x_BG Bool)
(declare-const x_BB Bool)

; Node C
(declare-const x_CR Bool)
(declare-const x_CG Bool)
(declare-const x_CB Bool)

; Node D
(declare-const x_DR Bool)
(declare-const x_DG Bool)
(declare-const x_DB Bool)


; -- Constraints --

; Nodes connected by an edge cannot have the same color
; From node A
(assert (=> x_AR (and (not x_BR) (not x_CR) (not x_DR))))
(assert (=> x_AG (and (not x_BG) (not x_CG) (not x_DG))))
(assert (=> x_AB (and (not x_BB) (not x_CB) (not x_DB))))

; From node B
(assert (=> x_BR (and (not x_AR) (not x_DR))))
(assert (=> x_BG (and (not x_AG) (not x_DG))))
(assert (=> x_BB (and (not x_AB) (not x_DB))))

; From node C
(assert (=> x_CR (and (not x_AR) (not x_DR))))
(assert (=> x_CG (and (not x_AG) (not x_DG))))
(assert (=> x_CB (and (not x_AB) (not x_DB))))

; From node D
(assert (=> x_DR (and (not x_AR) (not x_BR) (not x_CR))))
(assert (=> x_DG (and (not x_AG) (not x_BG) (not x_CG))))
(assert (=> x_DB (and (not x_AB) (not x_BB) (not x_CB))))


; -- Hidden constraints --

; At least one color per node
(assert (or x_AR x_AG x_AB))
(assert (or x_BR x_BG x_BB))
(assert (or x_CR x_CG x_CB))
(assert (or x_DR x_DG x_DB))

; At most one color per node
; Node A
(assert (=> x_AR (and (not x_AG) (not x_AB))))
(assert (=> x_AG (and (not x_AR) (not x_AB))))
(assert (=> x_AB (and (not x_AR) (not x_AG))))

; Node B
(assert (=> x_BR (and (not x_BG) (not x_BB))))
(assert (=> x_BG (and (not x_BR) (not x_BB))))
(assert (=> x_BB (and (not x_BR) (not x_BG))))

; Node C
(assert (=> x_CR (and (not x_CG) (not x_CB))))
(assert (=> x_CG (and (not x_CR) (not x_CB))))
(assert (=> x_CB (and (not x_CR) (not x_CG))))

; Node D
(assert (=> x_DR (and (not x_DG) (not x_DB))))
(assert (=> x_DG (and (not x_DR) (not x_DB))))
(assert (=> x_DB (and (not x_DR) (not x_DG))))


; -- Closing --
(check-sat)
(get-model)
(exit)