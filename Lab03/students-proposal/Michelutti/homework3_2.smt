; Use semi columns for comments
(set-option :produce-models true)

; shapes
(declare-const diamond Int)
(declare-const half_square Int)
(declare-const circle Int)
(declare-const pentagon Int)
(declare-const rectangle Int)

(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-const d Int)

(declare-const correct_a Bool)
(declare-const correct_b Bool)
(declare-const correct_c Bool)
(declare-const correct_d Bool)

; weights must be positive
(assert (> diamond 0))
(assert (> half_square 0))
(assert (> circle 0))
(assert (> pentagon 0))
(assert (> rectangle 0))

; weights must be different
(assert (not (= rectangle pentagon)))
; (assert (not (= rectangle half_square)))
(assert (not (= rectangle (* 2 half_square))))
(assert (not (= rectangle diamond)))
(assert (not (= rectangle circle)))
; (assert (not (= pentagon half_square)))
(assert (not (= pentagon (* 2 half_square))))
(assert (not (= pentagon diamond)))
(assert (not (= pentagon circle)))
; (assert (not (= circle half_square))) 
(assert (not (= circle (* 2 half_square))))
(assert (not (= circle diamond)))
; (assert (not (= diamond half_square)))
(assert (not (= diamond (* 2 half_square))))

; a b c d are defined as sums
(assert (= a (+ diamond diamond half_square half_square)))
(assert (= b (+ diamond half_square half_square)))
(assert (= c (* 3 half_square)))
(assert (= d (+ pentagon diamond)))

; diamond + complete square + circle = pentagon + 2 rectangle
(assert (= (+ diamond half_square half_square circle) (+ pentagon rectangle rectangle)))
; complete square + pentagon = complete square + circle + diamond
(assert (= (+ half_square half_square pentagon) (+ circle diamond half_square half_square)))

; checking what is 3 rectangle
(assert (or (or (= a (* 3 rectangle)) (= b (* 3 rectangle))) (or (= a (* 3 rectangle)) (= b (* 3 rectangle)))))

; checking what is correct
(assert (and (=> (= a (* 3 rectangle)) correct_a) (=> correct_a (= a (* 3 rectangle)))))
(assert (and (=> (= b (* 3 rectangle)) correct_b) (=> correct_b (= b (* 3 rectangle)))))
(assert (and (=> (= c (* 3 rectangle)) correct_c) (=> correct_c (= c (* 3 rectangle)))))
(assert (and (=> (= d (* 3 rectangle)) correct_d) (=> correct_d (= d (* 3 rectangle)))))


(check-sat)
(get-model)
(exit)