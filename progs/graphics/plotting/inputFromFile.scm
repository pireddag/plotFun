(texmacs-module  (graphics plotting inputFromFile))

(define (addToStringRec dataPort str)
  (let ((lineIn (read-line dataPort)))
	(if (eof-object? lineIn)
	    str
	    (begin
	      ; (bkpt lines "test") ; breakpoint: http://www.cs.toronto.edu/~sheila/324/w07/assns/A3/debug.pdf
	      (addToStringRec dataPort (string-append str lineIn))
	      ))))

;; start the recursive function addToStringRec with the empty string
(tm-define (readFile dataPort)
  (addToStringRec dataPort ""))
