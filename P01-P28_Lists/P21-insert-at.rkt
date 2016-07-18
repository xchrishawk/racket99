#!/usr/bin/racket
#lang racket

; P21-insert-at.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide insert-at)

; -- Public Procedures --

; Inserts an item at the specified index in a list.
; e.g., (insert-at '(1 2 3) 1 'a) -> '(1 a 2 3)
(define/contract (insert-at lst idx item)
  (-> list? exact-nonnegative-integer? any/c list?)
  (if (or (null? lst) (zero? idx))
      (cons item lst)
      (cons (car lst) (insert-at (cdr lst) (sub1 idx) item))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "insert-at"
    (define (test lst idx item expected)
      (check-equal? (insert-at lst idx item) expected))
    (test null 0 'a '(a))
    (test null 1 'a '(a))
    (test '(1 2 3) 0 'a '(a 1 2 3))
    (test '(1 2 3) 1 'a '(1 a 2 3))
    (test '(1 2 3) 2 'a '(1 2 a 3))
    (test '(1 2 3) 3 'a '(1 2 3 a))
    (test '(1 2 3) 4 'a '(1 2 3 a)))

  (test-case "insert-at contract"
    (define (test-fail lst idx item)
      (check-exn exn:fail:contract? (λ () (insert-at lst idx item))))
    (test-fail #f 0 'a)
    (test-fail null -1 'a)
    (test-fail null #t 'a)))
