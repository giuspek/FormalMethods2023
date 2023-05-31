; Options
(set-option :produce-models true)

; Declarations

(declare-const diamond Int)
(declare-const half_square Int)
(declare-const circle Int)
(declare-const pentagon Int)
(declare-const rectangle Int)

; `comp` stands for `composition`
(declare-const comp_1 Int)
(declare-const comp_2 Int)
(declare-const comp_3 Int)
(declare-const comp_4 Int)
(declare-const comp_5 Int)
(declare-const comp_6 Int)

(declare-const correct_a Bool)
(declare-const correct_b Bool)
(declare-const correct_c Bool)
(declare-const correct_d Bool)


; Constraints

; Assign weights to temp variables
(assert (= comp_1 (+ diamond (* 2 half_square) circle)))
(assert (= comp_2 (+ pentagon rectangle rectangle)))
(assert (= comp_3 (+ (* 2 half_square) pentagon)))
(assert (= comp_4 (+ circle diamond (* 2 half_square))))
(assert (= comp_5 (* 3 rectangle)))

(assert (= comp_1 comp_2))
(assert (= comp_3 comp_4))
(assert (= comp_5 comp_6))


; Positive weights
; No additional constraints, for instance that they should all be different, since it is not stated explicitly
(assert (> diamond 0))
(assert (> half_square 0))
(assert (> circle 0))
(assert (> pentagon 0))
(assert (> rectangle 0))

; Missing combination
(assert (or
    (= comp_6 (+ diamond (* 2 half_square) diamond))
    (= comp_6 (+ (* 2 half_square) diamond))
    (= comp_6 (+ (* 2 half_square) half_square))
    (= comp_6 (+ pentagon diamond))
))

; Checking the correct combination
(assert (= correct_a (= comp_6 (+ diamond (* 2 half_square) diamond))))
(assert (= correct_b (= comp_6 (+ (* 2 half_square) diamond))))
(assert (= correct_c (= comp_6 (+ (* 2 half_square) half_square))))
(assert (= correct_d (= comp_6 (+ pentagon diamond))))

; Only one combination is the correct one
(assert (=> correct_a (and (not correct_b) (not correct_c) (not correct_d))))
(assert (=> correct_b (and (not correct_a) (not correct_c) (not correct_d))))
(assert (=> correct_c (and (not correct_a) (not correct_b) (not correct_d))))
(assert (=> correct_d (and (not correct_a) (not correct_b) (not correct_c))))


; Actions
(check-sat)
(get-model)
(exit)