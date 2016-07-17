#!/usr/bin/racket
#lang racket

; P12-run-length-decode.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide prepend-list)
(provide run-length-decode)
(provide run-length-decode-modified)

; -- Public Procedures --

; Prepends N copies of an item onto a list.
; e.g., (prepend-list '(a b c) 'd 2) -> '(d d a b c)
(define/contract (prepend-list lst item count)
  (-> list? any/c exact-nonnegative-integer? list?)
  (if (zero? count)
      lst
      (cons item (prepend-list lst item (sub1 count)))))

; Decodes a run-length encoded list.
; e.g., (run-length-decode '((1 a) (2 b) (3 c))) -> '(a b b c c c)
(define/contract (run-length-decode lst)
  (-> list? list?)
  (if (null? lst)
      null
      (let* ([sublist (car lst)]
             [item (cadr sublist)]
             [count (car sublist)])
        (prepend-list (run-length-decode (cdr lst)) item count))))

; Decodes a modified run-length encoded list.
; e.g., (run-length-decode-modified '(a (2 b) (3 c))) -> '(a b b c c c)
(define/contract (run-length-decode-modified lst)
  (-> list? list?)
  (if (null? lst)
      null
      (let* ([sublist (car lst)]
             [item (if (list? sublist) (cadr sublist) sublist)]
             [count (if (list? sublist) (car sublist) 1)])
        (prepend-list (run-length-decode-modified (cdr lst)) item count))))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "prepend-list"
    (define (test lst item count expected)
      (check-equal? (prepend-list lst item count) expected))
    (test null 0 0 null)
    (test null 'a 1 '(a))
    (test null 'a 3 '(a a a))
    (test '(z) 'x 2 '(x x z))
    (test '(a b c) 'd 4 '(d d d d a b c)))

  (test-case "prepend-list contract"
    (define (test-fail lst item count)
      (check-exn exn:fail:contract? (λ () (prepend-list lst item count))))
    (test-fail #f 'a 0)
    (test-fail null 'a -1)
    (test-fail null 'a #f))

  (test-case "run-length-decode"
    (define (test input expected)
      (check-equal? (run-length-decode input) expected))
    (test null null)
    (test '((1 a)) '(a))
    (test '((3 a)) '(a a a))
    (test '((1 a) (2 b) (3 c)) '(a b b c c c))
    (test '((3 a) (2 b) (1 c)) '(a a a b b c)))

  (test-case "run-length-decode contract"
    (check-exn exn:fail:contract? (λ () (run-length-decode #f))))

  (test-case "run-length-decode-modified"
    (define (test input expected)
      (check-equal? (run-length-decode-modified input) expected))
    (test null null)
    (test '(a) '(a))
    (test '(a b c) '(a b c))
    (test '(a (2 b) (3 c)) '(a b b c c c))
    (test '((3 a) (2 b) c) '(a a a b b c)))

  (test-case "run-length-decode-modified contract"
    (check-exn exn:fail:contract? (λ () (run-length-decode "nope")))))
