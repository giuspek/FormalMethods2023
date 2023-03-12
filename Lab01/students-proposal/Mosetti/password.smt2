(declare-const C1D1 Bool)
(declare-const C2D1 Bool)
(declare-const C3D1 Bool)

(declare-const C1D2 Bool)
(declare-const C2D2 Bool)
(declare-const C3D2 Bool)

(declare-const C1D3 Bool)
(declare-const C2D3 Bool)
(declare-const C3D3 Bool)

(declare-const C1D4 Bool)
(declare-const C2D4 Bool)
(declare-const C3D4 Bool)

; the password should be even
(assert (or C3D2 C3D4))

; we cannon use the same digit three times
(assert (not (and C1D1 C2D1 C3D1)))
(assert (not (and C1D2 C2D2 C3D2)))
(assert (not (and C1D3 C2D3 C3D3)))
(assert (not (and C1D4 C2D4 C3D4)))

; no adjacent repeated digit
(assert (not (and C1D1 C2D1)))
(assert (not (and C2D1 C3D1)))

(assert (not (and C1D2 C2D2)))
(assert (not (and C2D2 C3D2)))

(assert (not (and C1D3 C2D3)))
(assert (not (and C2D3 C3D3)))

(assert (not (and C1D4 C2D4)))
(assert (not (and C2D4 C3D4)))

; fill each cell
(assert (or C1D1 C1D2 C1D3 C1D4))
(assert (or C2D1 C2D2 C2D3 C2D4))
(assert (or C3D1 C3D2 C3D3 C3D4))

; no shared cell
(assert (=> C1D1 (not (or C1D2 C1D3 C1D4))))
(assert (=> C2D1 (not (or C2D2 C2D3 C2D4))))
(assert (=> C3D1 (not (or C3D2 C3D3 C3D4))))

(assert (=> C1D2 (not (or C1D1 C1D3 C1D4))))
(assert (=> C2D2 (not (or C2D1 C2D3 C2D4))))
(assert (=> C3D2 (not (or C3D1 C3D3 C3D4))))

(assert (=> C1D3 (not (or C1D2 C1D1 C1D4))))
(assert (=> C2D3 (not (or C2D2 C2D1 C2D4))))
(assert (=> C3D3 (not (or C3D2 C3D1 C3D4))))

(assert (=> C1D4 (not (or C1D2 C1D3 C1D1))))
(assert (=> C2D4 (not (or C2D2 C2D3 C2D1))))
(assert (=> C3D4 (not (or C3D2 C3D3 C3D1))))

; check for uniqueness
; (assert (not (and C1D3 C2D4 C3D2)))

(check-sat)
(get-model)
(exit)
