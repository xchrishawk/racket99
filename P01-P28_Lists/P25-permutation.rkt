#!/usr/bin/racket
#lang racket

; P25-permutation.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide permutation)

; -- Public Procedures --

; Returns a random permutation of lst.
(define/contract (permutation lst)
  (-> list? list?)

  ; Pulls a random element from lst. Returns (values element items-remaining-in-list).
  (define (get-random lst)
    (let iterate ([lst lst] [idx (random (length lst))])
      (if (zero? idx)
          (values (car lst) (cdr lst))
          (let-values ([(element tail) (iterate (cdr lst) (sub1 idx))])
            (values element (cons (car lst) tail))))))

  ; Outer loop.
  (if (null? lst)
      null
      (let-values ([(element remaining) (get-random lst)])
        (cons element (permutation remaining)))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "permutation"
    (define (count-elements lst)
      (let iterate ([lst lst] [output (hash)])
        (if (null? lst)
            output
            (iterate (cdr lst) (hash-set output (car lst) (add1 (hash-ref output (car lst) 0)))))))
    (define (test lst)
      (let ([perm (permutation lst)])
        (check-equal? (count-elements lst) (count-elements perm))))
    (test null)
    (test '(a))
    (test '(a b c d e))
    (test '(a b c d e d c b a b c d e)))

  (test-case "permutation contract"
    (check-exn exn:fail:contract? (λ () (permutation 4)))))
