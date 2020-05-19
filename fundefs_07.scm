`(
  ("xLabel" . "x-axis lab - combined plot")
  ("plotsList" . (
		  (("function" . ,(lambda (x) ( - (expt x 2) 2.)))
		   ("range" . ,(list -2. 2.)))
		  (("function" . ,(lambda (x) ( - 2. (expt x 2) )))
		   ("range" . ,(list -1. 1.)))
		  (("function" . ,(lambda (x) (/ 3. (+ 1 (expt (* x 5) 2)))))
		   ("range" . ,(list -2. 2.)))
		  (("function" . ,(lambda (x) (sin (* 5 x))))
		   ("range" . ,(list -3.14 3.14)))
		  )))
