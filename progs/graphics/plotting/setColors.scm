;; cycle a list
(define (cycleList lst)
  (append (cdr lst) (list (car lst))))

(define colorList
  '("blue" "red" "green"))

;; make a list of colors as long as the list of functions by cylcing through colorList
(define (colorListForThisPlot cList gList)
  (if (null? gList)
      '()
      (cons (car cList) (colorListForThisPlot (cycleList cList) (cdr gList)))))

;; (map (lambda (x y) (+ x y)) '(1 2 3) '(3 2 1))
  
