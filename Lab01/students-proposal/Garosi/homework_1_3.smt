; -- Variables --

; Letters refer to a person being guilty
(declare-const A_guilty Bool)
(declare-const B_guilty Bool)
(declare-const C_guilty Bool)


; -- Constraints --

; B is guilty and C is innocent
(assert (and B_guilty (not C_guilty)))

; If A is guilty, then C is also guilty
(assert (=> A_guilty C_guilty))

; C is innocent and one of the others, perhaps even the two, are guilty
(assert (and
    (not C_guilty)
    (or A_guilty B_guilty)
    )
)


; -- Hidden constraints --

; There is at least someone being guilty
(assert (or A_guilty B_guilty C_guilty))


; -- Uniqueness --
;(assert (not
;    (and
;        (not A_guilty)
;        B_guilty
;        (not C_guilty)
;    ))
;)

; -- Closing --
(check-sat)
(get-model)
(exit)