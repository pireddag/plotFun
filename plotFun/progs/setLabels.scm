;; Two functions for the pairs of points that mark the start and end of each tick

(texmacs-module  (setLabels)
		 (:use (graphicsDefinitions)
		       (setAxes)
		       (rescaleFunctions)))


;; Need to write the placement functions (numbers and label) in a better fashion
;; They need to be consistent with each other and give good placement for every ax size


(tm-define (xLabel auxs)
	   	   (:secure)
	   ;; (display "calculating x label\n")
	   ;; (display (xLabelPos auxs))
	   ;; (display "\n")
	   ;; Starting with `(with "color" "black"
	   ;; is essential to get the  'with  "text-at-halign" "center" to be active
		   (let* ((xLabAux (assoc-ref auxs "xLabel"))
			  (xLab (if (not xLabAux) "" xLabAux))) ; if there is no "xLabel" in the association list of the input file, xLabAux is set to false (when composing auxs), and we set xLab to the empty string
 `(with "color" "black" ,(list 'with  "text-at-halign" "center"
			  (list 'text-at xLab
				(list->pt (xLabelPos auxs)))))))

;; Test to check the position and alignment of the y-label before rotation
;; (tm-define (yLabelXDir auxs)
;; 	   	   (:secure)
;; 	   ;; (display "calculating x label\n")
;; 	   ;; (display (xLabelPos auxs))
;; 	   ;; (display "\n")
;; 	   ;; Starting with `(with "color" "black"
;; 	   ;; is essential to get the  'with  "text-at-halign" "center" to be active
;; 	   (let ((yLab (assoc-ref auxs "yLabel")))
;;  `(with "color" "black" ,(list 'with  "text-at-halign" "center"
;; 			  (list 'text-at yLab
;; 				(list->pt (yLabelPos auxs)))))))

(tm-define (yLabel auxs)
	   	   (:secure)
	   ;; (display "calculating x label\n")
	   ;; (display (xLabelPos auxs))
	   ;; (display "\n")
	   ;; Starting with `(with "color" "black"
	   ;; is essential to get the  'with  "text-at-halign" "center" to be active
		   (let* ((yLabAux (assoc-ref auxs "yLabel"))
			 (yLab (if (not yLabAux) "" yLabAux)))  ; if there is no "yLabel" in the association list of the input file, yLabAux is set to false (when composing auxs), and we set yLab to the empty string
	     `(with "color" "black" ,(list 'with  "text-at-valign" "center" ; I do not understand why I need to use "text-at-valign" for the rotated label, nor around which point the rotation happens.
					   ;; Checked with the editor: aligning is made with respect to a box which retains its horizontal and vertical axes
			  (list 'text-at (list 'rotate "90" yLab)
				(list->pt (yLabelPos auxs)))))))


(tm-define (title auxs)
	   	   (:secure)
	   ;; (display "calculating title position \n")
	   ;; (display (titlePos auxs))
	   ;; (display "\n")
	   ;; Starting with `(with "color" "black"
	   ;; is essential to get the  'with  "text-at-halign" "center" to be active
		   (let* ((tlAux (assoc-ref auxs "title"))
			 (tl (if (not tlAux) "" tlAux)))  ; if there is no "title" in the association list of the input file, tlAux is set to false (when composing auxs), and we set tl to the empty string
 `(with "color" "black" ,(list 'with  "text-at-halign" "center"
			  (list 'text-at tl
				(list->pt (titlePos auxs)))))))


(define (xLabelPos auxs)
  (let* ((axLX (axLimsX auxs))
	 (axLY (axLimsY auxs))
	 (xMin (apply min axLX))
	 (xMax (apply max axLX))
	 (yMin (apply min axLY))
	 (xLabPos     (rescalePairs `((,(/ (+ xMin xMax) 2)
				       ,(- yMin (/ (width axLY) 6.8))))
				    auxs))) ; rescalePairs gives a list, as output of this function I want the only element of this list
    (car xLabPos)))

(define (yLabelPos auxs)
  (let* ((axLX (axLimsX auxs))
	 (axLY (axLimsY auxs))
	 (xMin (apply min axLX))
	 (yMin (apply min axLY))
	 (yMax (apply max axLY))
	 (yLabPos     (rescalePairs `( (,(- xMin (yLabCorrect axLX))
				      ,(/ (+ yMin yMax) 2)))
				    auxs))  ; more far away than the x-label
	 (xAxPos (rescalePairs `((,xMin 0)) auxs))) ; need the x-component of the scaled position of the x-axis for adjusting the label with limits - get it with the action of rescalePairs on the "artificial" position (xMin 0) which has the correct x-value 
    ;; rescalePairs gives a list, as output of this function I want the only element of this list
    ;; pass it to a function which will limit it (so that the label is neither too close to the axis for small plots nor too far away for large plots)
    (yLabLimit (car yLabPos) (car xAxPos))))

;; Formula takes into account:
;; a constant distance
;; the size of the x-axis
;; the correction so that it stays within limits is done with the function yLabLimit which is applied to the scaled values of the y-label position at the end
(define (yLabCorrect axLX)
 (+ (/ (width axLX) 12) .5))

;; Adjust so that the label is neither too close to the axis for small plots nor too far away for large plots
;; yLabPos and xAxPos are lists of two numbers, we want to adjust only the first element (x-component of the position)
;; 
(define (yLabLimit yLabPos xAxPos)
  (let* ((correctMax 1.25)
	 (correctMin 0.7)
	 (currentShift (- (car xAxPos) (car yLabPos) )) ; positive value
	 (limitedShift  (min correctMax (max correctMin currentShift)))
	 (yLabXPos (- (car xAxPos) limitedShift)))
    ;; (display "\n")
    ;; (display "xAxPos\n")
    ;; (display (car xAxPos))
    ;; (display "\nyLabPos\n")
    ;; (display (car yLabPos))
    ;; (display "\ncurrentShift\n")
    ;; (display currentShift)
    ;; (display "\nlimitedShift\n")
    ;; (display limitedShift)
    ;; compose the y-label position using the "limited" x-position and the y-position which we already had
    `(,yLabXPos ,(cadr yLabPos))))
    

			
  


(define (titlePos auxs)
  (let* ((axLX (axLimsX auxs))
	 (axLY (axLimsY auxs))
	 (xMin (apply min axLX))
	 (xMax (apply max axLX))
	 (yMax (apply max axLY))
	 (tlPos     (rescalePairs `((,(/ (+ xMin xMax) 2)
				     ,(+ yMax (/ (width axLY) 20)))) 
				  auxs)))
    ; closer than the label
    ;; rescalePairs gives a list, as output of this function I want the only element of this list
    (car tlPos)))


