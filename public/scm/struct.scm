;; simple struct with js-obj

(define-macro (define-struct name . props)
  `(
  1)

; example:
;   (define-struct point x y)
;
;   (make-point x y)
;     == (js-obj "x" x "y" y)
;   (x-of pt)
;     == (js-ref pt "x")
;   (y-of pt)
;     == (js-ref pt "y")
;   (set-x! pt x)
;     == (js-set! pt "x" x)
;   (set-y! pt y)
;     == (js-set! pt "y" y)
