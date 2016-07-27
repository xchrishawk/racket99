#!/usr/bin/racket
#lang racket

; P26-combinations.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide combinations)

; -- Public Procedures --

; Returns all unique combinations of N elements selected from lst.
(define/contract (combinations lst n)
  (->i ([lst () (non-empty-listof any/c)]
        [n (lst) (and/c exact-positive-integer? (<=/c (length lst)))])
       [result () (listof list?)])
  (cond
    [(null? lst) null]		; not technically necessary since contract will fail...
    [(= n 0) null]		; not technically necessary since contract will fail...
    [(= n 1) (map list lst)]
    [else
     (append
      (map (λ (subcombination) (cons (car lst) subcombination)) (combinations (cdr lst) (sub1 n)))
      (combinations (cdr lst) n))]))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "combinations"
    (define (test lst n expected)
      (check-equal? (combinations lst n) expected))
    (test '(1) 1 '((1)))
    (test '(1 2) 1 '((1) (2)))
    (test '(1 2 3) 2 '((1 2) (1 3) (2 3)))
    (test '(1 2 3 4 5) 2 '((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5)))
    (test '(1 2 3 4 5) 5 '((1 2 3 4 5))))

  (test-case "combinations contract"
    (define (test-fail lst n)
      (check-exn exn:fail:contract? (λ () (combinations lst n))))
    (test-fail #f 0)
    (test-fail null 0)
    (test-fail '(1) 2)
    (test-fail '(1) 0)
    (test-fail '(1) -1)))
