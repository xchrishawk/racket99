#!/usr/bin/racket
#lang racket

; P13-run-length-encode.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide run-length-encode)
(provide run-length-encode-modified)

; -- Public Procedures --

; Builds a run-length encoded version of a list.
; e.g., (run-length-encode '(a b b c c c)) -> '((1 a) (2 b) (3 c))
(define (run-length-encode lst)
  (run-length-encode-internal lst (λ (count item) (list count item))))

; Builds a modified run-length encoded version of a list.
; e.g., (run-length-encode '(a b b c c c)) -> '(a (2 b) (3 c))
(define (run-length-encode-modified lst)
  (run-length-encode-internal lst (λ (count item)
                                    (if (= count 1)
                                        item
                                        (list count item)))))

; -- Private Procedures --

(define (run-length-encode-internal lst rle)

  ; Recursive algorithm to generate RLE
  (define (rec lst current-count current-item)
    (cond

      ; Terminating condition - nothing left in list
      [(null? lst)
       (list (rle current-count current-item))]

      ; Next item is equal to the current working item
      [(equal? (car lst) current-item)
       (rec (cdr lst) (add1 current-count) current-item)]

      ; Next item is different from the current working item
      [else
       (cons (rle current-count current-item) (rec (cdr lst) 1 (car lst)))]))

  (if (null? lst)
      null
      (rec (cdr lst) 1 (car lst))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "run-length-encode"
    (define (test input expected-output)
      (check-equal? (run-length-encode input) expected-output))
    (test null null)
    (test '(a) '((1 a)))
    (test '(a b c) '((1 a) (1 b) (1 c)))
    (test '(a a a b b c) '((3 a) (2 b) (1 c)))
    (test '(a b b c c c) '((1 a) (2 b) (3 c))))

  (test-case "run-length-encode contract"
    (check-exn exn:fail:contract? (λ () (run-length-encode #f))))

  (test-case "run-length-encode-modified"
    (define (test input expected)
      (check-equal? (run-length-encode-modified input) expected))
    (test null null)
    (test '(a) '(a))
    (test '(a b c) '(a b c))
    (test '(a a a b b c) '((3 a) (2 b) c))
    (test '(a b b c c c) '(a (2 b) (3 c))))

  (test-case "run-length-encode-modified contract"
    (check-exn exn:fail:contract? (λ () (run-length-encode-modified #f)))))
