#!/usr/bin/racket
#lang racket

; P06-is-palindrome.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide is-palindrome?)

; -- Public Procedures --

; Returns #t if list is a palindrome.
; e.g., (is-palindrome? '(r a d a r)) -> #t
(define/contract (is-palindrome? lst)
  (-> list? boolean?)
  (equal? lst (reverse lst)))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "is-palindrome?"
    (define (test input expected)
      (check-equal? (is-palindrome? input) expected))
    (test null #t)
    (test '(1) #t)
    (test '(1 2) #f)
    (test '(1 2 3 2 1) #t)
    (test '(1 2 3 2 2) #f))

  (test-case "is-palindrome? contract"
    (check-exn exn:fail:contract? (λ () (is-palindrome? #\a)))))
