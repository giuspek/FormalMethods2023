(declare-const x11 Bool)
(declare-const x12 Bool)
(declare-const x13 Bool)

(declare-const x21 Bool)
(declare-const x22 Bool)
(declare-const x23 Bool)

(declare-const x31 Bool)
(declare-const x32 Bool)
(declare-const x33 Bool)

(declare-const x41 Bool)
(declare-const x42 Bool)
(declare-const x43 Bool)

(assert (or x23 x43)); end with even number
(assert (not ( and x11 x12 x13))); a number must not appear three times
(assert (not ( and x21 x22 x23)))
(assert (not ( and x31 x32 x33)))
(assert (not ( and x41 x42 x43)))

(assert (not (and x11 x12))); a number must not placed adjacent
(assert (not (and x13 x12)))
(assert (not (and x21 x22)))
(assert (not (and x23 x22)))
(assert (not (and x31 x32)))
(assert (not (and x33 x32))) 
(assert (not (and x41 x42))) 
(assert (not (and x43 x42)))

(assert (or x11 x21 x31 x41)); fill space
(assert (or x12 x22 x32 x42))
(assert (or x13 x23 x33 x43))

(assert (=> x11 (and (not x21) (not x31) (not x41) )))); check place
(assert (=> x21 (and (not x11) (not x31) (not x41) ))))
(assert (=> x31 (and (not x21) (not x11) (not x41) ))))
(assert (=> x41 (and (not x21) (not x31) (not x11) ))))

(assert (=> x12 (and (not x22) (not x32) (not x42) ))))
(assert (=> x22 (and (not x12) (not x32) (not x42) ))))
(assert (=> x32 (and (not x22) (not x12) (not x42) ))))
(assert (=> x42 (and (not x22) (not x32) (not x12) ))))

(assert (=> x13 (and (not x23) (not x33) (not x43) ))))
(assert (=> x23 (and (not x13) (not x33) (not x43) ))))
(assert (=> x33 (and (not x23) (not x13) (not x43) ))))
(assert (=> x43 (and (not x23) (not x33) (not x13) ))))

; chech uniqueness
;(assert (not x23))
;(assert (not x43))
;(assert (not x41))

(check-sat)
(get-model)
(exit)
