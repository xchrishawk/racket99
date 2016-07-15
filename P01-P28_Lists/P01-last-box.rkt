#!/usr/bin/racket
#lang racket

; P01-last-box.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide last-box)

; -- Public Procedures --

; Returns the last box of a list.
; e.g., (last-box '(1 2 3)) -> '(3)
(define/contract (last-box lst)
  (-> list? list?)
  (cond
    [(null? lst) null]
    [(null? (cdr lst)) lst]
    [else (last-box (cdr lst))]))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "last-box"
    (check-equal? (last-box null) null)
    (check-equal? (last-box '(1)) '(1))
    (check-equal? (last-box '(1 2 3)) '(3)))
  (test-case "last-box contract"
    (check-exn exn:fail:contract? (λ () (last-box 1)))))
