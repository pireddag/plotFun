;; Two functions for the pairs of points that mark the start and end of each tick

(texmacs-module  (setTicks)
		 (:use (graphicsDefinitions)
		       (calculateTicks)
		       (setAxes)))

(define (ticksXLineFun x limCoord rangeCoord factor)
  (list
   `(,x ,limCoord)
   `(,x ,(+ limCoord (/ (width rangeCoord) factor)))))

(define (ticksYLineFun y limCoord rangeCoord factor)
  (list
   `(,limCoord ,y)
   `(,(+ limCoord (/ (width rangeCoord) factor)) ,y)))

;; In the current way I am forced to have the same calculations in the axes and in the ticks
;; so that axes and ticks are consistent with each other

(define (ticksXPtsList auxs) ; temporary function; probably better to rewrite ticks based on axis (not on function range)
  (let* ((rangeX (cdr (assoc "rangeX" auxs)))
	 (rangeY (cdr (assoc "rangeY" auxs)))
	 (ticksX (setTicks rangeX))
	 (limY (car (axLimsY auxs))); the axis limits too should be calculated only once (or maybe with a function?)
	 (tksLineFun (lambda (x) (ticksXLineFun x limY rangeY 20))))
    ;; the length of the ticks is 20 time smaller than the y-range
    ;; (I have to make sure x- and y- ticks are the same.
    ;; Probably best to define their lengths in terms of the length of the scaled axes)
    (map tksLineFun ticksX)))
					; (display "\n calculating ticks \n")
					; (display "y limit \n")
					; (display limY)
					; (display "\n")
					; (display "ticks \n")
					; (display ticksX)
					; (display "ticks length \n")
					; (display  (/ (width range) 20))

(define (ticksYPtsList auxs) ; temporary function; probably better to rewrite ticks based on axis (not on function range)
  (let* ((rangeX (cdr (assoc "rangeX" auxs)))
	 (rangeY (cdr (assoc "rangeY" auxs)))
	 (ticksY (setTicks rangeY))
	 (limX (car (axLimsX auxs))); the axis limits too should be calculated only once
	 (tksLineFun (lambda (x) (ticksYLineFun x limX rangeX (* 20 1.5)))))
    ;; the length of the ticks is defined so to be equal to the length of the ticks for the x-axis (therefore the scaling factor is (* 20 1.5)
    (map tksLineFun ticksY)))
;; (display "\n calculating ticks \n")
;; (display "x limit")


(tm-define (ticksXLines auxs)
	   	   (:secure)
	   (let ((ticksPtLst (ticksXPtsList auxs))
		 (lineFun (lambda (x)
			    (append '(line)
				    (map list->pt
					 (rescalePairs x auxs))))))
	     (map lineFun ticksPtLst)))
;; (display "\n scaling ticks \n")
;; (display "\n original ticks \n")
;; (display ticksPtLst)
;; (display "\n range \n")
;; (display range)
;; (display "\n scaled ticks \n")
;; (display  (map lineFun ticksPtLst))

(tm-define (ticksYLines auxs)
	   	   (:secure)
	   (let ((ticksPtLst (ticksYPtsList auxs))
		 (lineFun (lambda (x)
			    (append '(line)
				    (map list->pt
					 (rescalePairs x auxs))))))
	     (map lineFun ticksPtLst)))
;; (display "\n scaling ticks \n")
;; (display "\n original ticks \n")
;; (display ticksPtLst)
;; (display "\n range \n")
;; (display range)
;; (display "\n scaled ticks \n")
;; (display  (map lineFun ticksPtLst))
