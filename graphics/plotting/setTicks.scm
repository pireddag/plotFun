;; Get the y-range from the function and the x-range
(define (calcRangeY funString rangeX)
  (let ((vals (funValues funString rangeX)))
    `(,(apply min vals) ,(apply max vals))))

;; List of points for axes and ticks
(define (setTicksX range)
  (setTicks range))

(define (setTicksY funString range)
  (let ((rangeY (calcRangeY funString range)))
    (setTicks rangeY)))

(define (ticksXPtsList funString range) ; temporary function; probably better to rewrite ticks based on axis (not on function range), calculate only once rangeY
  (let ((ticksX (setTicksX range))
	(rangeY (calcRangeY funString range))
	(limY (car (axLimsY funString range)))) ; the axis limits too should be calculated only once
	(let ((ticksLineFun (lambda (x) (list  `(,x ,limY) `(,x ,(+ limY (/ (width rangeY) 20))))))) ; I need to define this function apart (legibility of code)
					; the length of the ticks is 15 time smaller than the y-range (I have to make sure x- and y- ticks are the same.
					; Probably best to define their lengths in terms of the length of the scaled axes)
	  (begin
	    ;; (display "\n calculating ticks \n")
	    ;; (display "y limit \n")
	    ;; (display limY)
	    ;; (display "\n")
	    ;; (display "ticks \n")
	    ;; (display ticksX)
	    ;; (display "ticks length \n")
	    ;; (display  (/ (width range) 20))
	    (map ticksLineFun ticksX)))))

(define (ticksYPtsList funString range) ; temporary function; probably better to rewrite ticks based on axis (not on function range), calculate only once rangeY
  (let ((ticksY (setTicksY funString range))
	(rangeY (calcRangeY funString range))
	(limX (car (axLimsX funString range)))) ; the axis limits too should be calculated only once
	(let ((ticksLineFun (lambda (x) (list  `(,limX ,x) `(,(+ limX (/ (width range) (* 20 1.5))) ,x))))) ; I need to define this function apart (legibility of code)
					; the length of the ticks is defined so to be equal to the length of the ticks for the x-axis
	  (begin
	    ;; (display "\n calculating ticks \n")
	    ;; (display "x limit")
	    (map ticksLineFun ticksY)))))


(define (ticksXLines funString range)
  (let ((ticksPtLst (ticksXPtsList funString range))
	(lineFun (lambda (x) (append '(line) (map list->pt (rescalePairsRef x (ptlist funString range)))))))
					; the relative rescaling function could be defined once for all
					; instead of being recalculated each time
    (begin
      ;; (display "\n scaling ticks \n")
      ;; (display "\n original ticks \n")
      ;; (display ticksPtLst)
      ;; (display "\n range \n")
      ;; (display range)
      ;; (display "\n scaled ticks \n")
      ;; (display  (map lineFun ticksPtLst))
      (map lineFun ticksPtLst))))

(define (ticksYLines funString range)
  (let ((ticksPtLst (ticksYPtsList funString range))
	(lineFun (lambda (x) (append '(line) (map list->pt (rescalePairsRef x (ptlist funString range)))))))
					; the relative rescaling function could be defined once for all
					; instead of being recalculated each time
    (begin
      ;; (display "\n scaling ticks \n")
      ;; (display "\n original ticks \n")
      ;; (display ticksPtLst)
      ;; (display "\n range \n")
      ;; (display range)
      ;; (display "\n scaled ticks \n")
      ;; (display  (map lineFun ticksPtLst))
      (map lineFun ticksPtLst))))
