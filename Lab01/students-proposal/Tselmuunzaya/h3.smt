(declare-const a_is_guilty Bool)
(declare-const b_is_guilty Bool)
(declare-const c_is_guilty Bool)

(assert (and b_is_guilty (not c_is_guilty)))
(assert (=> a_is_guilty c_is_guilty))
(assert (and (not c_is_guilty) (or (or a_is_guilty b_is_guilty) (and a_is_guilty b_is_guilty))))

(check-sat)
(get-model)
(exit)
