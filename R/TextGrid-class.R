#' @include Tier-class.R IntervalTier-class.R PointTier-class.R
NULL


#' TextGrid S4 class for Praat TextGrids.
#'
#' The \code{TextGrid} class extends the \code{\link{list}} class.
#' A \code{TextGrid} object is essentially a list of
#' \code{\link[=IntervalTier-class]{IntervalTier}} and
#' \code{\link[=PointTier-class]{PointTier}} objects.
#'
#' @slot .Data A list of
#'   \code{\link[=IntervalTier-class]{IntervalTier}} and
#'   \code{\link[=PointTier-class]{PointTier}} objects.
#' @slot startTime A numeric, the start time of the TextGrid.
#' @slot endTime A numeric, the end time of the TextGrid.
#' @seealso \code{\link{TextGrid-constructor}},
#'   \code{\link{TextGrid-accessors}}, \code{\link{IntervalTier-class}},
#'   \code{\link{PointTier-class}}
#' @name TextGrid-class
#' @export
#' @importFrom methods setClass
setClass(
  Class = 'TextGrid',
  contains = c('list'),
  slots    = c(startTime = 'numeric',
               endTime   = 'numeric')
)
