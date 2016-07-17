#!/usr/bin/racket
#lang racket

; P10-run-length-encode-packed.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P04-count-list.rkt")
(require "P09-pack-dups.rkt")

; -- Provides --

(provide run-length-encode-packed)

; -- Public Procedures --

; Returns a run-length encoding representation of a list.
; e.g., (run-length-encode-packed '(a a a b b c d d d)) -> '((3 a) (2 b) (1 c) (3 d))
(define/contract (run-length-encode-packed lst)
  (-> list? list?)
  (let iterate ([lst (pack-dups lst)])
    (if (null? lst)
        null
        (let* ([sublist (car lst)]
               [item (car sublist)]
               [count (count-list sublist)])
          (cons (list count item) (iterate (cdr lst)))))))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "run-length-encode-packed"
    (define (test input expected-output)
      (check-equal? (run-length-encode-packed input) expected-output))
    (test null null)
    (test '(a) '((1 a)))
    (test '(a b c) '((1 a) (1 b) (1 c)))
    (test '(a a a b b c) '((3 a) (2 b) (1 c)))
    (test '(a b b c c c) '((1 a) (2 b) (3 c))))
  (test-case "run-length-encode-packed contract"
    (check-exn exn:fail:contract? (λ () (run-length-encode-packed #f)))))
