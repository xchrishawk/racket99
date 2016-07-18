# Racket99

This is a work-in-progress implementation of the [L99 Lisp problem set](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html) using [Racket](https://racket-lang.org/), a variant of Scheme Lisp.

## Features

- Unit tests using [RackUnit](http://docs.racket-lang.org/rackunit/) to demonstrate correctness of the algorithms
- Racket contracts to ensure correct usage of functions

## Allowed Functions

To keep true to the spirit of the challenge, only a limited subset of Lisp functions are used to implement the problems themselves (basically those which would be available in most implementations of Lisp). These include:

- +, -, *, /, =, <, >, etc.
- add1
- and
- car/cdr (and variants like cadr)
- cond
- cons
- equal?
- if
- let/let*
- list
- list?
- modulo
- not
- null
- null?
- or
- sub1
- values

Higher-level functions are fair game for unit tests, etc. In addition, solutions to previous problems can be used to solve later problems.
