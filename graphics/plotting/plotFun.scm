(texmacs-module (graphics plotting plotFun))

(load "rescaleFunctions.scm")
(load "setAxes.scm")
(load "calculateTicks.scm")
(load "setTicks.scm")
(load "setNumbers.scm")


(define pi (acos -1))
  
;; A function to define a point in the TeXmacs graphics format using two coordinates
(define (pt x y)
  `(point ,(number->string x) ,(number->string y)))

;; A function to define a point in the TeXmacs graphics format using a list of two elements
(define (list->pt xy)
  `(point ,(number->string (car xy)) ,(number->string (cadr xy))))

;; A function that plots functions

;; ;; https://stackoverflow.com/questions/21176956/how-to-convert-string-to-variable-name-in-scheme
;; ;; https://stackoverflow.com/a/21177216
;; ;; slightly modified
;; (define-syntax string->variable-name
;;     (syntax-rules ()
;;       ((_ str)
;;        (string? (syntax->datum #'str))
;;        (datum->syntax #'str (string->symbol (syntax->datum #'str))))))

;; https://www.cs.bham.ac.uk/research/projects/poplog/paradigms_lectures/lecture5.html
(define (append list1 list2)
        (if (null? list1) list2
            (cons (car list1) (append (cdr list1) list2))))

;; Have to write this because I have overwritten append (need to check whether append works both with Guile and with MIT Scheme: why did I redefine it?)
(define (appendMult lst)
  (if (equal? '() lst) '()
      (append (car lst) (appendMult (cdr lst)))))

;; define the list of points
;; https://stackoverflow.com/questions/43011660/constructing-a-list-of-numbers-in-scheme

(define (width range) ; takes for granted that the second element of range is larger than the first
  (- (cadr range) (car range)))

(define (step range)
  (/ (width range) 50)) ; set to 51 points per graph
  
(define (pts range)
  (let
      ((stp (step range)))
    (ptsList stp range)))

;; I need two procedures for the list of points,
;; one to calculate the margin and one to use it iteratively (as it must be always the same, i.e. it should not depend on range)

(define (ptsListMargin step range margin)
    (let
      ((start (car range))
       (stop (cadr range))) ; some leeway on the stop (need to define it separately because stop is called iteratively!)
    (cond ((> start (+ stop margin)) '())
	  (else (cons start (ptsListMargin step (list (+ start step) stop) margin))))))
  

(define (ptsList step range)
  (let
      ((start (car range))
       (stop (cadr range))
       (margin (* 0.02 (width range)))) ; some leeway on the stop (need to define it separately because stop is called iteratively!); 0.02 is chosen to work well with the 51 points that I chose
    (cond ((> start (+ stop margin)) '())
	  (else (cons start (ptsListMargin step (list (+ start step) stop) margin))))))


;; (define (ticksXGraphics funS rangeS)
;;   (let ((ticksGraphicsFun (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
;;     (map ticksGraphicsFun (ticksXLines funS rangeS))))
  
;; Converts a string to a procedure and evaluates it in the environment returned by (interaction-environment)

;; https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
(define (read-string text)
  (read
   (open-input-string text)))

;; https://stackoverflow.com/questions/6584818/in-r6rs-scheme-is-there-a-way-to-get-the-current-environment-for-use-with-eval
;; https://stackoverflow.com/a/6585081
(define (call-string text-lambda . args)
  (apply
    (eval (read-string text-lambda)  (interaction-environment)); https://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/scheme_14.html (for user-initial-environment)
    args)) ; (interaction-environment) for Guile (https://www.gnu.org/software/guile/manual/html_node/Environments.html#Environments)

(define (pairfun funString x)
  (begin
    ;; (display "\n")
    ;; (display x)
    ;; (display "\n")
    ;; (display fun)
    ;; (display "\n")
    ;; (display `(,fun ,x))
    ;; (display "\n")
    ;; (display (fun x))
    `(,x ,(call-string funString x))))

(define (funValues funString range)
  (map (lambda (x) (call-string funString x)) (pts range)))


;;; List of points for plotting
(define (ptlist funString range)
  (let ((pairfunLocal (lambda (x) (pairfun funString x))))
    (map pairfunLocal (pts range))))

(define (lineFun fun range)
  (begin
    ;; (display "\n")
    ;; (display range)
    ;; (display "\n")
    ;;(display  (append `(line) (map list->pt (ptlist fun))))
    ;; (append `(spline) (map list->pt (ptlist fun range))))) ; without rescaling
    (append `(spline) (map list->pt (rescalePairs (ptlist fun range)))))) ; with rescaling


;;; Function for input conversion
;; converts string into two numbers
;; note that the syntax of the string that represents the two numbers is strict at the moment
;; (there cannot be any space)
(define (convert-range rangeString)
  (begin
    ;; (display "\n")
    ;; (display "range conversion")
    ;; (display "\n")
    ;; (display  (string-split rangeString #\,))
  (map string->number (string-split rangeString #\,)))) ; split at commas https://www.gnu.org/software/guile/docs/docs-1.6/guile-ref/List-String-Conversion.html#List%2fString%20Conversion

;;;
;; Use as input functions defined with real numbers (insert the dot!!!)
;; (tm-define (plotFun2 fun range)
;; 	   (let ((funS (tree->stree fun))
;; 		 (rangeS (convert-range (tree->stree range)))) ; from tree to symbol
;; 	     (stree->tree
;; 	      `(with "gr-geometry" (tuple "geometry" "400px" "300px" "center")
;; 		     (graphics
;; 		      (with "color" "black" ,(lineFun funS rangeS)))))))
;; Try with cm instead of pixel

(define (ticksXGraphics funS rangeS)
  (let ((ticksGraphicsFun (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksXLines funS rangeS))))

(define (ticksYGraphics funS rangeS)
  (let ((ticksGraphicsFun (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksYLines funS rangeS))))


(define (numbersXGraphics funS rangeS)
  (let ((numbersGraphicsFun (lambda (x) `(with  "color" "black" ,x))))
    (map numbersGraphicsFun (numbersXPoints funS rangeS))))

(define (numbersYGraphics funS rangeS)
  (let ((numbersGraphicsFun (lambda (x) `(with  "color" "black" ,x))))
	(map numbersGraphicsFun (numbersYPoints funS rangeS))))


(define (compose-graphics funS rangeS)
  (begin
    ;; (display "\n testing graphics list \n")
    ;; (display "\n x- ticks \n")
    ;; (display  (ticksXGraphics funS rangeS))
    ;; (display "\n y-ticks \n")
    ;; (display  (ticksYGraphics funS rangeS))
    (appendMult ; have to use appendMult because of the own definition of append (is an own def. of append necessary?)
     (list
      `(graphics
	(with "color" "blue" "line-width" "1.5ln" ,(lineFun funS rangeS))
	(with "color" "black" "line-width" "0.75ln" ,(axX funS rangeS))
	(with "color" "black" "line-width" "0.75ln" ,(axY funS rangeS))
	(with "color" "black" "line-width" "0.75ln" ,(axXUp funS rangeS))
	(with "color" "black" "line-width" "0.75ln" ,(axYRight funS rangeS)))
      (ticksXGraphics funS rangeS)
      (ticksYGraphics funS rangeS)
      (numbersXGraphics funS rangeS)
      (numbersYGraphics funS rangeS)))))



(tm-define (plotFun fun range)
	   (let ((funS (tree->stree fun))
		 (rangeS (convert-range (tree->stree range)))) ; from tree to scheme-tree
	     (stree->tree
	      `(with "gr-geometry" (tuple "geometry" "9cm" "6cm" "center")
		     ,(compose-graphics funS rangeS)))))



;; ;; test function
;; (define testfun (lambda (x) (expt x 2)))
;; ;; https://schemers.org/Documents/Standards/R5RS/HTML/r5rs-Z-H-9.html#%_sec_6.2.5 for the raising to a power

;; (lineFun testfun)

;; ((lambda (x) (expt x 2)) 1)


;;((string->symbol "(lambda (x) (expt x 2))") 2)


;;(call-string "(lambda (x) (expt x 2))" 2)

;;(append '(1 2) '(3 4) '(4 5))

;;(fold append '()  (list (list '(1 2)) (list '(3 4)) (list '(4 5))))


