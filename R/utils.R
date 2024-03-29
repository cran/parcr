#' Testing for empty atomic vector.
#'
#' @param l An object.
#'
#' @return S logical value.
#' @noRd
is_empty_atom <- function(l) {
  is.atomic(l) && length(l) == 0
}

#' Ensure that the structure of objects is preserved.
#'
#' After successful parsing the result must be present in a list to preserve
#' its structure. For example, a data frame or a matrix must be preserved.
#'
#' @param x Any R-object.
#'
#' @return A list.
#' @noRd
ensure.list <- function(x)  {
  if (is_empty_atom(x)) list()
  else {
    if (!isa(x, "list")) list(x) else x
    # if (!methods::is(x,'list')) list(x) else x
  }
}
