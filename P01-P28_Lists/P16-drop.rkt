#!/usr/bin/racket
#lang racket

; P16-drop.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide drop)

; -- Public Procedures --

; Drops every Nth item from a list.
; e.g., (drop '(a b c d e f) 3) -> '(a b d e)
(define/contract (drop lst n)
  (-> list? exact-positive-integer? list?)
  (let iterate ([lst lst] [current 1])
    (cond
      [(null? lst) null]
      [(= current n) (iterate (cdr lst) 1)]
      [else (cons (car lst) (iterate (cdr lst) (add1 current)))])))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "drop"
    (define (test lst n expected)
      (check-equal? (drop lst n) expected))
    (test null 1 null)
    (test '(a b c d e f) 1 null)
    (test '(a b c d e f) 2 '(a c e))
    (test '(a b c d e f) 3 '(a b d e))
    (test '(a b c d e f) 6 '(a b c d e))
    (test '(a b c d e f) 7 '(a b c d e f)))

  (test-case "drop contract"
    (define (test-fail lst n)
      (check-exn exn:fail:contract? (λ () (drop lst n))))
    (test-fail #f 1)
    (test-fail '(a b c) 0)
    (test-fail '(a b c) -1)
    (test-fail '(a b c) #f)))
