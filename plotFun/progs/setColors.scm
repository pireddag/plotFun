(texmacs-module (setColors))

;; cycle a list
(tm-define (cycleList lst)
	   	   (:secure)
  (append (cdr lst) (list (car lst))))

;;(define colorList
;;  '("blue" "red" "green"))
;; gnuplot colors
;; http://www.gnuplot.info/ReleaseNotes_5_0_7.html
;; red/green/blue/magenta/cyan/yellow
;; (define colorList
;;   '("blue" "red" "green" "magenta" "cyan" "yellow"))

(tm-define colorList
	   	   (:secure)
		   '("blue" "red" "green" "magenta" "cyan" "yellow"))
;; copied from gnuplot color list

;; (tm-define colorList
;; 	   	   (:secure)
;;   '("blue" "red" "green" "#007f00" "cyan" "yellow"))
;; experiment

;; make a list of colors as long as the list of functions by cycling through colorList
(tm-define (colorListForThisPlot cList gList)
	   	   (:secure)
  (if (null? gList)
      '()
      (cons (car cList) (colorListForThisPlot (cycleList cList) (cdr gList)))))

;; (map (lambda (x y) (+ x y)) '(1 2 3) '(3 2 1))
  
