(texmacs-module  (graphics plotting graphicsDefinitions))

;; (define pi (acos -1))


;;; auxiliary functions

;; base ten log
;; leave here for the moment because it is the only basic function I am defining in the whole program
;; Do not need as it exists in Guile
;; (tm-define (log10 x) (/ (log x) (log 10)))
  
;; A function to define a point in the TeXmacs graphics format using two coordinates
(define (pt x y)
  `(point ,(number->string x) ,(number->string y)))

;; A function to define a point in the TeXmacs graphics format using a list of two elements
(tm-define (list->pt xy)
  `(point ,(number->string (car xy)) ,(number->string (cadr xy))))

;; https://www.cs.bham.ac.uk/research/projects/poplog/paradigms_lectures/lecture5.html
;; Note that this conflicts with the definition in Guile and TeXmacs, causing errors
;; if made public with tm-define
;; (see below for list of errors)
(define (append list1 list2)
        (if (null? list1) list2
            (cons (car list1) (append (cdr list1) list2))))

;; Have to write this because I have overwritten append (need to check whether append works both with Guile and with MIT Scheme: why did I redefine it?)
;; appendMult works on a list of lists, eliminating a set of parentheses
;; but it is not equivalent to flatten as defined in
;; https://stackoverflow.com/a/8387641
(tm-define (appendMult lst)
  (if (equal? '() lst) '()
      (append (car lst) (appendMult (cdr lst)))))


;; home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: Wrong number of arguments to #<procedure append (list1 list2)>
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: While evaluating arguments to append in expression (apply append (cons head tail)):
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: Wrong number of arguments to #<procedure append (list1 list2)>
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: While evaluating arguments to append in expression (apply append (cons head tail)):
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: Wrong number of arguments to #<procedure append (list1 list2)>
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: While evaluating arguments to append in expression (apply append (cons head tail)):
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: Wrong number of arguments to #<procedure append (list1 list2)>
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/link/link-navigate.scm:183:3: While evaluating arguments to append in expression (let* (#) (if # l ...)):
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/link/link-navigate.scm:183:3: Wrong number of arguments to #<procedure append (list1 list2)>
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: While evaluating arguments to append in expression (apply append (cons head tail)):
;; /home/giovanni/Downloads/TeXMacs/TeXmacs-1.99.12-x86_64-pc-linux-gnu/TeXmacs/progs/source/macro-search.scm:46:37: Wrong number of arguments to #<procedure append (list1 list2)>

