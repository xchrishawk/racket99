#!/usr/bin/racket
#lang racket

; P22-list-integers.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide list-integers)

; -- Public Procedures --

; Returns a list of integers from [0, n).
; e.g., (list-integer 5) -> '(0 1 2 3 4)
(define/contract (list-integers n)
  (-> exact-nonnegative-integer? list?)
  (let rec ([x 0])
    (if (= x n)
        null
        (cons x (rec (add1 x))))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "list-integers"
    (define (test n expected)
      (check-equal? (list-integers n) expected))
    (test 0 null)
    (test 1 '(0))
    (test 3 '(0 1 2))
    (test 5 '(0 1 2 3 4)))

  (test-case "list-integers contract"
    (define (test-fail n)
      (check-exn exn:fail:contract? (λ () (list-integers n))))
    (test-fail -1)
    (test-fail #t)))
