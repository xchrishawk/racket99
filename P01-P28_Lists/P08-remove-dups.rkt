#!/usr/bin/racket
#lang racket

; P08-remove-dups.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P05-reverse-list.rkt")

; -- Provides --

(provide remove-dups)

; -- Public Procedures --

; Removes duplicate entries from a list.
; e.g., (remove-dups '(a a a b b c a b d d)) -> '(a b c a b d)
(define/contract (remove-dups lst)
  (-> list? list?)
  (define (iterate in out)
    (if (null? in)
        out
        (iterate (cdr in) (if (or (null? out)
                                  (not (equal? (car in) (car out))))
                              (cons (car in) out)
                              out))))
  (reverse-list (iterate lst null)))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "remove-dups"
    (check-equal? (remove-dups null) null)
    (check-equal? (remove-dups '(a)) '(a))
    (check-equal? (remove-dups '(a a a)) '(a))
    (check-equal? (remove-dups '(a a b c c d)) '(a b c d))
    (check-equal? (remove-dups '(a b b c d d)) '(a b c d)))
  (test-case "remove-dups contract"
    (check-exn exn:fail:contract? (λ () (remove-dups 4)))))
