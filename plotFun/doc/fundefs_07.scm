`(
  ("xLabel" . "x-axis lab - combined plot")
  ("title" . "Combined plot")
  ("plotsList" . (
		  (("function" . ,(lambda (x) ( - (expt x 2) 2.)))
		   ("range" . ,(list -2. 2.)))
		  (("function" . ,(lambda (x) ( - 2. (expt x 2) )))
		   ("range" . ,(list -1. 1.)))
		  (("function" . ,(lambda (x) (* 3. (exp (* -8 (expt x 2))))))
		   ("range" . ,(list -2. 2.)))
		  (("function" . ,(lambda (x) (sin (* 5 x))))
		   ("range" . ,(list -3.14 3.14)))
		  )))
