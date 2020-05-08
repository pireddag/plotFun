;; !! See if global calculations of
;; range for Y values
;; axes (axes limits or also other things?)
;; ticks
;; a relative rescaling function (do I have to define just one? Do I need to rescale relative to the function valus only?)
;;
;; can be used for simplifying this function



;;; Lists for numbers

(define (numbersXPtsList auxs) ; temporary function, to fix with global calculations of axes and ticks
  (let* ((rangeX (cdr (assoc "rangeX" auxs)))
	 (rangeY (cdr (assoc "rangeY" auxs)))
	 (ticksXPos (setTicks rangeX))
	 (limY (car (axLimsY auxs))) ; the axis limits too should be calculated only once
	 (numbersPointFun (lambda (x) (list x (- limY (/ (width rangeY) 12)))))) ; function that adjusts the position of the number based on the position of the tick
      ;; can be probably defined apart (I need one for x and one for y)
      (map numbersPointFun ticksXPos)))

(define (numbersYPtsList auxs) ; temporary function, to fix with global calculations of axes and ticks
  (let* ((rangeX (cdr (assoc "rangeX" auxs)))
	 (rangeY (cdr (assoc "rangeY" auxs)))
	 (ticksYPos (setTicks rangeY))
	 (limX (car (axLimsX auxs))) ; the axis limits too should be calculated only once
	 (numbersPointFun (lambda (x) (list (- limX (/ (width rangeX) (* 24 1.5))) x))))
					; the factor 24 that divides (width range) is found by trial and error, 1.5 accounts for the different width of
					; the figure in the x direction - it places the tick labels at a good distance from the y-axis
      (begin
	;; (display "\n check y-numbers \n")
	;; (display "y-ticks \n")
	;; (display ticksY)
	(map numbersPointFun ticksYPos))))

(define (numbersXPoints auxs)
  (let ((numbersPtLst (numbersXPtsList auxs))
	(pointFun
	 (lambda (x)
	   (list 'with "text-at-halign" "center"
		 (list 'text-at (number->string (car x))
		       (list->pt (car (rescalePairs (list x) auxs))))))))
					; some hacks to use the rescalePairsRef function with single points
					; the relative rescaling function could be defined once for all
					; instead of being recalculated each time
    (begin
      ;; (display "\n calculating numbers \n")
      ;; (display numbersPtLst)
      ;; (display "\n first point \n")
      ;; (display (pointFun (car numbersPtLst)))
      (map pointFun numbersPtLst))))

(define (numbersYPoints auxs)
  (let ((numbersPtLst (numbersYPtsList auxs))
	(pointFun (lambda (x)
		    (list 'with "text-at-valign" "center" "text-at-halign" "right"
			  (list 'text-at (number->string (cadr x))
				(list->pt (car (rescalePairs (list x) auxs))))))))
					; cadr because we want the second coordinate
					; some hacks to use the rescalePairsRef function with single points
					; the relative rescaling function could be defined once for all
					; instead of being recalculated each time
    (begin
      ;; (display "\n calculating numbers \n")
      ;; (display numbersPtLst)
      ;; (display "\n first point \n")
      ;; (display (pointFun (car numbersPtLst)))
      (map pointFun numbersPtLst))))
