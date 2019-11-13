;; next: put one tick at or before the lower limit and one at or after the upper limit of the range
;; function to modify is ticksList
;; calculate ticks

;; define ticks
(define tickSpacings '(1. 2. 5.))

;(define nTicksOpt 6)
(define nTicksOk '(3 4 5 6 7 8))

(define (nTicks range spacing)
   (inexact->exact (floor (/ (width range) spacing)))) 
 ;; (floor->exact (/ (width range) spacing))) ; need always an exact result
;; floor->exact is not recognized by Guile, so I have to use exact->inexact and floor separately

(define (log10 x) (/ (log x) (log 10)))

(define (positionUp position)
  (modulo (+ position 1) 3))

(define (positionDown position)
  (modulo (- position 1) 3))

(define (tickSpacingsUp position)
  (if (= 1  (list-ref tickSpacings (positionUp position))) 10
      (list-ref tickSpacings (positionUp position)))) ; consider 10 if I get 1

(define (tickSpacingsThis position)
  (if (= 1  (list-ref tickSpacings position)) 10   (list-ref tickSpacings position))) ; consider 10 if I get 1


(define (adjustSpacingUp spacing position)
  (* (/ spacing (list-ref tickSpacings position)) (tickSpacingsUp position)))

(define (adjustSpacingDown spacing position)
  (* (/ spacing (tickSpacingsThis position)) (list-ref tickSpacings (positionDown position))))

; if ticks are 3 or 9 we should try to improve the spacing 
(define (tryTickSpacing range spacing position)
  (case (nTicks range spacing)
    ((3 4 5 6 7 8) spacing) ; do not quote the list in the case costruct; this function takes for granted the the number of ticks in an integer
    (else (cond ((< (nTicks range spacing) 3) (begin
						;; (display "\nspacing\n")
						;; (display spacing)
						;; (display "\nposition\n")
						;; (display position)
						;; (display "\n")
						;; (display "#ticks\n")
						;; (display (nTicks range spacing))
						;; (display "\n")
						;; (display "adjusting down\n")
						(tryTickSpacing range (adjustSpacingDown spacing position) (positionDown position))))
		((> (nTicks range spacing) 8) (begin
					        ;; (display "\nspacing\n")
						;; (display spacing)
					        ;; (display "\nposition\n")
						;; (display position)
						;; (display "\n")
						;; (display "#ticks\n")
						;; (display (nTicks range spacing))
						;; (display "\n")
						;; (display "adjusting up\n")
						(tryTickSpacing range (adjustSpacingUp spacing position) (positionUp position))))))))

;; (define (tryTickSpacingTest range spacing position)
;;   (case (nTicks range spacing)
;;     ((5 6 7 8) spacing); no quoting! ; takes for granted the the number of ticks in an integer
;;     (else 0)))
		   
(define (findTickSpacing range)
  (let ((spacing (expt 10 (floor (log10 (width range)))))
	(position 0))
    (tryTickSpacing range spacing position)))

;; I use this function to round to a non-integer so to get the initial tick given the spacing
;; (I do the rounding using "spacing" as a unit)
(define (scaleRangeStart range spacing)
  (/ (car range) spacing))

(define (firstTick range spacing)
  (* (round (scaleRangeStart range spacing)) spacing))

;; this is similar to ptsList but can choose the start point; perhaps it is possible to rewrite ptList more in general
(define (ticksList range spacing start) ; takes for granted that start is equal to or larger than (car range)
  (cond ((> start (+ (cadr range) (* 0.1 (width range)))) '()) ; allow for a bit of approximation on the last tick (should be done for the y-ticks only?)
	(else (cons start (ticksList range spacing (+ start spacing))))))


;; Add elements to list so that it always includes the interval defined by "range"
;; get last element of list:
;; https://stackoverflow.com/questions/13175152/scheme-getting-last-element-in-list
(define (lastElem list) (begin
			  ;; (display list)
			  (car (reverse list))))
;; need to define lastElem in a file apart

(define (padTicksListFront range spacing tList)
  (if ( < (car range) (car tList))
      (append `(,(- (car tList) spacing)) tList) tList) ) ; I am turning the element into a list for appending

(define (padTicksListBack range spacing tList)
  (if ( > (cadr range) (lastElem tList))
      (append  tList `(,(+ (lastElem tList) spacing))) tList))  ; I am turning the element into a list for appending
  
;; ;; In the padding subtle errors could occur when the list is "short" with respect to the range
;; ;; but I did not yet analyze all of this.
;; (define (calcTicks range spacing)
;;   (let ((tick1 (firstTick range spacing)))
;;     (begin
;;       ;(display (ticksList range spacing tick1))
;;       ;(display (padTicksListFront range spacing (ticksList range spacing tick1)))
;;       (padTicksListBack range spacing (padTicksListFront range spacing (ticksList range spacing tick1))))))

;; Do not apply the padding functionf or the moment
(define (calcTicks range spacing)
  (let ((tick1 (firstTick range spacing)))
    (begin
      ;(display (ticksList range spacing tick1))
      ;(display (padTicksListFront range spacing (ticksList range spacing tick1)))
      (ticksList range spacing tick1))))


(define (setTicks range)
  (let ((tickSpacing (findTickSpacing range)))
    (calcTicks range tickSpacing)))

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


