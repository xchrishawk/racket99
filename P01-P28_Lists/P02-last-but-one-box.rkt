#!/usr/bin/racket
#lang racket

; P02-last-but-one-box.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide last-but-one-box)

; -- Public Procedures --

; Returns the last but one box of a list.
; e.g., (last-but-one-box '(a b c d)) -> '(c d)
(define/contract (last-but-one-box lst)
  (-> list? list?)
  (cond
    [(null? lst) null]
    [(null? (cdr lst)) null]
    [(null? (cddr lst)) lst]
    [else (last-but-one-box (cdr lst))]))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "last-but-one-box"
    (check-equal? (last-but-one-box null) null)
    (check-equal? (last-but-one-box '(a)) null)
    (check-equal? (last-but-one-box '(a b)) '(a b))
    (check-equal? (last-but-one-box '(a b c)) '(b c)))
  (test-case "last-but-one-box contract"
    (check-exn exn:fail:contract? (λ () (last-but-one-box 15)))))
