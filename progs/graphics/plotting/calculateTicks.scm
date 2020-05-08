;; next: put one tick at or before the lower limit and one at or after the upper limit of the range
;; function to modify is ticksList

;;; definitions

;; define ticks
(define tickSpacings '(1. 2. 5.))

;(define nTicksOpt 6) ; not used at the moment - as soon as the number of ticks is good enough I accept it
(define nTicksOk '(3 4 5 6 7 8)) ; also not used - the case construct takes an unquoted list as condition

;;; Functions to calculate the ticks

(define (setTicks range)
  (let ((tickSpacing (findTickSpacing range)))
    (calcTicks range tickSpacing)))

;; Calculate the list of ticks given the range and the spacing
;; Do not apply the padding function for the moment
(define (calcTicks range spacing)
  (let ((tick1 (firstTick range spacing)))
    (begin
      (ticksList range spacing tick1))))

;; Calculate the list of ticks given the range, the spacing and the starting point
;; this is similar to ptsList but can choose the start point; perhaps it is possible to rewrite ptList more in general
(define (ticksList range spacing start) ; takes for granted that start is equal to or larger than (car range)
  (cond ((> start (+ (cadr range) (* 0.1 (width range)))) '()) ; allow for a bit of approximation on the last tick (should be done for the y-ticks only?)
	(else (cons start (ticksList range spacing (+ start spacing))))))

;; I use this function to round to a non-integer so to get the initial tick given the spacing
;; (I do the rounding using "spacing" as a unit)
(define (scaleRangeStart range spacing)
  (/ (car range) spacing))

;; Calculate the first tick using the rounding to "spacing" units defined with the help of scaleRangeStart
(define (firstTick range spacing)
  (* (round (scaleRangeStart range spacing)) spacing))


;;; Functions to try a given spacing and change it after having seen how many ticks are generated

(define (nTicks range spacing)
   (inexact->exact (floor (/ (width range) spacing)))) 
 ;; (floor->exact (/ (width range) spacing))) ; need always an exact result
;; floor->exact is not recognized by Guile, so I have to use exact->inexact and floor separately

; if ticks are 2 or 9 we should try to improve the spacing 
(define (tryTickSpacing range spacing position)
  (case (nTicks range spacing)
    ((3 4 5 6 7 8) spacing) ; do not quote the list in the case costruct; this function takes for granted the the number of ticks in an integer
    (else (cond ((< (nTicks range spacing) 3) (begin
						(tryTickSpacing range (adjustSpacingDown spacing position) (positionDown position))))
		((> (nTicks range spacing) 8) (begin
						(tryTickSpacing range (adjustSpacingUp spacing position) (positionUp position))))))))
		   
(define (findTickSpacing range)
  (let ((spacing (expt 10 (floor (log10 (width range)))))
	(position 0))
    (tryTickSpacing range spacing position)))



;;; Functions that select an element of tickSpacings

(define (positionUp position)
  (modulo (+ position 1) 3))

(define (positionDown position)
  (modulo (- position 1) 3))

(define (tickSpacingsUp position)
  (if (= 1  (list-ref tickSpacings (positionUp position))) 10
      (list-ref tickSpacings (positionUp position)))) ; consider 10 if I get 1

(define (tickSpacingsThis position)
  (if (= 1  (list-ref tickSpacings position)) 10   (list-ref tickSpacings position))) ; consider 10 if I get 1

;;; Functions that adjust the spacing (depending on the current spacing and on the test on the number of ticks)

(define (adjustSpacingUp spacing position)
  (* (/ spacing (list-ref tickSpacings position)) (tickSpacingsUp position)))

(define (adjustSpacingDown spacing position)
  (* (/ spacing (tickSpacingsThis position)) (list-ref tickSpacings (positionDown position))))











;;; Functions for padding the list of ticks - not used at the moment

;; ;; Add elements to list so that it always includes the interval defined by "range"
;; ;; get last element of list:
;; ;; https://stackoverflow.com/questions/13175152/scheme-getting-last-element-in-list
;; (define (lastElem list) (begin
;; 			  ;; (display list)
;; 			  (car (reverse list))))
;; ;; need to define lastElem in a file apart

;; (define (padTicksListFront range spacing tList)
;;   (if ( < (car range) (car tList))
;;       (append `(,(- (car tList) spacing)) tList) tList) ) ; I am turning the element into a list for appending

;; (define (padTicksListBack range spacing tList)
;;   (if ( > (cadr range) (lastElem tList))
;;       (append  tList `(,(+ (lastElem tList) spacing))) tList))  ; I am turning the element into a list for appending
  
;; ;; ;; In the padding subtle errors could occur when the list is "short" with respect to the range
;; ;; ;; but I did not yet analyze all of this.




;;; Test

;; (tryTickSpacing '(10 30) 10 0)
;; (tryTickSpacing '(10 30) 5 2)
;; (tryTickSpacing '(10 30) 2 1)

;; (findTickSpacing '(10 30))
;; (findTickSpacing '(11 30))
;; (findTickSpacing '(-5 30))
;; (findTickSpacing '(-7 30))
;; (findTickSpacing '(-10 30))
;; (findTickSpacing '(-20 30))
;; (findTickSpacing '(-30 30))
;; (findTickSpacing '(-40 30))
;; (findTickSpacing '(-50 30))
;; (findTickSpacing '(-60 30))

;; (ticksList '(10 30) 2.5 11)

;; (calcTicks '(10 30) 2.5)

;; (setTicks '(10 30))
;; (setTicks '(11 30))
;; (setTicks '(12 30))
;; (setTicks '(13 30))
;; (setTicks '(14 30))
;; (setTicks '(14 20))
;; (setTicks '(14 23))
;; (setTicks '(14.5 31))

;; ;; (tryTickSpacingTest '(10 30) 4 1)

;; (nTicks '(10 30) 2)
;; (nTicks '(10 30) 4)


;; (tickSpacingsUp 0)
;; (tickSpacingsUp 1)
;; (tickSpacingsUp 2)
;; (tickSpacingsThis 0)
;; (tickSpacingsThis 1)
;; (tickSpacingsThis 2)

;; (positionDown 0)
;; (positionDown 1)
;; (positionDown 2)
;; (positionUp 0)
;; (positionUp 1)
;; (positionUp 2)

;; (adjustSpacingUp 1 0)
;; (adjustSpacingUp 2 1)
;; (adjustSpacingUp 5 2)

;; (adjustSpacingDown 1 0)
;; (adjustSpacingDown 2 1)
;; (adjustSpacingDown 5 2)


