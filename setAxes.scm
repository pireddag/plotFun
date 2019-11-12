(define (axLimsX funString range)
  (let ((margin (/ (width range) 10)))
    `(,(- (car range) margin) ,(+ (cadr range) margin))))

(define (axLimsY funString range)
  (let ((rangeY (calcRangeY funString range)))
    (let ((margin (/ (width rangeY) 10)))
    (begin
      ;; (display "\n ticks Y \n")
      ;; (display tksY)
      ;; (display "\n ax Y limits\n")
      ;; (display   `(,(car tksY) ,(lastElem tksY)))
      ;; (display "\n")
       `(,(- (car rangeY) margin) ,(+ (cadr rangeY) margin))))))

(define (axPtsX funString range)
  (let ((limsX (axLimsX funString range))
	(limsY (axLimsY funString range)))
    (begin
      ;; (display "\n ax points X \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(cadr limsX) ,(car limsY))))
      ;; (display "\n")
      (list `( ,(car limsX) ,(car limsY)) `( ,(cadr limsX) ,(car limsY))))))

(define (axPtsXUp funString range) ; the upper X axis
  (let ((limsX (axLimsX funString range))
	(limsY (axLimsY funString range)))
    (begin
      ;; (display "\n ax points X \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(cadr limsX) ,(car limsY))))
      ;; (display "\n")
    (list `( ,(car limsX) ,(cadr limsY)) `( ,(cadr limsX) ,(cadr limsY))))))

(define (axPtsY funString range)
  (let ((limsX (axLimsX funString range))
	(limsY (axLimsY funString range)))
    (begin
      ;; (display "\n ax points Y \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))
      ;; (display "\n")
      (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))))

(define (axPtsYRight funString range) ; the y axis on the right
  (let ((limsX (axLimsX funString range))
	(limsY (axLimsY funString range)))
    (begin
      ;; (display "\n ax points Y \n")
      ;; (display  (list `( ,(car limsX) ,(car limsY)) `( ,(car limsX) ,(cadr limsY))))
      ;; (display "\n")
    (list `( ,(cadr limsX) ,(car limsY)) `( ,(cadr limsX) ,(cadr limsY))))))

;; the axes need to be rescaled to the function, not to themselves!
;; I am recalculating function values with (ptList funString range), I should do it only once
(define (axX funString range)
  (let ((axPts (axPtsX funString range)))
    (append '(line) (map list->pt (rescalePairsRef axPts (ptlist funString range)))))) ; uses szX (for x-axis scaling)

(define (axXUp funString range)
  (let ((axPts (axPtsXUp funString range)))
    (append '(line) (map list->pt (rescalePairsRef axPts (ptlist funString range)))))) ; uses szX (for x-axis scaling)

(define (axY funString range)
  (let ((axPts (axPtsY funString range)))
    (append '(line) (map list->pt (rescalePairsRef axPts (ptlist funString range)))))) ; uses szY (for y-axis scaling)

(define (axYRight funString range)
  (let ((axPts (axPtsYRight funString range)))
    (append '(line) (map list->pt (rescalePairsRef axPts (ptlist funString range)))))) ; uses szY (for y-axis scaling)
