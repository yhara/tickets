;;
;; ticket.scm
;;

(define (ticket-create)
  (let1 result (read-from-string (http-request "tickets/create"))
    (if (eq? (car result) 'id)
      (ticket-new! (cdr result) "" (/ *width* 2) (/ *height* 2))
      (show-error "error: failed to create new ticket"))))

(define (ticket-move id x y)
  (let1 result (http-post "tickets/move/"
                          `(("id" . ,id) ("x" . ,x) ("y" . ,y)))
    (when (not (string=? result "#t"))
      (show-error "error: failed to save ticket position"))))

(define (ticket-moved ticket-div)
  (call-with-values 
    (lambda () (get-position ticket-div))
    (lambda (x y) 
      (ticket-move (js-ref ticket-div "ticket-id") (- x (/ *width* 2)) (- y (/ *height* 2))))))

; the ticket-div currently shown
(define *current-ticket* #f)

; show infomation of a ticket
(define (show-ticket ticket-div)
  (set! *current-ticket* ticket-div)
  (let1 title (get-content ticket-div)
    (set-content! ($ "hand_title") 
                  (if (string=? title "") "(no title)" title)))
  (set-content! ($ "hand_desc")
                (string-append "(" 
                               (get-style ticket-div "left")
                               ","
                               (get-style ticket-div "top")
                               ")")))

(define (on-ticket-click ticket-div)
  (element-hide! ($ "hand_title_submit"))
  (show-ticket ticket-div))

(define (ticket-new! id name x y)
  (let1 ticket-div (element-new `("div.ticket" ,name))
    (js-set! ticket-div "ticket-id" id)
    (add-handler! ticket-div "click"
                  (lambda (ev) (on-ticket-click (js-ref ev "target"))))
    (element-insert! ($ "field") ticket-div)
    (js-new "Draggable" ticket-div
            (js-obj "onEnd" 
                    (js-closure 
                      (lambda (drg) (ticket-moved (js-ref drg "element"))))))
    (set-position! ticket-div (+ (/ *width* 2) x) (+ (/ *height* 2) y))
    ticket-div))

; rename ticket and submit to server
(define (ticket-rename new-title)
  (element-update! ($ "hand_title") new-title)
  (element-update! *current-ticket* new-title)
  (let* ((id (js-ref *current-ticket* "ticket-id"))
         (result (http-post "tickets/rename"
                            `(("id" . ,id) ("title" . ,new-title)))))
    (when (not (string=? result "#t"))
      (show-error "error: failed to save new ticket title"))))

; show rename form and call ticket-rename when submitted
(define (on-ticket-rename)
  (define (rename-form old)
    (string-append "<input type='text' value='" old "' id='rename_text'>"))
  (let1 ok-button ($ "hand_title_submit")
    (unless (element-visible? ok-button)
      (element-show! ok-button)
      (element-update! ($ "hand_title") 
                       (rename-form (get-content ($ "hand_title"))))
      (wait-for ok-button "click")
      (ticket-rename (get-content ($ "rename_text")))
      (element-hide! ok-button))))

; send server to delete info and clear the hand
(define (ticket-delete id)
  (let1 result (http-post "tickets/delete"
                          `(("id" . ,id)))
    (if (string=? result "#t")
      (begin
        (element-remove! *current-ticket*)
        (set! *current-ticket* #f)
        (element-clear! ($ "hand_title"))
        (element-clear! ($ "hand_desc")))
      (show-error "error: failed to save ticket position"))))

; ask really delete the ticket
(define (on-ticket-delete)
  (when *current-ticket*
    (let1 message (string-append "really delete '"
                                 (get-content *current-ticket*)
                                 "' ?")
      (when (confirm message)
        (ticket-delete (js-ref *current-ticket* "ticket-id"))))))
