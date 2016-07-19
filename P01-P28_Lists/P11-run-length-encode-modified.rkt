#!/usr/bin/racket
#lang racket

; P11-run-length-encode-modified.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P09-pack-dups.rkt")

; -- Provides --

(provide run-length-encode-modified)

; -- Public Procedures --

; Returns a modified run-length encoding representation of a list.
; e.g., (run-length-encode-modified '(a a a b b c d d d)) -> '((3 a) (2 b) c (3 d))
(define/contract (run-length-encode-modified lst)
  (-> list? list?)
  (let iterate ([lst (pack-dups lst)])
    (if (null? lst)
        null
        (let* ([sublist (car lst)]
               [item (car sublist)]
               [count (length sublist)]
               [value-to-append (if (= 1 count)
                                    item
                                    (list count item))])
          (cons value-to-append (iterate (cdr lst)))))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "run-length-encode-modified"
    (define (test input expected)
      (check-equal? (run-length-encode-modified input) expected))
    (test null null)
    (test '(a) '(a))
    (test '(a b c) '(a b c))
    (test '(a a a b b c) '((3 a) (2 b) c))
    (test '(a b b c c c) '(a (2 b) (3 c))))

  (test-case "run-length-encode-modified contract"
    (check-exn exn:fail:contract? (λ () (run-length-encode-modified 0+1i)))))
