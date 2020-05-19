;;; rescale the function to the size of the image

(texmacs-module (graphics plotting rescaleFunctions)
		(:use (graphics plotting listOperations)))

;; I need these global to use them in other functions too
;; they could be maybe modified to be flexible to deal with flexible windows
;; (probably the size of the window in the function that does the plotting needs to be defined through
;; the same variable)
(define szX 9)
(define szY 6)



;; rescaleFun rescales x to the interval -sz/2, sz/2 considering xMax mapped to sz/2 and xMin to -sz/2
(define (rescaleFun x xMin xMax sz)
  (+ (- (/ (* 0.61 sz) 2)) (* (- x xMin) (/ (* 0.70 sz) (- xMax xMin))))) 
;; the 0.61 for the lower limit tries to make it so that the tick labels for the y-axis appear completely, but I need to rethink it completely
;; (when the tick labels are shorter, I could leave more space for the graph). It is set so to fit numbers of three digits and a sign

(define (rescale vals sz range)
  (let
      ((valMin (apply min range)) ;; why do I use apply: because min and max are not defined for lists
       (valMax (apply max range)))
    (map (lambda (x) (rescaleFun x valMin valMax sz)) vals)))



(tm-define (rescalePairs pointsList auxs)
  (let ((xList (getXList pointsList))
	(yList (getYList pointsList))
	(rangeX (cdr (assoc "rangeX" auxs)))
	(rangeY (cdr (assoc "rangeY" auxs)))) ; szX and szY are defined globally
    (listPair (rescale xList szX rangeX) (rescale yList szY rangeY))))


