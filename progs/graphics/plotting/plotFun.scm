(texmacs-module (graphics plotting_working_02 plotFun))

(load "graphicsDefinitions.scm")
(load "setPoints.scm")
(load "listOperations.scm")
(load "defineFunctions.scm")
(load "rescaleFunctions.scm")
(load "setAxes.scm")
(load "calculateTicks.scm")
(load "setTicks.scm")
(load "setNumbers.scm")

;; (define (ticksXGraphics funS rangeS)
;;   (let ((ticksGraphicsFun (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
;;     (map ticksGraphicsFun (ticksXLines funS rangeS))))

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

;; overall graphics function

(define (compose-graphics fileS)
  (begin
    (load fileS)
    (let* ((fun (cdr (assoc "function" (car graphsList))))
	   (range (cdr (assoc "range" (car graphsList))))
	   (fVals (funValues fun range)) ; function values
	   (rangeX range)
	   (rangeY  `(,(apply min fVals) ,(apply max fVals)))
	   (auxs `(("rangeX" . ,rangeX)
		   ("rangeY" . ,rangeY)
		   ("fVals"  . ,fVals)))) ;function values (do I need it?)
      (begin
	;; (display "\n testing graphics list \n")
	;; (display "\n x- ticks \n")
	;; (display  (ticksXGraphics funS rangeS))
	;; (display "\n y-ticks \n")
	;; (display  (ticksYGraphics funS rangeS))
	(appendMult ; have to use appendMult because of the own definition of append (is an own def. of append necessary?)
	 (list
	  `(graphics
	    (with "color" "blue" "line-width" "1.5ln" ,(lineFun fun range auxs))
	    (with "color" "black" "line-width" "0.75ln" ,(axX auxs))
	    (with "color" "black" "line-width" "0.75ln" ,(axY auxs))
	    (with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
	    (with "color" "black" "line-width" "0.75ln" ,(axYRight auxs)))
	  (ticksXGraphics auxs)
	  (ticksYGraphics auxs)
	  (numbersXGraphics auxs)
	  (numbersYGraphics auxs)))))))

;;;

(tm-define (plotFun definitionFile)
	   (let* ((fileS (tree->stree definitionFile))) ; from TeXmacs tree to scheme-tree
	     (stree->tree
	      `(with "gr-geometry" (tuple "geometry" "9cm" "6cm" "center")
		     ,(compose-graphics fileS)))))
