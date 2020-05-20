(texmacs-module (graphics plotting plotFun)
		(:use (graphics plotting safeModule)
		      (graphics plotting defineFunctions)
		      (graphics plotting graphicsComposition)
		      (graphics plotting setPoints)
		      (graphics plotting graphicsDefinitions)
		      (graphics plotting setTicks)
		      (graphics plotting inputFromFile)
		      (graphics plotting setAxes)
		      (graphics plotting listOperations)
		      (graphics plotting setColors)
		      (graphics plotting setNumbers)
		      (graphics plotting setLabels)))


;; moved to module defineFunctions
;; ;; https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
;; (define (string->read text) ;renamed from read-string to avoid conflict with read-string of standard guile
;;   (read
;;    (open-input-string text)))

(define diag '()) ;; diagnostics



;; A function that plots functions

;; ;;; Function for input conversion
;; ;; converts string into two numbers
;; ;; note that the syntax of the string that represents the two numbers is strict at the moment
;; ;; (there cannot be any space)
;; (define (rangeString->list rangeString)
;;     ;; (display "\n")
;;     ;; (display "range conversion")
;;     ;; (display "\n")
;;     ;; (display  (string-split rangeString #\,))
;;     (map string->number (string-split rangeString #\,))) ; split at commas https://www.gnu.org/software/guile/docs/docs-1.6/guile-ref/List-String-Conversion.html#List%2fString%20Conversion



;;; https://stackoverflow.com/questions/8387583/writing-flatten-method-in-scheme
;; https://stackoverflow.com/a/8387641
;; 2020-05-19 written here to test whether it is possible to substitute it in for appendMult - not possible
;; (define (flatten x)
;;   (cond ((null? x) '())
;;         ((pair? x) (append (flatten (car x)) (flatten (cdr x))))
;;         (else (list x))))


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
	 (plotsList (assoc-ref graphsList "plotsList"))
	 ;; do not need to quote (string->read graphsListStr) as it is a symbol
	 ;; Example: 
	 ;;(graphsList (list
	 ;;		`(("function" . ,(lambda (x) ( - (expt x 2) 2.)))
	 ;;		  ("range" . ,(list -2. 2.)))))
	 (rangeX (findRangeXAll plotsList))
	 (rangeY (findRangeYAll plotsList))
	 (xLab (assoc-ref graphsList "xLabel"))
	 (auxs `(("xLabel" . ,xLab)
		 ("rangeX" . ,rangeX)
		 ("rangeY" . ,rangeY)))) ; function values (do I need it? 2020-05-13: no)
    ;; (display "\n testing graphics list \n")
    ;; (display "\n x- ticks \n")
    ;; (display  (ticksXGraphics funS rangeS))
    ;; (display "\n y-ticks \n")
    ;; (display  (ticksYGraphics funS rangeS))
    (appendMult ; have to use appendMult because of the own definition of append (is an own def. of append necessary?)
     (list
      (functionsGraphics plotsList auxs)
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
