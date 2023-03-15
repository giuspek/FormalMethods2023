;  1---4
;  | \ |
;  2---3

(declare-const n11 Bool); node 1 color 1
(declare-const n12 Bool); node 1 color 2
(declare-const n13 Bool); node 1 color 3

(declare-const n21 Bool); node 2 color 1
(declare-const n22 Bool); node 2 color 2
(declare-const n23 Bool); node 2 color 3

(declare-const n31 Bool); node 3 color 1
(declare-const n32 Bool); node 3 color 2
(declare-const n33 Bool); node 3 color 3

(declare-const n41 Bool); node 4 color 1
(declare-const n42 Bool); node 4 color 2
(declare-const n43 Bool); node 4 color 3

(assert (or n11 n21 n31 n41)); node coloring with colors 
(assert (or n12 n22 n32 n42))
(assert (or n13 n23 n33 n43))
(assert (or n11 n12 n13)); all node must be colored
(assert (or n21 n22 n23))
(assert (or n31 n32 n33))
(assert (or n41 n42 n43))

(assert (not (and n11 n21))); check edges on colors
(assert (not (and n11 n41)))
(assert (not (and n11 n31)))

(assert (not (and n12 n22)))
(assert (not (and n12 n42)))
(assert (not (and n12 n32)))

(assert (not (and n13 n23)))
(assert (not (and n13 n43)))
(assert (not (and n13 n33)))

(assert (not (and n21 n31)))
(assert (not (and n31 n41)))

(assert (not (and n22 n32)))
(assert (not (and n32 n42)))

(assert (not (and n23 n33)))
(assert (not (and n33 n43)))

; with only 2 colors
;(assert (not n13))
;(assert (not n23))
;(assert (not n33))
;(assert (not n43))

(check-sat)
(get-model)
(exit)