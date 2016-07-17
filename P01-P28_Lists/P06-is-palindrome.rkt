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
    (define (test a b expected)
      (check-equal? (lists-equal? a b) expected))
    (test null null #t)
    (test null '(a) #f)
    (test '(a) '(a) #t)
    (test '(a) '(b) #f)
    (test '(a b c) '(a b c) #t)
    (test '(a b c) '(a b d) #f))

  (test-case "lists-equal? contract"
    (define (test-fail a b)
      (check-exn exn:fail:contract? (λ () (lists-equal? a b))))
    (test-fail #f null)
    (test-fail null #f))

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
