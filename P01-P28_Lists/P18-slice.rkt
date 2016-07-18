#!/usr/bin/racket
#lang racket

; P18-slice.rkt
; Chris Vig (chris@invictus.so)

; -- Provides --

(provide slice)

; -- Public Procedures --

; Extracts a slice from a list, between [start, end).
; e.g., (slice '(1 2 3 4 5) 1 3) -> '(2 3)
(define/contract (slice lst start end)

  (->i ([lst list?]
        [start exact-nonnegative-integer?]
        [end (start) (and/c exact-nonnegative-integer? (>=/c start))])
       [result list?])

  (let rec ([lst lst] [idx 0])
    (cond

      ; Terminating condition - either we've reached the end of the list, or the end index.
      [(or (null? lst) (= idx end))
       null]

      ; We're past or equal to the start point, but not yet at the end. Append this item.
      [(>= idx start)
       (cons (car lst) (rec (cdr lst) (add1 idx)))]

      ; Not yet to the starting point.
      [else
       (rec (cdr lst) (add1 idx))])))

; -- Unit Tests --

(module+ test
  (require rackunit)

  (test-case "slice"
    (define (test lst start end expected)
      (check-equal? (slice lst start end) expected))
    (test null 0 0 null)
    (test null 0 1 null)
    (test '(1) 0 0 null)
    (test '(1) 0 1 '(1))
    (test '(1 2 3) 0 0 null)
    (test '(1 2 3) 0 1 '(1))
    (test '(1 2 3) 0 2 '(1 2))
    (test '(1 2 3) 0 3 '(1 2 3))
    (test '(1 2 3) 1 1 null)
    (test '(1 2 3) 1 2 '(2))
    (test '(1 2 3) 1 3 '(2 3))
    (test '(1 2 3) 2 2 null)
    (test '(1 2 3) 2 3 '(3)))

  (test-case "slice contract"
    (define (test-fail lst start end)
      (check-exn exn:fail:contract? (λ () (slice lst start end))))
    (test-fail #f 0 0)
    (test-fail null #f 0)
    (test-fail null 0 #f)
    (test-fail null -1 0)
    (test-fail null 0 -1)
    (test-fail null 1 0)))
