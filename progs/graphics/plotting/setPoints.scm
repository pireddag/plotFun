;; define the list of points
;; https://stackoverflow.com/questions/43011660/constructing-a-list-of-numbers-in-scheme

;; !! the numbers of points to plot can be set with an option


(texmacs-module (setPoints)
		(:use (setDefaults)))

(tm-define (width range) ; takes for granted that the second element of range is larger than the first
	   	   (:secure)
    (- (cadr range) (car range)))

(tm-define (pts range nPoints)
  (let
      ((stp (step range nPoints)))
    (ptsList stp range)))

(define (step range nPoints)
    (/ (width range) nPoints)) ; default is 51 points per graph 

;; I need two procedures for the list of points,
;; one to calculate the margin and one to use it iteratively (as it must be always the same, i.e. it should not depend on range)

(define (ptsListMargin step range margin) ; is iterative and uses margin as an input (does not calculate it)
    (let
      ((start (car range))
       (stop (cadr range))) ; some leeway on the stop (need to define it separately because stop is called iteratively!)
    (cond ((> start (+ stop margin)) '())
	  (else (cons start (ptsListMargin step (list (+ start step) stop) margin))))))
  

(define (ptsList step range) ; calculates margin (on the original range!) then passes it to the iterative function that generates the list
  (let
      ((start (car range))
       (stop (cadr range))
       (margin (* 0.02 (width range)))) ; some leeway on the stop (need to define it separately because stop is called iteratively!)
					; 0.02 is chosen to work well with the 51 points that I chose
    (cond ((> start (+ stop margin)) '())
	  (else (cons start (ptsListMargin step (list (+ start step) stop) margin))))))
