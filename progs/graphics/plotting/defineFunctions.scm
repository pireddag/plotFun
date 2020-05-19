;; ;;
;; findRangeXAll: 2020-05-13 should have a warning if graphsList is empty
;;              : 2020-05-13 it is not tail-recursive
;; findRangeYAll: 2020-05-13 should have a warning if graphsList is empty


(texmacs-module (graphics plotting defineFunctions)
		(:use (graphics plotting setPoints)))


(define (pairfun fun x)
    ;; (display "\n")
    ;; (display x)
    ;; (display "\n")
    ;; (display fun)
    ;; (display "\n")
    ;; (display `(,fun ,x))
    ;; (display "\n")
    ;; (display (fun x))
    `(,x ,(fun x)))

(tm-define (funValues funString range)
	   (map (lambda (x) (funString x)) (pts range)))

;;; List of points for plotting
(tm-define (ptlist funString range)
	   (let ((pairfunLocal (lambda (x) (pairfun funString x))))
	     (map pairfunLocal (pts range))))

;; all of the values of all of the functions
(tm-define (funValuesAll graphsList)
	   ;; (display "\n")
	   ;; (display graphsList)
	   (if (null? graphsList)
	       '()
	       (let ((fun (cdr (assoc "function" (car graphsList))))
		     (range (cdr (assoc "range" (car graphsList)))))
		 (append (funValues fun range) (funValuesAll (cdr graphsList))))))

(tm-define (findRangeXAll graphsList) ;; should have a warning if graphsList is empty
	   (if (null? graphsList)
	       '()
	       (let ((range (cdr (assoc "range" (car graphsList)))))
		 (list (apply min (append range (findRangeXAll (cdr graphsList))))
		       (apply max (append range (findRangeXAll (cdr graphsList))))))))

(tm-define (findRangeYAll graphsList) ;; should have a warning if graphsList is empty
	   (if (null? graphsList)
	       '()
	       (list
		(apply min (funValuesAll graphsList))
		(apply max (funValuesAll graphsList)))))







