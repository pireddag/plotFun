(texmacs-module (graphics plotting listOperations))

(tm-define (getXList pointsList)
  (cond ((null? pointsList) '())
	(else (cons (car (car pointsList)) (getXList (cdr pointsList))))))

(tm-define (getYList pointsList)
  (cond ((null? pointsList) '())
	(else (cons (cadr (car pointsList)) (getYList (cdr pointsList)))))) ; (cadr (car ...) gets the y element of the first element of the list

(tm-define (listPair xList yList) ; assuming xList and yList are lists of the same length, generates the list of pairs
  (cond ((null? xList) '())
	(else (cons `(,(car xList) ,(car yList)) (listPair (cdr xList) (cdr yList))))))

;; Get the y-range from the function and the x-range
(define (calcRangeY funString rangeX)
  (let ((vals (funValues funString rangeX)))
    `(,(apply min vals) ,(apply max vals))))
