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
    [(list? (car lst)) (append-list (flatten-list (car lst)) (flatten-list (cdr lst)))]
    [else (cons (car lst) (flatten-list (cdr lst)))]))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "append-list"
    (define (test a b expected)
      (check-equal? (append-list a b) expected))
    (test null null null)
    (test '(a) null '(a))
    (test null '(a) '(a))
    (test '(a) '(b) '(a b))
    (test '(a b c) '(d e f) '(a b c d e f)))

  (test-case "append-list contract"
    (define (test-fail a b)
      (check-exn exn:fail:contract? (λ () (append-list a b))))
    (test-fail #f null)
    (test-fail null #f))

  (test-case "flatten-list"
    (define (test input expected)
      (check-equal? (flatten-list input) expected))
    (test null null)
    (test '(a) '(a))
    (test '(a b c) '(a b c))
    (test '(a (b (c))) '(a b c))
    (test '(((a) b) c) '(a b c))
    (test '(a (b (c) d) e) '(a b c d e)))

  (test-case "flatten-list contract"
    (check-exn exn:fail:contract? (λ () (flatten-list #f)))))
