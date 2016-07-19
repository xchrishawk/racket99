# Racket99

This is a work-in-progress implementation of the [L99 Lisp problem set](http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html) using [Racket](https://racket-lang.org/), a variant of Scheme Lisp.

## Features

- Unit tests using [RackUnit](http://docs.racket-lang.org/rackunit/) to demonstrate correctness of the algorithms
- Racket contracts to ensure correct usage of functions

## Allowed Functions

To keep true to the spirit of the challenge, only a limited subset of Lisp functions are used to implement the problems themselves (basically those which would be available in most implementations of Lisp). These include:

- `+`, `-`, `*`, `/`, `=`, `<`, `>`, etc.
- `add1`
- `and`
- `car`/`cdr` (and variants like `cadr`)
- `cond`
- `cons`
- `equal?`
- `if`
- `let`/`let*`
- `list`
- `list?`
- `modulo`
- `not`
- `null`
- `null?`
- `or`
- `sub1`
- `values`

In addition, if an implementation for a function has been given in a previous solution, it's OK to use the built-in version for later problems. These functions include:

- `append` (implemented in P07-flatten-list.rkt as `append-list`)
- `length` (implemented in P04-count-list.rkt as `count-list`)
- `list-ref` (implemented in P03-element-at.rkt as `element-at`)
- `reverse` (implemented in P04-reverse-list.rkt as `reverse-list`)
- `split-at` (implemented in P17-split.rkt as `split`)

Other functions are fair game for unit tests.
