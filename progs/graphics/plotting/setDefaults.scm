(texmacs-module (graphics plotting setDefaults))

;;; Set defaults for the program

(tm-define defaultOptions
  '(
    ("sizeX" . 9)
    ("sizeY" . 6)
    ("nPoints" . 51)
    ("line-width" . "1.5ln")
    ("dash-style" . "1")))

(tm-define (getOption option userOptions defaultOptions)
  (let ((optUser (assoc-ref userOptions option))
	(optDefault (assoc-ref defaultOptions option)))
    ;; (display "\n")
    ;; (display userOptions)
    ;; (display "\n")
    ;; (display defaultOptions)
    ;; (display "\n")
    ;; (display optUser)
    ;; (display "\n")
    ;; (display optDefault)
    ;; (display "\n")
    (if (not optUser) optDefault optUser))) ; if the option is not present in the association list assoc-ref returns false: then we use the default option

