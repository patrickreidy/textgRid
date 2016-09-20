#' @include PointTier-class.R
NULL


#' Access the slots of PointTier objects.
#'
#' Functions for accessing the slots of a \code{\link[=PointTier-class]{PointTier}}
#' object.
#'
#' @param tier A \code{\link[=PointTier-class]{PointTier}} object.
#' @name PointTier-accessors
#' @seealso \code{\link{PointTier-class}},
#'   \code{\link{PointTier-constructor}}, \code{\link{Tier-accessors}}
NULL


#' @rdname PointTier-accessors
#' @export
pointTimes <- function(tier) {
  tier@times
}


#' @rdname PointTier-accessors
#' @export
pointLabels <- function(tier) {
  tier@labels
}
