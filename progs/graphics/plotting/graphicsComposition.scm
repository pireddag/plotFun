(texmacs-module (graphics plotting graphicsComposition)
		(:use (graphics plotting defineFunctions)
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


(define (lineGraphics fun range lWidth dStyle color auxs)
  (if (not lWidth)
      (set! lWidth "1.5ln")) ; if line-width is not in the association list lWidth is set to false; we set it then to "1.5ln"
  (if (not dStyle)
      (set! dStyle "11111"))
  `(with
    "color" ,color
    "line-width" ,lWidth
    "dash-style" ,dStyle
    ,(lineFun fun range auxs)))

;; Mapping on several lists is standard in Scheme
;; Note also https://stackoverflow.com/questions/38589238/how-to-use-map-with-a-function-that-needs-more-arguments
(define (lineGraphicsAll plotsList auxs)
  (let ((cList (colorListForThisPlot colorList plotsList)))
    (map (lambda (x y)
	   (let ((fun (assoc-ref x "function")) 
		 (range (assoc-ref x "range"))
		 (lWidth (assoc-ref x "line-width"))
		 (dStyle (assoc-ref x "dash-style"))
		 (colorThis (assoc-ref x "color"))
					; assoc and assoc-ref have opposite order of arguments (assoc: key, alist assoc-ref: alist key
		 )
	     (if (not colorThis)
		 (set! colorThis y))  ; if color is not in the association list colorThis is set to false; we set it then to the color specified by y (which is mapped to the list of colors cList)
	     (lineGraphics fun range lWidth dStyle colorThis auxs)))
	 plotsList cList)))

(tm-define (functionsGraphics plotsList auxs)
    (appendMult ; 2020-05-19 appendMult works on a list of lists, eliminating a set of parentheses, but is not equivalent to flatten as defined in https://stackoverflow.com/a/8387641
     (list
      `(graphics)
      (lineGraphicsAll plotsList auxs)
      `((with "color" "black" "line-width" "0.75ln" ,(axX auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axY auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axXUp auxs))
	(with "color" "black" "line-width" "0.75ln" ,(axYRight auxs))))))


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
