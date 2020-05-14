;;; Possible idea: calculate the points at the extremes of the axis, scale each of them, assemble them into axes

;; !! See below:
;; I am recalculating function values with (ptList funString range), I should do it only once
;; Calculating function values only once will help with drawing more than one functio in the same graph


(texmacs-module  (graphics plotting setAxes)
		 (:use (graphics plotting rescaleFunctions)))

;; !! margin for X: the same as in the other function (for list of points I think)?
(tm-define (axLimsX auxs) 
  (let* ((rangeX (cdr (assoc "rangeX" auxs)))
	 (margin (/ (width rangeX) 10)))
    `(,(- (car rangeX) margin) ,(+ (cadr rangeX) margin))))

;; !! margin for Y: the same as in the other function (for list of points I think)?
;; !! rangeY: can it be calculated apart? Do I use it somewhere else?
(tm-define (axLimsY auxs)
  (let* ((rangeY (cdr (assoc "rangeY" auxs)))
	 (margin (/ (width rangeY) 10)))
    (begin
      ;; (display "\n ticks Y \n")
      ;; (display tksY)
      ;; (display "\n ax Y limits\n")
      ;; (display   `(,(car tksY) ,(lastElem tksY)))
      ;; (display "\n")
       `(,(- (car rangeY) margin) ,(+ (cadr rangeY) margin)))))

;;; Function that give the axes with original values

(define (axPtsX auxs)
  (let* ((limsX (axLimsX auxs))
	 (limsY (axLimsY auxs))
	 (xMin (apply min limsX))
	 (xMax (apply max limsX))
	 (yMin (apply min limsY)))
    (begin
      ;; (display "\n ax points X \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(cadr limsX) ,(car limsY))))
      ;; (display "\n")
      (list `( ,xMin ,yMin) `( ,xMax ,yMin)))))

(define (axPtsXUp auxs) ; the upper X axis
  (let ((limsX (axLimsX auxs))
	(limsY (axLimsY auxs)))
    (begin
      ;; (display "\n ax points X \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(cadr limsX) ,(car limsY))))
      ;; (display "\n")
    (list `( ,(car limsX) ,(cadr limsY)) `( ,(cadr limsX) ,(cadr limsY))))))

(define (axPtsY auxs)
  (let ((limsX (axLimsX auxs))
	(limsY (axLimsY auxs)))
    (begin
      ;; (display "\n ax points Y \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))
      ;; (display "\n")
      (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))))

(define (axPtsYRight auxs) ; the y axis on the right
  (let ((limsX (axLimsX auxs))
	(limsY (axLimsY auxs)))
    (begin
      ;; (display "\n ax points Y \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))
      ;; (display "\n")
    (list `( ,(cadr limsX) ,(car limsY)) `( ,(cadr limsX) ,(cadr limsY))))))

;;; Axes with rescaled values
;; the axes need to be rescaled to the function, not to themselves!

;; ?? Can I rescale each limit point of the axes, then assemble them?
;; ?? Are the comments on using szX and szY correct? I am seeing the same command
;; (rescalePairsRef axPts (ptlist funString range)) applied to different sets of points
;; !! I am recalculating function values with (ptList funString range), I should do it only once

;; (define (axX funString range)
;;   (let ((axPts (axPtsX funString range)))
;;     (append '(line)
;; 	    (map list->pt
;; 		 (rescalePairsRef axPts (ptlist funString range))))))
;; 					; uses szX (for x-axis scaling)

(tm-define (axX auxs)
   (let ((axPts (axPtsX auxs)))
    (append '(line)
	    (map list->pt
		 (rescalePairs axPts auxs)))))
					; uses szX (for x-axis scaling)

(tm-define (axXUp auxs)
  (let ((axPts (axPtsXUp auxs)))
    (append '(line)
	    (map list->pt
		 (rescalePairs axPts auxs)))))
					; uses szX (for x-axis scaling)

(tm-define (axY auxs)
  (let ((axPts (axPtsY auxs)))
    (append '(line)
	    (map list->pt
		 (rescalePairs axPts auxs)))))
					; uses szY (for y-axis scaling)

(tm-define (axYRight auxs)
  (let ((axPts (axPtsYRight auxs)))
    (append '(line)
	    (map list->pt
		 (rescalePairs axPts auxs)))))
					; uses szY (for y-axis scaling)
