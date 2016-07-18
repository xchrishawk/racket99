#!/usr/bin/racket
#lang racket

; P19-rotate.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P04-count-list.rkt")
(require "P07-flatten-list.rkt")
(require "P17-split.rkt")

; -- Provides --

(provide rotate)

; -- Public Procedures --

; Rotates a list by N places to the left.
; e.g., (rotate '(1 2 3 4) 2) -> '(3 4 1 2)
(define/contract (rotate lst n)
  (-> list? exact-integer? list?)
  (if (zero? n)
      lst
      (let*-values ([(n) (modulo n (count-list lst))]
                    [(head tail) (split lst n)])
        (append-list tail head))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "rotate"
    (define (test lst n expected)
      (check-equal? (rotate lst n) expected))
    (test null 0 null)
    (test '(1) 1 '(1))
    (test '(1 2 3) 0 '(1 2 3))
    (test '(1 2 3) 1 '(2 3 1))
    (test '(1 2 3) 2 '(3 1 2))
    (test '(1 2 3) 3 '(1 2 3))
    (test '(1 2 3) 4 '(2 3 1))
    (test '(1 2 3) -1 '(3 1 2))
    (test '(1 2 3) -2 '(2 3 1))
    (test '(1 2 3) -3 '(1 2 3))
    (test '(1 2 3) -4 '(3 1 2)))

  (test-case "rotate contract"
    (define (test-fail lst n)
      (check-exn exn:fail:contract? (λ () (rotate lst n))))
    (test-fail #t 0)
    (test-fail '(1 2 3) "argh")))
