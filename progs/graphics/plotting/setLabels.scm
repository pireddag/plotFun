;; Two functions for the pairs of points that mark the start and end of each tick

(texmacs-module  (graphics plotting setLabels)
		 (:use (graphics plotting graphicsDefinitions)
		       (graphics plotting setAxes)))


;; Need to write the placement functions (numbers and label) in a better fashion
;; They need to be consistent with each other and give good placement for every ax size

(define (xLabelPos auxs)
  (let* ((axLX (axLimsX auxs))
	 (axLY (axLimsY auxs))
	 (xMin (apply min axLX))
	 (xMax (apply max axLX))
	 (yMin (apply min axLY))
	 (xLabPos     (rescalePairs `((,(/ (+ xMin xMax) 2)
		     ,(- yMin (/ (width axLY) 6.8))))
		  auxs)))
	 ;; rescalePairs gives a list, as output of this function I want the only element of this list
	 (car xLabPos)))

(tm-define (xLabel auxs)
	   ;; (display "calculating x label\n")
	   ;; (display (xLabelPos auxs))
	   ;; (display "\n")
	   ;; Starting with `(with "color" "black"
	   ;; is essential to get the  'with  "text-at-halign" "center" to be active
	   (let ((xLab (assoc-ref auxs "xLabel")))
 `(with "color" "black" ,(list 'with  "text-at-halign" "center"
			  (list 'text-at xLab
				(list->pt (xLabelPos auxs)))))))
