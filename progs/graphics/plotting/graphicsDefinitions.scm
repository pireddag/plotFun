(define pi (acos -1))

;;; auxiliary functions
;; leave here for the moment because it is the only basic function I am defining in the whole program

(define (log10 x) (/ (log x) (log 10)))
  
;; A function to define a point in the TeXmacs graphics format using two coordinates
(define (pt x y)
  `(point ,(number->string x) ,(number->string y)))

;; A function to define a point in the TeXmacs graphics format using a list of two elements
(define (list->pt xy)
  `(point ,(number->string (car xy)) ,(number->string (cadr xy))))

;; https://www.cs.bham.ac.uk/research/projects/poplog/paradigms_lectures/lecture5.html
(define (append list1 list2)
        (if (null? list1) list2
            (cons (car list1) (append (cdr list1) list2))))

;; Have to write this because I have overwritten append (need to check whether append works both with Guile and with MIT Scheme: why did I redefine it?)
(define (appendMult lst)
  (if (equal? '() lst) '()
      (append (car lst) (appendMult (cdr lst)))))
