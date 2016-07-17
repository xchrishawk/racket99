#!/usr/bin/racket
#lang racket

; P09-pack-dups.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P05-reverse-list.rkt")

; -- Provides --

(provide pack-dups)

; -- Public Procedures --

; Packs duplicate entries in a list into sublists.
; e.g., (pack-dups '(a a a b b c d d)) -> '((a a a) (b b) (c) (d d))
(define/contract (pack-dups lst)
  (-> list? list?)

  (define (iterate in out working)
    (cond

      ; No input left - terminating condition
      [(null? in)
       (cons working out)]

      ; Either the working set is empty (first iteration), or the next value is equal to working value
      [(or (null? working) (equal? (car in) (car working)))
       (iterate (cdr in) out (cons (car in) working))]

      ; Not first iteration, and next value is not equal to working value
      [else
       (iterate (cdr in) (cons working out) (list (car in)))]))

  (if (null? lst)
      null
      (reverse-list (iterate lst null null))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "pack-dups"
    (define (test input expected)
      (check-equal? (pack-dups input) expected))
    (test null null)
    (test '(1) '((1)))
    (test '(1 1 1) '((1 1 1)))
    (test '(1 2 2 3 3 3) '((1) (2 2) (3 3 3)))
    (test '(1 1 1 2 2 3) '((1 1 1) (2 2) (3))))

  (test-case "pack-dups contract"
    (check-exn exn:fail:contract? (λ () (pack-dups 14)))))
