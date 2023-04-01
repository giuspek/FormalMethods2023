(set-option :produce-models true)

; -- Variables --

; Row 1
(declare-const x11 Int)
(declare-const x12 Int)
(declare-const x13 Int)

; Row 2
(declare-const x21 Int)
(declare-const x22 Int)
(declare-const x23 Int)

; Row 3
(declare-const x31 Int)
(declare-const x32 Int)

; Row 4
(declare-const x42 Int)
(declare-const x43 Int)
(declare-const x44 Int)

; Row 5
(declare-const x52 Int)
(declare-const x53 Int)
(declare-const x54 Int)


; -- Constraints --

; Columns
(assert (= (+ x11 x21 x31) 9)) ; First column
(assert (= (+ x12 x22 x32 x42 x52) 34)) ; Second column
(assert (= (+ x13 x23) 4)) ; Third column, upper part
(assert (= (+ x43 x53) 11)) ; Third column, lower part
(assert (= (+ x44 x54) 3)) ; Fourth column

; Rows
(assert (= (+ x11 x12 x13) 9)) ; First row
(assert (= (+ x21 x22 x23) 13)) ; Second row
(assert (= (+ x31 x32) 13)) ; Third row
(assert (= (+ x42 x43 x44) 7)) ; Fourth row
(assert (= (+ x52 x53 x54) 19)) ; Fitfh row

; Each cell shall contain a number from 1 to 9
(assert (and (>= x11 1) (<= x11 9)))
(assert (and (>= x12 1) (<= x12 9)))
(assert (and (>= x13 1) (<= x13 9)))
(assert (and (>= x21 1) (<= x21 9)))
(assert (and (>= x22 1) (<= x22 9)))
(assert (and (>= x23 1) (<= x23 9)))
(assert (and (>= x31 1) (<= x31 9)))
(assert (and (>= x32 1) (<= x32 9)))
(assert (and (>= x42 1) (<= x42 9)))
(assert (and (>= x43 1) (<= x43 9)))
(assert (and (>= x44 1) (<= x44 9)))
(assert (and (>= x52 1) (<= x52 9)))
(assert (and (>= x53 1) (<= x53 9)))
(assert (and (>= x54 1) (<= x54 9)))

; Distinct values across each row and each column
(assert (distinct x11 x12 x13)) ; First row
(assert (distinct x21 x22 x23)) ; Second row
(assert (distinct x31 x32)) ; Third row
(assert (distinct x42 x43 x44)) ; Fourth row
(assert (distinct x52 x53 x54)) ; Fifth row

(assert (distinct x11 x21 x31)) ; First column
(assert (distinct x12 x22 x32 x42 x52)) ; Second column
(assert (distinct x13 x23)) ; Third column, upper part
(assert (distinct x43 x53)) ; Third column, lower part
(assert (distinct x44 x54)) ; Fifth column


; -- Closing --
(check-sat)
(get-model)
(exit)