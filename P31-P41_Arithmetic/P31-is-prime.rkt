#!/usr/bin/racket
#lang racket

; P31-is-prime.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide prime?)

; -- Public Procedures --

; Returns #t if N is prime.
(define/contract (prime? n)
  (-> exact-positive-integer? boolean?)
  (let ([max-candidate-divisor (inexact->exact (truncate (sqrt n)))])
    (let iterate ([i 2])
      (cond
        [(> i max-candidate-divisor) #t]
        [(zero? (remainder n i)) #f]
        [else (iterate (add1 i))]))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "prime?"
    (define (test n expected)
      (check-equal? (prime? n) expected))
    (let ([primes (set 1 2 3 5 7 11 13 17 19 23 29
                       31 37 41 43 47 53 59 61 67 71
                       73 79 83 89 97 101 103 107 109 113
                       127 131 137 139 149 151 157 163 167 173
                       179 181 191 193 197 199 211 223 227 229)])
      (for ([n (in-range 1 230)])
        (test n (set-member? primes n)))))

  (test-case "prime? contract"
    (define (test-fail n)
      (check-exn exn:fail:contract? (λ () (prime? n))))
    (test-fail -1)
    (test-fail 0)
    (test-fail null)))
