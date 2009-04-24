;;
;; test.scm
;;

; "raise" function; should be implemented by BiwaScheme side, in the future.
(define *escape* (call/cc (lambda (x) x)))
(define (raise msg)
  (print "ERROR: " msg)
  (*escape*))

;;; sspec

; (expect expr) -> checks result is a true value
; (expect expr is value) -> checks (eq? result value)
(define-macro (expect . args)
  (case (length args)
    ((1)
     `(sspec-check ,(car args) "result is false" ',args))
    ((3)
     (when (not (eq? (cadr args) 'is))
       (raise "expect: bad args"))
     `(let ((__given__    ,(car args))
            (__expected__ ,(caddr args)))
        (sspec-check2 __given__ __expected__ ',args)))
    (else
      (raise "expect: bad args"))))

(define (sspec-check result message-gen args)
  (if result
    (print "ok : " (write-to-string args))
    (print "ng[" (message-gen) "] : " (write-to-string args))))

(define (sspec-check2 given expected args)
  (sspec-check (eq? given expected)
               (lambda ()
                 (string-append "expected "
                                (write-to-string expected)
                                " but got "
                                (write-to-string given)))
               args))


;;; test body

(expect (= 1 1))
(define x 1)
(expect x is 2)
