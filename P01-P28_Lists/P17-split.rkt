#!/usr/bin/racket
#lang racket

; P17-split.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide split)

; -- Public Procedures --

; Splits a list into two lists at the specified index.
; e.g., (split '(1 2 3 4) 2) -> (values '(1 2) '(3 4))
(define/contract (split lst idx)
  (-> list? exact-nonnegative-integer? (values list? list?))
  (if (or (null? lst) (zero? idx))
      (values null lst)
      (let-values ([(head tail) (split (cdr lst) (sub1 idx))])
        (values (cons (car lst) head) tail))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "split"
    (define (test lst idx expected-head expected-tail)
      (let-values ([(actual-head actual-tail) (split lst idx)])
        (check-equal? actual-head expected-head)
        (check-equal? actual-tail expected-tail)))
    (test null 0 null null)
    (test null 1 null null)
    (test '(1) 0 null '(1))
    (test '(1) 1 '(1) null)
    (test '(1 2 3) 0 null '(1 2 3))
    (test '(1 2 3) 1 '(1) '(2 3))
    (test '(1 2 3) 2 '(1 2) '(3))
    (test '(1 2 3) 3 '(1 2 3) null)
    (test '(1 2 3) 4 '(1 2 3) null))

  (test-case "split contract"
    (define (test-fail lst idx)
      (check-exn exn:fail:contract? (λ () (split lst idx))))
    (test-fail #f 0)
    (test-fail null -1)
    (test-fail null #f)))
