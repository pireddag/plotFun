(texmacs-module (graphics plotting_working_05 plotFun)
		(:use (graphics plotting_working_05 defineFunctions)
		      (graphics plotting_working_05 setPoints)))

(load "graphicsDefinitions.scm")
;(load "setPoints.scm")
(load "listOperations.scm")
;(load "defineFunctions.scm")
(load "rescaleFunctions.scm")
(load "setAxes.scm")
(load "calculateTicks.scm")
(load "setTicks.scm")
(load "setNumbers.scm")
(load "inputFromFile.scm")


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
      (module-define! m '* *)
      (module-define! m '- -)
      (module-define! m '+ +)
      (module-define! m 'expt expt)
      (module-define! m 'lambda lambda)
      (module-define! m 'list list)
      (module-define! m 'quote quote)
      (module-define! m 'quasiquote quasiquote)
      (module-define! m 'string->read string->read)
      (module-define! m 'graphsListStr graphsListStr))
    m))


;; A function that plots functions

;;; Function for input conversion
;; converts string into two numbers
;; note that the syntax of the string that represents the two numbers is strict at the moment
;; (there cannot be any space)
(define (rangeString->list rangeString)
  (begin
    ;; (display "\n")
    ;; (display "range conversion")
    ;; (display "\n")
    ;; (display  (string-split rangeString #\,))
    (map string->number (string-split rangeString #\,)))) ; split at commas https://www.gnu.org/software/guile/docs/docs-1.6/guile-ref/List-String-Conversion.html#List%2fString%20Conversion


;; A function for the rescaled points
(define (lineFun fun range auxs)
  (begin
    ;; (display "\n")
    ;; (display range)
    ;; (display "\n")
    ;;(display  (append `(line) (map list->pt (ptlist fun))))
    ;; (append `(spline) (map list->pt (ptlist fun range))))) ; without rescaling
    ;; read file
    (append `(spline) (map list->pt (rescalePairs (ptlist fun range) auxs)))))	        ; with rescaling

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

(define (lineGraphics fun range auxs)
  `(with "color" "blue" "line-width" "1.5ln" ,(lineFun fun range auxs)))

(define (lineGraphicsAll graphsList auxs)
  (map (lambda (x)
	 (let ((fun (cdr (assoc "function" x)))
	       (range (cdr (assoc "range" x))))
	   (lineGraphics fun range auxs)))
       graphsList))

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


(define (functionsGraphics graphsList auxs)
  (let ((fun (cdr (assoc "function" (car graphsList))))
	(range (cdr (assoc "range" (car graphsList)))))
    (appendMult
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
    ;; see
	   ;;(graphsList (list
	   ;;		`(("function" . ,(lambda (x) ( - (expt x 2) 2.)))
	   ;;		  ("range" . ,(list -2. 2.)))))
	   (fun (cdr (assoc "function" (car graphsList)))) ; take just the first element at the moment, after the tests I wish to be able to plot several functions
	   (range (cdr (assoc "range" (car graphsList))))
	   ;; (fVals (funValues fun range)) ; function values
	   ;; (fVals (funValuesAll graphsList)) ; function values
	   ;;(rangeX range)
	   (rangeX (findRangeXAll graphsList))
	   ;;(rangeY  `(,(apply min fVals) ,(apply max fVals)))
	   (rangeY (findRangeYAll graphsList))
	   (auxs `(("rangeX" . ,rangeX)
		   ("rangeY" . ,rangeY)))) ; function values (do I need it? 2020-05-13: no)
      (begin
	;; (display "\n testing graphics list \n")
	;; (display "\n x- ticks \n")
	;; (display  (ticksXGraphics funS rangeS))
	;; (display "\n y-ticks \n")
	;; (display  (ticksYGraphics funS rangeS))
	(appendMult ; have to use appendMult because of the own definition of append (is an own def. of append necessary?)
	 (list
	  ;; `(graphics
	  ;;   (with "color" "blue" "line-width" "1.5ln" ,(lineFun fun range auxs))
	  ;;   (with "color" "black" "line-width" "0.75ln" ,(axX auxs))
	  ;;   (with "color" "black" "line-width" "0.75ln" ,(axY auxs))
	  ;;   (with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
	  ;;   (with "color" "black" "line-width" "0.75ln" ,(axYRight auxs)))
	  (functionsGraphics graphsList auxs)
	  (ticksXGraphics auxs)
	  (ticksYGraphics auxs)
	  (numbersXGraphics auxs)
	  (numbersYGraphics auxs))))))
;;;

(tm-define (plotFun definitionFile)
	   (let* ((fileS (tree->stree definitionFile))) ; from TeXmacs tree to scheme-tree
	     (stree->tree
	      `(with "gr-geometry" (tuple "geometry" "9cm" "6cm" "center")
		     ,(compose-graphics fileS)))))
