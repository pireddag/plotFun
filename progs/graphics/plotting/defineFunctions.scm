;; ;; https://stackoverflow.com/questions/21176956/how-to-convert-string-to-variable-name-in-scheme
;; ;; https://stackoverflow.com/a/21177216
;; ;; slightly modified
;; (define-syntax string->variable-name
;;     (syntax-rules ()
;;       ((_ str)
;;        (string? (syntax->datum #'str))
;;        (datum->syntax #'str (string->symbol (syntax->datum #'str))))))


;; Converts a string to a procedure and evaluates it in the environment returned by (interaction-environment)

;; https://stackoverflow.com/questions/7170162/converting-a-string-to-a-procedure
(define (read-string text)
  (read
   (open-input-string text)))

;; https://stackoverflow.com/questions/6584818/in-r6rs-scheme-is-there-a-way-to-get-the-current-environment-for-use-with-eval
;; https://stackoverflow.com/a/6585081
(define (call-string text-lambda . args)
  (apply
    (eval (read-string text-lambda)  (interaction-environment)); https://groups.csail.mit.edu/mac/ftpdir/scheme-7.4/doc-html/scheme_14.html (for user-initial-environment)
    args)) ; (interaction-environment) for Guile (https://www.gnu.org/software/guile/manual/html_node/Environments.html#Environments)

(define (pairfun funString x)
  (begin
    ;; (display "\n")
    ;; (display x)
    ;; (display "\n")
    ;; (display fun)
    ;; (display "\n")
    ;; (display `(,fun ,x))
    ;; (display "\n")
    ;; (display (fun x))
    `(,x ,(call-string funString x))))

(define (funValues funString range)
  (map (lambda (x) (call-string funString x)) (pts range)))

;;; List of points for plotting
(define (ptlist funString range)
  (let ((pairfunLocal (lambda (x) (pairfun funString x))))
    (map pairfunLocal (pts range))))
