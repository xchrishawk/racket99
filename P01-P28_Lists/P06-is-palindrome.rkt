#!/usr/bin/racket
#lang racket

; P06-is-palindrome.rkt
; Chris Vig (chris@invictus.so)

; -- Requires --

(require "P05-reverse-list.rkt")

; -- Provides --

(provide lists-equal?)
(provide is-palindrome?)

; -- Public Procedures --

; Returns #t if lists a and b are equal.
; e.g., (lists-equal? '(1 2) '(1 2 3)) -> #f
(define/contract (lists-equal? a b)
  (-> list? list? boolean?)
  (cond
    [(and (null? a) (null? b)) #t]		; both lists empty - lists are equal
    [(or (null? a) (null? b)) #f]		; one is null but other isn't
    [(not (equal? (car a) (car b))) #f]		; current item doesn't match
    [else (lists-equal? (cdr a) (cdr b))]))	; current item matches - iterate

; Returns #t if list is a palindrome.
; e.g., (is-palindrome? '(r a d a r)) -> #t
(define/contract (is-palindrome? lst)
  (-> list? boolean?)
  (lists-equal? lst (reverse-list lst)))

; -- Unit Tests --

(module+ test
  (require rackunit)
  (test-case "lists-equal?"
    (check-true (lists-equal? null null))
    (check-false (lists-equal? null '(a)))
    (check-true (lists-equal? '(a) '(a)))
    (check-false (lists-equal? '(a) '(b)))
    (check-true (lists-equal? '(a b c) '(a b c)))
    (check-false (lists-equal? '(a b c) '(a b d))))
  (test-case "lists-equal? contract"
    (check-exn exn:fail:contract? (λ () (lists-equal? #f null)))
    (check-exn exn:fail:contract? (λ () (lists-equal? null #f))))
  (test-case "is-palindrome?"
    (check-true (is-palindrome? null))
    (check-true (is-palindrome? '(1)))
    (check-false (is-palindrome? '(1 2)))
    (check-true (is-palindrome? '(1 2 3 2 1)))
    (check-false (is-palindrome? '(1 2 3 2 2))))
  (test-case "is-palindrome? contract"
    (check-exn exn:fail:contract? (λ () (is-palindrome? #\a)))))
