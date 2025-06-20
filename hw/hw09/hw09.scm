(define (curry-cook formals body) 
  (cond
    ((null? (cdr formals)) (list `lambda formals body))
    (else (list `lambda `(,(car formals)) (curry-cook (cdr formals) body)))
  )
)

(define (curry-consume curry args)
  (cond
    ((null? args) curry)
    (else (curry-consume (curry (car args)) (cdr args)))
  )
)

(define-macro (switch expr options)
  (switch-to-cond (list 'switch expr options)))

; (define (switch-to-cond switch-expr)
;   (cons `cond 
;         (map (lambda (option)
;                (cons (list `equal? (cons (car (cdr switch-expr)) (cdr option)))
;              (car (cdr (cdr switch-expr))))))
(switch-to-cond `(switch (+ 1 1) ((1 2) (2 4) (3 6))))

(define (switch-to-cond switch-expr)
  (cons `cond
    (map
	  (lambda (option) (cons (list `equal? (car (cdr switch-expr)) (car option)) (cdr option)))
	  (car (cdr (cdr switch-expr))))))