#!/usr/bin/racket
#lang racket

; P24-lotto.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P22-list-integers.rkt")
(require "P23-random-select.rkt")

; -- Public Procedures --

; Selects count random integers in the range [0, max).
(define/contract (lotto count max)
  (-> exact-positive-integer? exact-positive-integer? (listof exact-nonnegative-integer?))
  (random-select (list-integers max) count))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "lotto"
    (define (test count max)
      (let ([results (lotto count max)])
        (check-equal? (length results) count)
        (check-true (andmap (integer-in 0 max) results))))
    (test 1 1)
    (test 2 5)
    (test 6 49))

  (test-case "lotto contract"
    (define (test-fail count max)
      (check-exn exn:fail:contract? (λ () (lotto count max))))
    (test-fail -1 100)
    (test-fail 0 100)
    (test-fail #t 100)
    (test-fail 100 -1)
    (test-fail 100 0)
    (test-fail 100 "nope")))
