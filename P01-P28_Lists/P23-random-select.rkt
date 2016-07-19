#!/usr/bin/racket
#lang racket

; P23-random-select.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P20-remove-at.rkt")

; -- Provides --

(provide random-select)

; -- Public Procedures --

; Selects N random elements from a list.
; e.g., (random-select '(a b c d e) 2) -> '(d a)
(define/contract (random-select lst n)
  (-> list? exact-nonnegative-integer? list?)
  (let iterate ([lst lst] [out null] [n n] [len (length lst)])
    (if (or (null? lst) (zero? n))
        out
        (let* ([idx (random len)]
               [item (list-ref lst idx)]
               [remaining (remove-at lst idx)])
          (iterate remaining (cons item out) (sub1 n) (sub1 len))))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "random-select"
    (define (test lst n expected-length)
      (let ([result (random-select lst n)])
        (check-equal? (length result) expected-length)
        (check-false (check-duplicates result))
        (for ([obj (in-list result)])
          (check-not-false (member obj lst)))))
    (test null 0 0)
    (test null 1 0)
    (test '(a b c) 1 1)
    (test '(d e f) 2 2)
    (test '(g h i) 3 3)
    (test '(j k l) 4 3))

  (test-case "random-select contract"
    (define (test-fail lst n)
      (check-exn exn:fail:contract? (λ () (random-select lst n))))
    (test-fail #t 1)
    (test-fail '(a b c) -1)
    (test-fail '(a b c) "hello")))
