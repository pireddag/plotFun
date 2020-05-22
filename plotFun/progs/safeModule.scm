(texmacs-module (safeModule)
		(:use (defineFunctions)))


(tm-define graphsListStr  (:secure) '());; initialize to empty string in order to be able to place the symbol in the "safe" module we are going to set up
;; it is then possible to set it to something else (we will set it to the association list in string form) before calling eval onto it

(tm-define (make-pure-math-module)
	   	   (:secure)
  (let ((m (make-module)))
    (begin
      ;; math symbols
      (module-define! m '* *)
      (module-define! m '- -)
      (module-define! m '+ +)
      (module-define! m '/ /)
      (module-define! m 'abs abs)
      (module-define! m 'max max)
      (module-define! m 'min min)
      (module-define! m 'truncate truncate)
      (module-define! m 'round round)
      (module-define! m 'floor floor)
      (module-define! m 'ceiling ceiling)
      ;; a few of the list of Guile 3 are still missing, but I have to check if they are present in Guile 1.8
      (module-define! m 'sqrt sqrt)
      (module-define! m 'expt expt)
      (module-define! m 'sin sin)
      (module-define! m 'cos cos)
      (module-define! m 'tan tan)
      (module-define! m 'asin asin)
      (module-define! m 'acos acos)
      (module-define! m 'atan atan)
      (module-define! m 'exp exp)
      (module-define! m 'log log)
      (module-define! m 'log10 log10)
      (module-define! m 'sinh sinh)
      (module-define! m 'cosh cosh)
      (module-define! m 'tanh tanh)
      (module-define! m 'asinh asinh)
      (module-define! m 'acosh acosh)
      (module-define! m 'atanh atanh)
      ;; other symbols
      (module-define! m 'lambda lambda)
      (module-define! m 'list list)
      (module-define! m 'quote quote)
      (module-define! m 'quasiquote quasiquote)
      (module-define! m 'string->read string->read)
      ;; symbol where the user-defined information will be contained
      (module-define! m 'graphsListStr graphsListStr))
    m))
