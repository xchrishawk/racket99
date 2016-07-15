#!/usr/bin/racket
#lang racket

; P07-flatten-list.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide append-list)
(provide flatten-list)

; -- Public Procedures --

; Appends two lists together.
; e.g. (append-list '(a b) '(c d)) -> '(a b c d)
(define/contract (append-list a b)
  (-> list? list? list)
  (cond
    [(null? a) b]
    [else (cons (car a) (append-list (cdr a) b))]))

; Flattens a nested list structure.
; e.g. (flatten-list '(a b (c d (e f)) g)) -> '(a b c d e f g)
(define/contract (flatten-list lst)
  (-> list? list)
  (cond
    [(null? lst) null]
    [(list? (car lst)) (append (flatten-list (car lst)) (flatten-list (cdr lst)))]
    [else (cons (car lst) (flatten-list (cdr lst)))]))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "append-list"
    (check-equal? (append-list null null) null)
    (check-equal? (append-list '(a) null) '(a))
    (check-equal? (append-list null '(a)) '(a))
    (check-equal? (append-list '(a) '(b)) '(a b))
    (check-equal? (append-list '(a b c) '(d e f)) '(a b c d e f)))
  (test-case "append-list contract"
    (check-exn exn:fail:contract? (λ () (append-list #f null)))
    (check-exn exn:fail:contract? (λ () (append-list null #f))))
  (test-case "flatten-list"
    (check-equal? (flatten-list null) null)
    (check-equal? (flatten-list '(a)) '(a))
    (check-equal? (flatten-list '(a b c)) '(a b c))
    (check-equal? (flatten-list '(((a) b) c)) '(a b c))
    (check-equal? (flatten-list '(a (b (c)))) '(a b c))
    (check-equal? (flatten-list '(a (b (c) d) e)) '(a b c d e)))
  (test-case "flatten-list contract"
    (check-exn exn:fail:contract? (λ () (flatten-list #f)))))
