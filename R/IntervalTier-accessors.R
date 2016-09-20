#' @include IntervalTier-class.R
NULL


#' Access the slots of IntervalTier objects.
#'
#' Functions for accessing the slots of an \code{\link[=IntervalTier-class]{IntervalTier}}
#' object.
#'
#' @param tier An \code{\link[=IntervalTier-class]{IntervalTier}} object.
#' @name IntervalTier-accessors
#' @seealso \code{\link{IntervalTier-class}},
#'   \code{\link{IntervalTier-constructor}}, \code{\link{Tier-accessors}}
NULL


#' @rdname IntervalTier-accessors
#' @export
intervalStartTimes <- function(tier) {
  tier@startTimes
}


#' @rdname IntervalTier-accessors
#' @export
intervalEndTimes <- function(tier) {
  tier@endTimes
}


#' @rdname IntervalTier-accessors
#' @export
intervalLabels <- function(tier) {
  tier@labels
}
