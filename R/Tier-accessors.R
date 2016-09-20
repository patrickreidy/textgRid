#' @include Tier-class.R
NULL


#' Methods for \code{Tier} objects.
#'
#' Get the values of slots in a \code{\link[=Tier-class]{Tier}} object.
#'
#' @param tier A \code{\link[=Tier-class]{Tier}} object.
#' @name Tier-accessors
#' @seealso \code{\link{Tier-class}}
NULL


#' @rdname Tier-accessors
#' @export
tierName <- function(tier) {
  tier@name
}


#' @rdname Tier-accessors
#' @export
tierNumber <- function(tier) {
  tier@number
}
