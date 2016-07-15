#!/usr/bin/racket
#lang racket

; P04-count-list.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide count-list)

; -- Public Procedures --

; Returns the number of items in a list.
; e.g., (count-list '(1 2 3)) -> 3
(define/contract (count-list lst)
  (-> list? exact-nonnegative-integer?)
  (let iterate ([lst lst] [count 0])
    (if (null? lst)
        count
        (iterate (cdr lst) (add1 count)))))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "count-list"
    (check-equal? (count-list null) 0)
    (check-equal? (count-list '(#t)) 1)
    (check-equal? (count-list '(#\a #\b #\c)) 3))
  (test-case "count-list contract"
    (check-exn exn:fail:contract? (λ () (count-list #f)))))
