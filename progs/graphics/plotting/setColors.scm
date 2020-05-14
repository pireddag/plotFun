;; cycle a list
(define (cycleList lst)
  (append (cdr lst) (list (car lst))))

;;(define colorList
;;  '("blue" "red" "green"))
;; gnuplot colors
;; http://www.gnuplot.info/ReleaseNotes_5_0_7.html
;; red/green/blue/magenta/cyan/yellow
;; (define colorList
;;   '("blue" "red" "green" "magenta" "cyan" "yellow"))

(define colorList
  '("blue" "red" "green" "#007f00" "cyan" "yellow"))

;; make a list of colors as long as the list of functions by cycling through colorList
(define (colorListForThisPlot cList gList)
  (if (null? gList)
      '()
      (cons (car cList) (colorListForThisPlot (cycleList cList) (cdr gList)))))

;; (map (lambda (x y) (+ x y)) '(1 2 3) '(3 2 1))
  
