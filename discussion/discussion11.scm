; question 1 
(define (mystery expr old new)
    (mystery-helper expr old new))

(define-macro (mystery-macro expr old new)
    (mystery-helper expr old new))

(define (mystery-helper e o n)
  (if (pair? e)
      (cons (mystery-helper (car e) o n) (mystery-helper (cdr e) o n))
      (if (eq? e o) n e)))
; question 2
(define-macro (assign sym1 sym2 expr1 expr2)
  `(begin
     (define ,sym1 ,expr1)
     (define ,sym2 ,(eval expr2))))

; question 3
(define-macro (switch expr cases)
    `(let ((val ,expr))
	  ,(cons
	    `cond
	    (map (lambda (case) (cons
	           (list `equal? `val (car case))
		       (cdr case)))
		     cases))))