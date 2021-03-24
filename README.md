# Data Structures and Algorithms in Julia

Algorithms written for the CIS3223 (Data Structures and Algorithms) class at Temple University based on the textbook *Algorithms* by Sanjoy Dasgupta, Umesh Vazirani, and Christos Papadimitriou.
Some algorithms are implemented using Wikipedia and other internet resources.

Note that not all of these algorithms are studied in this class and this class does not cover quantum algorithms.

## Overview

- [Chapter 0](./src/chapter0.jl): Prologue
- [Chapter 1](./src/chapter1.jl): Algorithms with numbers
- [Chapter 2](./src/chapter2.jl): Divide-and-conquer algorithms
- [Chapter 3](./src/chapter3.jl): Decomposition of graphs
- [Chapter 4](./src/chapter4.jl): Paths in graphs
- [Chapter 5](./src/chapter5.jl): Greedy algorithms
- [Chapter 6](./src/chapter6.jl): Dynamic programming
- [Chapter 7](./src/chapter7.jl): Linear programming and reductions
- [Chapter 8](./src/chapter8.jl): NP-complete problems
- [Chapter 9](./src/chapter9.jl): Coping with NP-completeness
- [Chapter 10](./src/chapter10.jl): Quantum algorithms

## Workflow

Install `Revise.jl` via `] add Revise`.

Start a Julia REPL session within the project directory and use `Pkg.activate(".")` via `] activate "."`.

Run the following commands and you're ready for development.

``` julia
using Revise
using CIS3223
```
