## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(parcr)

## ----out.width="40%", fig.align='left', echo=FALSE, fig.cap="<i>**Illustration of marker positioning when a parser fails on an input vector of length 6**. A parse tree in which the red positions differ from the input on the right. A `%then%` combinator shifts to the next element whereas an `%or%` combinator applies alternative parsers to the input. A marker (red square) will be put at the parser that fails at the input element with the highest index, which is element #5 here.</i>"----
knitr::include_graphics("tree.png")

## -----------------------------------------------------------------------------
p <- function() {
  literal("A") %then%
    literal("B") %then%
    (arm1() %or% arm2())
}

arm1 <- function() {
  literal("C") %then%
    literal("X") %then%
    literal("E") %then%
    literal("F")
}

arm2 <- function() {
  literal("C") %then% 
    (arm21() %or% arm22())
}

arm21 <- function() {
  literal("D") %then%
    literal("X") %then%
    literal("F")
}

arm22 <- function() {
  literal("X") %then%
    literal("E") %then%
    literal("F")
}

try(reporter(p() %then% eof())(LETTERS[1:6]))

