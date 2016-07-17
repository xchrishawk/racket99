#!/usr/bin/racket
#lang racket

; P15-replicate.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P12-run-length-decode.rkt")

; -- Provides --

(provide replicate)

; -- Public Procedures --

; Replicates each element of a list N times.
; e.g., (replicate '(a b c) 3) -> '(a a a b b b c c c)
(define/contract (replicate lst num)
  (-> list? exact-nonnegative-integer? list?)
  (if (or (null? lst) (zero? num))
      null
      (prepend-list (replicate (cdr lst) num) (car lst) num)))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "replicate"
    (define (test lst num expected)
      (check-equal? (replicate lst num) expected))
    (test null 0 null)
    (test null 1 null)
    (test '(a) 0 null)
    (test '(a) 1 '(a))
    (test '(a) 3 '(a a a))
    (test '(a b c) 0 null)
    (test '(a b c) 1 '(a b c))
    (test '(a b c) 3 '(a a a b b b c c c)))

  (test-case "replicate contract"
    (define (test-fail lst num)
      (check-exn exn:fail:contract? (λ () (replicate lst num))))
    (test-fail #f 1)
    (test-fail null #f)
    (test-fail null -1)))
