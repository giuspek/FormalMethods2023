(set-option :produce-models true)
; (set-option :optimization true)
(set-option :opt.priority pareto)

; box optimization -> try to optimize both objectives independently and must use get-model
; Always call optimathsat with flag -optimization=true on command line

(define-fun adCost () Int 2000)
(define-fun customersPerAd () Int 2)
(define-fun ratingsPerAd () Int 1)
(define-fun timePerAd () Int 1)

(define-fun appearanceCost () Int 500)
(define-fun customersPerAppearance () Int 2)
(define-fun ratingsPerAppearance () Int 5)
(define-fun timePerAppearance () Int 2)

(define-fun companyGoalCustomers () Int 16)
(define-fun companyGoalRatings () Int 28)

(declare-const ads Int)
(declare-const appearances Int)

(define-fun tothours () Int (+ (* appearances timePerAppearance) (* ads timePerAd)))
(define-fun totcost () Int (+ (* appearances appearanceCost) (* ads adCost)))
(define-fun totratings () Int (+ (* appearances ratingsPerAppearance) (* ads ratingsPerAd)))
(define-fun totcustomers () Int (+ (* appearances customersPerAppearance) (* ads customersPerAd)))

(assert (>= appearances 0))
(assert (>= ads 0))

(assert (>= totcustomers 16))
(assert (>= totratings 28))

(minimize totcost :id money)
(minimize tothours :id time)

; check sat multiple time because we use pareto optimization
(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(check-sat)
(get-objectives)
(get-model)

(exit)