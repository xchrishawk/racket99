#!/usr/bin/racket
#lang racket

; P32-greatest-common-divisor.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide greatest-common-divisor)

; -- Public Procedures --

; Returns the GCD of A and B using Euclid's algorithm.
(define/contract (greatest-common-divisor a b)
  (-> exact-positive-integer? exact-positive-integer? exact-positive-integer?)
  (let iterate ([a a] [b b])
    (if (zero? b)
        a
        (iterate b (remainder a b)))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "greatest-common-divisor"
    (define (test a b expected)
      (check-equal? (greatest-common-divisor a b) expected))
    (test 1 1 1)
    (test 1 2 1)
    (test 2 2 2)
    (test 4 8 4)
    (test 8 4 4)
    (test 25 160 5))

  (test-case "greatest-common-divisor contract"
    (define (test-fail a b)
      (check-exn exn:fail:contract? (λ () (greatest-common-divisor a b))))
    (test-fail -1 10)
    (test-fail 0 10)
    (test-fail null 10)
    (test-fail 10 -1)
    (test-fail 10 0)
    (test-fail 10 #t))

  (test-case "greatest-common-divisor vs. reference implementation"
    (for ([unused (in-range 1000)])
      (let ([a (random 1000000)] [b (random 1000000)])
        (check-equal? (greatest-common-divisor a b) (gcd a b))))))
