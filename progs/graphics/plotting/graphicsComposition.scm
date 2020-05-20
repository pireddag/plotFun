(texmacs-module (graphics plotting graphicsComposition)
		(:use (graphics plotting defineFunctions)
;;		      (graphics plotting setPoints)
		      (graphics plotting setTicks)
		      (graphics plotting setColors)
		      (graphics plotting setNumbers)))


;; A function for the rescaled points
(define (lineFun fun range auxs)
    ;; (display "\n")
    ;; (display range)
    ;; (display "\n")
    ;;(display  (append `(line) (map list->pt (ptlist fun))))
    ;; (append `(spline) (map list->pt (ptlist fun range)))) ; without rescaling
    ;; read file
    (append `(spline) (map list->pt (rescalePairs (ptlist fun range) auxs))))        ; with rescaling

;;;

(tm-define (ticksXGraphics auxs)
  (let ((ticksGraphicsFun
	 (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksXLines auxs))))

(tm-define (ticksYGraphics auxs)
  (let ((ticksGraphicsFun
	 (lambda (x) `(with  "color" "black" "line-width" "0.75ln" ,x))))
    (map ticksGraphicsFun (ticksYLines auxs))))

(tm-define (numbersXGraphics auxs)
  (let ((numbersGraphicsFun (lambda (x) `(with  "color" "black" ,x))))
    (map numbersGraphicsFun (numbersXPoints auxs))))

(tm-define (numbersYGraphics auxs)
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

(tm-define (functionsGraphics graphsList auxs)
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
