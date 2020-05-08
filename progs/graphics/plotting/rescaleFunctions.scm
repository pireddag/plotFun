;;; rescale the function to the size of the image

;; I need these global to use them in other functions too
;; they could be maybe modified to be flexible to deal with flexible windows
;; (probably the size of the window in the function that does the plotting needs to be defined through
;; the same variable)
(define szX 9)
(define szY 6)

;; (define (funMax fun range)
;;   (apply max (funValues fun range))); I wonder why max is not defined for lists and has to be applied to them with apply

;; (define (funMin fun range)
;;   (apply min (funValues fun range))); I wonder why min is not defined for lists

;; rescaleFun rescales x to the interval -sz/2, sz/2 considering xMax mapped to sz/2 and xMin to -sz/2
(define (rescaleFun x xMin xMax sz)
  (+ (- (/ (* 0.61 sz) 2)) (* (- x xMin) (/ (* 0.70 sz) (- xMax xMin))))) 
;; the 0.61 for the lower limit tries to make it so that the tick labels for the y-axis appear completely, but I need to rethink it completely
;; (when the tick labels are shorter, I could leave more space for the graph). It is set so to fit numbers of three digits and a sign

;; (define (rescale vals sz range)
;;   (let
;;       ((valMin (apply min vals))
;;        (valMax (apply max vals)))
;;     (map (lambda (x) (rescaleFun x valMin valMax sz)) vals)))

(define (rescale vals sz range)
  (let
      ((valMin (apply min range)) ;; why do I use apply
       (valMax (apply max range)))
    (map (lambda (x) (rescaleFun x valMin valMax sz)) vals)))

;; rescale using as scale a reference list of values
;; I will use this to rescale axes around function values
(define (rescaleRef vals valsRef sz)
   (let
      ((valMin (apply min valsRef))
       (valMax (apply max valsRef)))
     (map (lambda (x) (rescaleFun x valMin valMax sz)) vals)))

(define (rescalePairs pointsList auxs)
  (let ((xList (getXList pointsList))
	(yList (getYList pointsList))
	(rangeX (cdr (assoc "rangeX" auxs)))
	(rangeY (cdr (assoc "rangeY" auxs)))) ; szX and szY are defined globally
    (listPair (rescale xList szX rangeX) (rescale yList szY rangeY))))

;; rescale pairs using as scale a reference list of values
;; I will use this to rescale axes around function values
(define (rescalePairsRef pointsList pointsListRef)
  (let ((xList (getXList pointsList))
	(yList (getYList pointsList))
	(xListRef (getXList pointsListRef))
	(yListRef (getYList pointsListRef)))
    (listPair (rescaleRef xList xListRef szX) (rescaleRef yList yListRef szY)))) ; szX and szY are defined globally
