#!/usr/bin/racket
#lang racket

; P20-remove-at.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide remove-at)

; -- Public Procedures --

; Removes the element at the specified index in a list.
; e.g. (remove-at '(1 2 3) 1) -> '(1 3)
(define/contract (remove-at lst idx)
  (-> list? exact-nonnegative-integer? list?)
  (cond
    [(null? lst) null]
    [(zero? idx) (cdr lst)]
    [else (cons (car lst) (remove-at (cdr lst) (sub1 idx)))]))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "remove-at"
    (define (test lst idx expected)
      (check-equal? (remove-at lst idx) expected))
    (test null 0 null)
    (test null 1 null)
    (test '(1) 0 null)
    (test '(1) 1 '(1))
    (test '(1 2 3) 0 '(2 3))
    (test '(1 2 3) 1 '(1 3))
    (test '(1 2 3) 2 '(1 2))
    (test '(1 2 3) 3 '(1 2 3)))

  (test-case "remove-at contract"
    (define (test-fail lst idx)
      (check-exn exn:fail:contract? (λ () (remove-at lst idx))))
    (test-fail #f 0)
    (test-fail null -1)
    (test-fail null #t)))
