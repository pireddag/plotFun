(texmacs-module (graphics plotting plotFun)
		(:use (graphics plotting defineFunctions)
		      (graphics plotting setPoints)
		      (graphics plotting graphicsDefinitions)
		      (graphics plotting setTicks)
		      (graphics plotting inputFromFile)
		      (graphics plotting setAxes)
		      (graphics plotting listOperations)
		      (graphics plotting setColors)
		      (graphics plotting setNumbers)
		      (graphics plotting setLabels)))


;; https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
(define (string->read text) ;renamed from read-string to avoid conflict with read-string of standard guile
  (read
   (open-input-string text)))

(define diag '()) ;; diagnostics
(define graphsListStr '()) ;; initialize to empty string in order to be able to place the symbol in the "safe" module we are going to set up
;; it is then possible to set it to something else (we will set it to the association list in string form) before calling eval onto it

(define (make-pure-math-module)
  (let ((m (make-module)))
    (begin
      ;; math symbols
      (module-define! m '* *)
      (module-define! m '- -)
      (module-define! m '+ +)
      (module-define! m '/ /)
      (module-define! m 'abs abs)
      (module-define! m 'max max)
      (module-define! m 'min min)
      (module-define! m 'truncate truncate)
      (module-define! m 'round round)
      (module-define! m 'floor floor)
      (module-define! m 'ceiling ceiling)
      ;; a few are still missing, but I have to check if they are present in Guile 1.8
      (module-define! m 'sqrt sqrt)
      (module-define! m 'expt expt)
      (module-define! m 'sin sin)
      (module-define! m 'cos cos)
      (module-define! m 'tan tan)
      (module-define! m 'asin asin)
      (module-define! m 'acos acos)
      (module-define! m 'atan atan)
      (module-define! m 'exp exp)
      (module-define! m 'log log)
      (module-define! m 'log10 log10)
      (module-define! m 'sinh sinh)
      (module-define! m 'cosh cosh)
      (module-define! m 'tanh tanh)
      (module-define! m 'asinh asinh)
      (module-define! m 'acosh acosh)
      (module-define! m 'atanh atanh)
      ;; other symbols
      (module-define! m 'lambda lambda)
      (module-define! m 'list list)
      (module-define! m 'quote quote)
      (module-define! m 'quasiquote quasiquote)
      (module-define! m 'string->read string->read)
      ;; symbol where the user-defined information will be contained
      (module-define! m 'graphsListStr graphsListStr))
    m))


;; A function that plots functions

;;; Function for input conversion
;; converts string into two numbers
;; note that the syntax of the string that represents the two numbers is strict at the moment
;; (there cannot be any space)
(define (rangeString->list rangeString)
    ;; (display "\n")
    ;; (display "range conversion")
    ;; (display "\n")
    ;; (display  (string-split rangeString #\,))
    (map string->number (string-split rangeString #\,))) ; split at commas https://www.gnu.org/software/guile/docs/docs-1.6/guile-ref/List-String-Conversion.html#List%2fString%20Conversion


;; A function for the rescaled points
(define (lineFun fun range auxs)
    ;; (display "\n")
    ;; (display range)
    ;; (display "\n")
    ;;(display  (append `(line) (map list->pt (ptlist fun))))
    ;; (append `(spline) (map list->pt (ptlist fun range)))) ; without rescaling
    ;; read file
    (append `(spline) (map list->pt (rescalePairs (ptlist fun range) auxs))))        ; with rescaling

;;; https://stackoverflow.com/questions/8387583/writing-flatten-method-in-scheme
;; https://stackoverflow.com/a/8387641
;; 2020-05-19 written here to test whether it is possible to substitute it in for appendMult - not possible
;; (define (flatten x)
;;   (cond ((null? x) '())
;;         ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
;;         (else (list x))))


;;;

(define (ticksXGraphics auxs)
  (let ((ticksGraphicsFun
	 (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksXLines auxs))))

(define (ticksYGraphics auxs)
  (let ((ticksGraphicsFun
	 (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksYLines auxs))))

(define (numbersXGraphics auxs)
  (let ((numbersGraphicsFun (lambda (x) `(with  "color" "black" ,x))))
    (map numbersGraphicsFun (numbersXPoints auxs))))

(define (numbersYGraphics auxs)
  (let ((numbersGraphicsFun (lambda (x) `(with  "color" "black" ,x))))
    (map numbersGraphicsFun (numbersYPoints auxs))))


(define (lineGraphics fun range color auxs)
  `(with "color" ,color "line-width" "1.5ln" ,(lineFun fun range auxs)))

;; Mapping on several lists is standard in Scheme
;; Note also https://stackoverflow.com/questions/38589238/how-to-use-map-with-a-function-that-needs-more-arguments
(define (lineGraphicsAll graphsList auxs)
  (let ((cList (colorListForThisPlot colorList graphsList)))
    (map (lambda (x y)
	   (let ((fun (cdr (assoc "function" x)))
		 (range (cdr (assoc "range" x))))
	     (lineGraphics fun range y auxs)))
	 graphsList cList)))

(define (functionsGraphics graphsList auxs)
  (let ((fun (cdr (assoc "function" (car graphsList))))
	(range (cdr (assoc "range" (car graphsList)))))
    (appendMult ; 2020-05-19 appendMult works on a list of lists, eliminating a set of parentheses, but is not equivalent to flatten as defined in https://stackoverflow.com/a/8387641
     (list
      `(graphics)
      (lineGraphicsAll graphsList auxs)
      `((with "color" "black" "line-width" "0.75ln" ,(axX auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axY auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axYRight auxs)))))))


;; overall graphics function

(define (compose-graphics fileS)
  (set! graphsListStr (call-with-input-file fileS
			(lambda (dataPort) (readFile dataPort))))
  ;; (display graphsListStr)
  ;; define graphsList as
  ;; (graphsList (eval (string->read graphsListStr) (make-pure-math-module))
  ;; before running the commented lines
  ;; do not need to quote (string->read graphsListStr) as it is a symbol
  ;; see https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
  ;; (set! diag graphsList)
  ;; (display "\n")
  ;; (display diag)
  ;; (display "\n")
  ;; (display (car diag))
  ;; (display "\n")
  ;; (display (list? diag))
  ;; (display "\n")
  ;; (display (cdr diag))
  ;; (display "\n")
  ;; (display "\n")
  (let* ((graphsList (eval (string->read graphsListStr) (make-pure-math-module)))
	 ;; do not need to quote (string->read graphsListStr) as it is a symbol
	 ;; Example: 
	 ;;(graphsList (list
	 ;;		`(("function" . ,(lambda (x) ( - (expt x 2) 2.)))
	 ;;		  ("range" . ,(list -2. 2.)))))
	 (rangeX (findRangeXAll graphsList))
	 (rangeY (findRangeYAll graphsList))
	 (auxs `(("rangeX" . ,rangeX)
		 ("rangeY" . ,rangeY)))) ; function values (do I need it? 2020-05-13: no)
      ;; (display "\n testing graphics list \n")
      ;; (display "\n x- ticks \n")
      ;; (display  (ticksXGraphics funS rangeS))
      ;; (display "\n y-ticks \n")
      ;; (display  (ticksYGraphics funS rangeS))
      (appendMult ; have to use appendMult because of the own definition of append (is an own def. of append necessary?)
       (list
	(functionsGraphics graphsList auxs)
	(ticksXGraphics auxs)
	(ticksYGraphics auxs)
	(numbersXGraphics auxs)
	(numbersYGraphics auxs)
	(xLabel auxs)))))
;;;

(tm-define (plotFun definitionFile)
	   (let* ((fileS (tree->stree definitionFile))) ; from TeXmacs tree to scheme-tree
	     (stree->tree
	      `(with "gr-geometry" (tuple "geometry" "9cm" "6cm" "center")
		     ,(compose-graphics fileS)))))


;;; Old versions of functionsGraphics

;; (define (functionsGraphics graphsList auxs)
;;   (let ((fun (cdr (assoc "function" (car graphsList))))
;; 	(range (cdr (assoc "range" (car graphsList)))))
;;     (appendMult
;;      (list
;;      `(graphics)
;;      (list `(with "color" "blue" "line-width" "1.5ln" ,(lineFun fun range auxs)))
;;      `((with "color" "black" "line-width" "0.75ln" ,(axX auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axY auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axYRight auxs)))))))

;; (define (functionsGraphics graphsList auxs)
;;   (let ((fun (cdr (assoc "function" (car graphsList))))
;; 	(range (cdr (assoc "range" (car graphsList)))))
;;     (appendMult
;;      (list
;;      `(graphics)
;;      (list (lineGraphics fun range auxs))
;;      `((with "color" "black" "line-width" "0.75ln" ,(axX auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axY auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
;;        (with "color" "black" "line-width" "0.75ln" ,(axYRight auxs)))))))
