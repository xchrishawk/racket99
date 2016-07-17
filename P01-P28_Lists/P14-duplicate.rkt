#!/usr/bin/racket
#lang racket

; P14-duplicate.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide duplicate)

; -- Public Procedures --

; Duplicates all elements in a list.
; e.g., (duplicate '(a b c)) -> '(a a b b c c)
(define/contract (duplicate lst)
  (-> list? list?)
  (if (null? lst)
      null
      (cons (car lst) (cons (car lst) (duplicate (cdr lst))))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "duplicate"
    (define (test input expected)
      (check-equal? (duplicate input) expected))
    (test null null)
    (test '(a) '(a a))
    (test '(a b c) '(a a b b c c)))

  (test-case "duplicate contract"
    (check-exn exn:fail:contract? (λ () (duplicate #t)))))
