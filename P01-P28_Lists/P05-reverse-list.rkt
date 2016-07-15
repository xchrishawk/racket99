#!/usr/bin/racket
#lang racket

; P05-reverse-list.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide reverse-list)

; -- Public Procedures --

; Reverses a list.
; e.g., (reverse-list '(b o n g o)) -> '(o g n o b)
(define/contract (reverse-list lst)
  (-> list? list?)
  (let iterate ([in lst] [out null])
    (if (null? in)
        out
        (iterate (cdr in) (cons (car in) out)))))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "reverse-list"
    (check-equal? (reverse-list null) null)
    (check-equal? (reverse-list '(a)) '(a))
    (check-equal? (reverse-list '(1 2 3 4 5)) '(5 4 3 2 1)))
  (test-case "reverse-list contract"
    (check-exn exn:fail:contract? (λ () (reverse-list 3.14)))))
