;; ;;
;; findRangeXAll: 2020-05-13 should have a warning if graphsList is empty
;;              : 2020-05-13 it is not tail-recursive
;; findRangeYAll: 2020-05-13 should have a warning if graphsList is empty


(texmacs-module (defineFunctions)
		(:use (setPoints)
		      (setDefaults)))


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

(tm-define (funValues funString range nPoints)
	   	   (:secure)
	   (map (lambda (x) (funString x)) (pts range nPoints)))

;;; List of points for plotting
(tm-define (ptlist funString range nPoints)
	   	   (:secure)
	   (let ((pairfunLocal (lambda (x) (pairfun funString x))))
	     (map pairfunLocal (pts range nPoints))))

;; all of the values of all of the functions
(tm-define (funValuesAll graphsList)
	   	   (:secure)
	   ;; (display "\n")
	   ;; (display graphsList)
	   (if (null? graphsList)
	       '()
	       (let ((fun (cdr (assoc "function" (car graphsList))))
		     (range (cdr (assoc "range" (car graphsList))))
		     (nPoints (getOption "nPoints" (car graphsList) defaultOptions)))
		 (append (funValues fun range nPoints) (funValuesAll (cdr graphsList))))))

(tm-define (findRangeXAll graphsList) ;; should have a warning if graphsList is empty
	   	   (:secure)
	   (if (null? graphsList)
	       '()
	       (let ((range (cdr (assoc "range" (car graphsList)))))
		 (list (apply min (append range (findRangeXAll (cdr graphsList))))
		       (apply max (append range (findRangeXAll (cdr graphsList))))))))

(tm-define (findRangeYAll graphsList) ;; should have a warning if graphsList is empty
	   	   (:secure)
	   (if (null? graphsList)
	       '()
	       (list
		(apply min (funValuesAll graphsList))
		(apply max (funValuesAll graphsList)))))

;;; functions that act on syntax

;; https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
(tm-define (string->read text) ;renamed from read-string to avoid conflict with read-string of standard guile
	   	   (:secure)
  (read
   (open-input-string text)))







