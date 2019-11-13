
;; Lists for numbers

(define (numbersXPtsList funString range) ; temporary function, to fix with global calculations of axes and ticks
  (let ((ticksX (setTicksX range))
        (rangeY (calcRangeY funString range))
	(limY (car (axLimsY funString range)))) ; the axis limits too should be calculated only once
    (let ((numbersPointFun (lambda (x) (list x (- limY (/ (width rangeY) 12))))))
      (map numbersPointFun ticksX))))

(define (numbersYPtsList funString range) ; temporary function, to fix with global calculations of axes and ticks
  (let ((ticksY (setTicksY funString range))
        (rangeY (calcRangeY funString range))
	(limX (car (axLimsX funString range)))) ; the axis limits too should be calculated only once
    (let ((numbersPointFun (lambda (x) (list (- limX (/ (width range) (* 24 1.5))) x))))
					; the factor 22 that divides (width range) is found by trial and error, 1.5 accounts for the different width of
					; the figure in the x direction - it places the tick labesl at a good distance from the y-axis
      (begin
	;; (display "\n check y-numbers \n")
	;; (display "y-ticks \n")
	;; (display ticksY)
	(map numbersPointFun ticksY)))))

(define (numbersXPoints funString range)
  (let ((numbersPtLst (numbersXPtsList funString range))
	(pointFun (lambda (x) (list 'with "text-at-halign" "center" (list 'text-at (number->string (car x)) (list->pt (car (rescalePairsRef (list x) (ptlist funString range)))))))))
					; some hacks to use the rescalePairsRef function with single points
					; the relative rescaling function could be defined once for all
					; instead of being recalculated each time
    (begin
      ;; (display "\n calculating numbers \n")
      ;; (display numbersPtLst)
      ;; (display "\n first point \n")
      ;; (display (pointFun (car numbersPtLst)))
      (map pointFun numbersPtLst))))

(define (numbersYPoints funString range)
  (let ((numbersPtLst (numbersYPtsList funString range))
	(pointFun (lambda (x) (list 'with "text-at-valign" "center" "text-at-halign" "right" (list 'text-at (number->string (cadr x)) (list->pt (car (rescalePairsRef (list x) (ptlist funString range)))))))))
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
