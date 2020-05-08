;; ;; 


(define (pairfun fun x)
  (begin
    ;; (display "\n")
    ;; (display x)
    ;; (display "\n")
    ;; (display fun)
    ;; (display "\n")
    ;; (display `(,fun ,x))
    ;; (display "\n")
    ;; (display (fun x))
    `(,x ,(fun x))))

(define (funValues funString range)
  (map (lambda (x) (funString x)) (pts range)))

;;; List of points for plotting
(define (ptlist funString range)
  (let ((pairfunLocal (lambda (x) (pairfun funString x))))
    (map pairfunLocal (pts range))))
