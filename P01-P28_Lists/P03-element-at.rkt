#!/usr/bin/racket
#lang racket

; P03-element-at.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide element-at)

; -- Public Procedures --

; Returns the element at a specific index in a list.
; e.g., (element-at '(1 2 3) 1) -> 2
(define/contract (element-at lst idx)
  (-> list? exact-nonnegative-integer? any/c)
  (cond
    [(null? lst) (error "index out of range")]
    [(zero? idx) (car lst)]
    [else (element-at (cdr lst) (sub1 idx))]))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "element-at"
    (define (test-fail lst idx)
      (check-exn exn:fail? (λ () (element-at lst idx))))
    (test-fail null 0)
    (test-fail '(0 1 2) 3)
    (define (test lst idx expected)
      (check-equal? (element-at lst idx) expected))
    (test '(a) 0 'a)
    (test '(a b) 1 'b)
    (test '(a b c d e) 2 'c))

  (test-case "element-at contract"
    (check-exn exn:fail:contract? (λ () (element-at 2 0)))
    (check-exn exn:fail:contract? (λ () (element-at '(a b c) #f)))))
