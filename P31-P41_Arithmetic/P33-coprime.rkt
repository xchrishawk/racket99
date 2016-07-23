#!/usr/bin/racket
#lang racket

; P33-coprime.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide coprime?)

; -- Public Procedures --

; Returns #t if A and B are coprime (i.e., their GCD is 1).
(define/contract (coprime? a b)
  (-> exact-positive-integer? exact-positive-integer? boolean?)
  (= 1 (gcd a b)))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "coprime?"
    (define (test a b expected)
      (check-equal? (coprime? a b) expected))
    (test 12 1 #t)
    (test 12 2 #f)
    (test 12 5 #t)
    (test 12 6 #f)
    (test 12 7 #t)
    (test 12 8 #f)
    (test 12 13 #t)
    (test 12 14 #f)
    (test 12 17 #t)
    (test 12 18 #f))

  (test-case "coprime? contract"
    (define (test-fail a b)
      (check-exn exn:fail:contract? (λ () (coprime? a b))))
    (test-fail 12 -1)
    (test-fail 12 0)
    (test-fail 12 null)
    (test-fail -1 12)
    (test-fail 0 12)
    (test-fail "bongos" 12)))
