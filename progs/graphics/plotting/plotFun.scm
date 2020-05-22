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
		      (graphics plotting setLabels)
		      (graphics plotting rescaleFunctions)))

;;the rescaleFunctions module is here only for the defaults of szX and szY
;; the code for the defaults (and the combination of default options with user options) has to be reorganized and placed into a module


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

(define (compose-graphics graphsList) 
  (let* ((plotsList (assoc-ref graphsList "plotsList"))
	 (rangeX (findRangeXAll plotsList))
	 (rangeY (findRangeYAll plotsList))
	 (xLab (assoc-ref graphsList "xLabel"))
	 (szX (assoc-ref graphsList "sizeX"))
	 (szY (assoc-ref graphsList "sizeY"))
	 (auxs `(("xLabel" . ,xLab)
		 ("sizeX" . ,szX)
		 ("sizeY" . ,szY)
		 ("rangeX" . ,rangeX)
		 ("rangeY" . ,rangeY))))
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
  (let* ((fileS (tree->stree definitionFile)) ; from TeXmacs tree to scheme-tree
	 (graphsListStr (call-with-input-file fileS
			  (lambda (dataPort) (readFile dataPort))))
	 ;; safe evaluation within a module that restrict the procedures
	 (graphsList (eval (string->read graphsListStr) (make-pure-math-module)))
	     ;; do not need to quote (string->read graphsListStr) as it is a symbol
	 ;; Example: 
	 ;;(graphsList (list
	 ;;		`(("function" . ,(lambda (x) ( - (expt x 2) 2.)))
	 ;;		  ("range" . ,(list -2. 2.)))))
	 (szXAux (assoc-ref graphsList "sizeX"))
	 (szYAux (assoc-ref graphsList "sizeY"))
	 (szX (if (not szXAux) szXDefault szXAux)) ; szX and szY defaults are in rescaleFunctions - the code for defaults and combination of user options and defaults needs to be rewritten
	 (szY (if (not szYAux) szYDefault szYAux))
	 (szXStr (number->string (* szX 1.1)))
	 (szYStr (number->string (* szY 1.1)))
	 (szXUnitsStr (string-append szXStr "cm"))
	 (szYUnitsStr (string-append szYStr "cm")))
    ;;     (display "\n")
    ;; (display szXAux)
    ;;     (display "\n")
    ;; (display szYAux)
    ;; (display "\n")
    ;; (display szXUnitsStr)
    ;;     (display "\n")
    ;; 	(display szYUnitsStr)
    ;;     (display (equal? szXUnitsStr "7cm"))
    ;; 	(display (equal? szYUnitsStr "5cm"))
    (stree->tree
     `(with "gr-geometry" (tuple "geometry" ,szXUnitsStr ,szYUnitsStr "center")
	    ,(compose-graphics graphsList)))))



