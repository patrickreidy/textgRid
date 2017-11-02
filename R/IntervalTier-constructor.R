#' @include IntervalTier-class.R
NULL

#' Create an instance of the IntervalTier class.
#'
#' An S4 generic and S4 methods for creating an \code{\link[=IntervalTier-class]{IntervalTier}}
#' object.
#'
#' @param praatText A character vector, the lines of text from a
#'   \code{.TextGrid} file that define an IntervalTier.
#' @param ... optional arguments for multiple dispatch (in development).
#' @return A \code{\link[=IntervalTier-class]{IntervalTier}} object. Values for the
#'   \code{tierName}, \code{tierNumber}, \code{startTimes}, \code{endTimes},
#'   and \code{labels} slots are parsed automatically from the \code{praatText}.
#' @name IntervalTier-constructor
#' @aliases IntervalTier
#' @seealso \code{\link{IntervalTier-class}}, \code{\link{IntervalTier-accessors}}
#' @importFrom methods setGeneric
setGeneric(
  name = 'IntervalTier',
  def  = function(x, ...) {
    standardGeneric('IntervalTier')
  }
)

#' @rdname IntervalTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'IntervalTier',
  sig = c(x = 'character'),
  def = function(x) {
    # Initialize the IntervalTier object.
    new(Class = 'IntervalTier',
        name       = .TierName(x),
        number     = .TierNumber(x),
        startTimes = .IntervalStartTimes(x),
        endTimes   = .IntervalEndTimes(x),
        labels     = .IntervalLabels(x)
    )
  }
)


#' @rdname IntervalTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'IntervalTier',
  sig = c(x = 'data.frame'),
  def = function(x) {
    # TODO: Check if TierName column exists exists
    # TODO: Check if TierNumber col exists
    # TODO: Check if StartTime col exists
    # TODO: Check if EndTime col exists
    # TODO: Check if Label col exists
    # TODO: Check whether annotations are non-overlapping
    # TODO: Fill Gaps in Annotations
    # Initialize the IntervalTier object.
    new(Class = 'IntervalTier',
        name       = x$TierName[1],
        number     = x$TierNumber[1],
        startTimes = x$StartTime,
        endTimes   = x$EndTime,
        labels     = x$Label
    )
  }
)
