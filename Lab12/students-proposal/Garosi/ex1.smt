; Options
(set-option :produce-models true)
; (set-option :opt.priority box)

; Declarations

; The value represents on which server it goes
(declare-const vm0 Int)
(declare-const vm1 Int)
(declare-const vm2 Int)
(declare-const vm3 Int)
(declare-const vm4 Int)
(declare-const vm5 Int)
(declare-const vm6 Int)
(declare-const vm7 Int)
(declare-const vm8 Int)
(declare-const vm9 Int)
(declare-const vm10 Int)

; Counting how much free RAM is left per server
(define-fun srv_ram ((srv Int) (ram Int)) Int (- ram
    (+
    (ite (= vm0 srv) 1 0)
    (ite (= vm1 srv) 16 0)
    (ite (= vm2 srv) 4 0)
    (ite (= vm3 srv) 2 0)
    (ite (= vm4 srv) 4 0)
    (ite (= vm5 srv) 8 0)
    (ite (= vm6 srv) 2 0)
    (ite (= vm7 srv) 4 0)
    (ite (= vm8 srv) 16 0)
    (ite (= vm9 srv) 16 0)
    (ite (= vm10 srv) 12 0)
    )
))

; Counting how much free storage is left per server
(define-fun srv_sto ((srv Int) (sto Int)) Int (- sto
    (+
        (ite (= vm0 srv) 100 0)
        (ite (= vm1 srv) 900 0)
        (ite (= vm2 srv) 710 0)
        (ite (= vm3 srv) 800 0)
        (ite (= vm4 srv) 7000 0)
        (ite (= vm5 srv) 4000 0)
        (ite (= vm6 srv) 800 0)
        (ite (= vm7 srv) 2500 0)
        (ite (= vm8 srv) 450 0)
        (ite (= vm9 srv) 3700 0)
        (ite (= vm10 srv) 1300 0)
    )
))

; Counting how many servers are used
; To count them, just check if a server still has all of its
; RAM or if some is taken up by some VM
(define-fun utilized_servers () Int (+
    (ite (= (srv_ram 0 2) 2) 0 1)
    (ite (= (srv_ram 1 4) 4) 0 1)
    (ite (= (srv_ram 2 4) 4) 0 1)
    (ite (= (srv_ram 3 16) 16) 0 1)
    (ite (= (srv_ram 4 8) 8) 0 1)
    (ite (= (srv_ram 5 16) 16) 0 1)
    (ite (= (srv_ram 6 16) 16) 0 1)
    (ite (= (srv_ram 7 32) 32) 0 1)
    (ite (= (srv_ram 8 8) 8) 0 1)
    (ite (= (srv_ram 9 16) 16) 0 1)
    (ite (= (srv_ram 10 8) 8) 0 1)
))


; Constraints

; Cannot go with negative amount of RAM
(assert (>= (srv_ram 0 2) 0))
(assert (>= (srv_ram 1 4) 0))
(assert (>= (srv_ram 2 4) 0))
(assert (>= (srv_ram 3 16) 0))
(assert (>= (srv_ram 4 8) 0))
(assert (>= (srv_ram 5 16) 0))
(assert (>= (srv_ram 6 16) 0))
(assert (>= (srv_ram 7 32) 0))
(assert (>= (srv_ram 8 8) 0))
(assert (>= (srv_ram 9 16) 0))
(assert (>= (srv_ram 10 8) 0))

; Cannot go with negative amount of storage
(assert (>= (srv_sto 0 100) 0))
(assert (>= (srv_sto 1 800) 0))
(assert (>= (srv_sto 2 1000) 0))
(assert (>= (srv_sto 3 8000) 0))
(assert (>= (srv_sto 4 3000) 0))
(assert (>= (srv_sto 5 6000) 0))
(assert (>= (srv_sto 6 4000) 0))
(assert (>= (srv_sto 7 2000) 0))
(assert (>= (srv_sto 8 1000) 0))
(assert (>= (srv_sto 9 10000) 0))
(assert (>= (srv_sto 10 1000) 0))

; VMs must be assigned to servers
(assert (and (>= vm0 0) (<= vm0 10)))
(assert (and (>= vm1 0) (<= vm1 10)))
(assert (and (>= vm2 0) (<= vm2 10)))
(assert (and (>= vm3 0) (<= vm3 10)))
(assert (and (>= vm4 0) (<= vm4 10)))
(assert (and (>= vm5 0) (<= vm5 10)))
(assert (and (>= vm6 0) (<= vm6 10)))
(assert (and (>= vm7 0) (<= vm7 10)))
(assert (and (>= vm8 0) (<= vm8 10)))
(assert (and (>= vm9 0) (<= vm9 10)))
(assert (and (>= vm10 0) (<= vm10 10)))

; If we stop here, we get the following assignment:
; vm0 () Int 0
; vm1 () Int 7
; vm2 () Int 2
; vm3 () Int 10
; vm4 () Int 9
; vm5 () Int 3
; vm6 () Int 3
; vm7 () Int 4
; vm8 () Int 5
; vm9 () Int 6
; vm10 () Int 9

; Answering the first question, then: yes, it is possible to
; store the VMs on the available servers. However, 9 servers
; are utilized.

; Now let's try to minimize the number of server utilized (that is,
; maximize our profit!)


; Objectives

(minimize utilized_servers :id utilized_servers)

; Now only five servers are utilized. So, four servers less.


; Uniqueness
(assert (not (and
    (= vm0 3)
    (= vm1 7)
    (= vm2 3)
    (= vm3 5)
    (= vm4 9)
    (= vm5 3)
    (= vm6 5)
    (= vm7 5)
    (= vm8 7)
    (= vm9 6)
    (= vm10 9)
)))

; OptiMathSAT is able to find another solution, therefore it is not unique.


; Actions
(check-sat)
(get-objectives)
(get-model)
(exit)