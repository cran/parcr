#' Turn a parser into an error reporting parser
#'
#' Turns a parser into an error reporting parser, and when the parser is
#' successful returns only the `L`-element of the parser output, the
#' successfully parsed part of the input (see [succeed()]).
#'
#' @param p a parser.
#'
#' @return The `L`-part of a successful parser result or an error message about
#'         the line where the parser failed. A warning is thrown when the parser
#'         did not completely consume the input.
#'
#' @details
#' The error object that this function returns is a list containing the
#' elements `linenr` and `linecontent`, corresponding to the line in which the
#' parser failed and its content. The user of this package can catch this
#' object to create custom error messages instead of the message generated by
#' this function.
#'
#' A warning is issued when the parser did not completely consume the input.
#' Complete consumption of input is only explicitly made when the parser ends
#' with [eof()]. Therefore, even though all elements were parsed, a zero-length
#' character vector will remain in the `R` element if the parser does not end
#' with [eof()].
#'
#' @export
#'
#' @examples
#' at <- function() literal("a") %then% literal("t")
#' atat <- rep(c("a","t"),2)
#' # Yields an error message about parser failing on line 5
#' try(
#'   reporter(match_n(3,at()) %then% eof())(c(atat,"t","t"))
#' )
#' # No error, but parser result
#' reporter(match_n(2,at()) %then% eof())(atat)
#' # warning: the input is not completely consumed
#' try(
#'   reporter(match_n(2,at()))(atat)
#' )
#'
reporter <- function(p) {
  reset_LNR()
  function(x) {
    r <- p(x)
    if (!failed(r)) {
      if (!finished(r)) {
        warning("The parser did not completely consume the input. Consider using eof().", call. = FALSE)
      }
      r$L
    } else parser_error(nr=marker_val(r), content=x[marker_val(r)])
  }
}

#' Create a customized condition object
#'
#' @details
#' from https://adv-r.hadley.nz/conditions.html
#'
#'
#' @return A condition object.
#' @noRd
stop_custom <- function(.subclass, message, call = NULL, ...) {
  err <- structure(
    list(
      message = message,
      call = call,
      ...
    ),
    class = c(.subclass, "error", "condition")
  )
  stop(err)
}

#' Report an error when a parser fails
#'
#' @return A condition object
#' @noRd
parser_error <- function(nr, content) {
  message = paste0("Parser failed on line ", nr, " of input.\nLine content: \"",content,"\"")
  stop_custom (.subclass = "error_parser",
               message = message,
               linenr = nr,
               linecontent = content)
}
