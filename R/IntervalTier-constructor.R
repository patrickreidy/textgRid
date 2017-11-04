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
  def = function(x, startTime = 0, endTime = NULL) {
    # TODO: Check if TierName column exists exists
    .name <- x$TierName[1]
    # TODO: Check if TierNumber col exists
    .number <- x$TierNumber[1]
    # TODO: Check if StartTime col exists
    # TODO: Check if EndTime col exists
    endTime = max(endTime, max(x$EndTime))
    # TODO: Check if Label col exists
    x <- x[, c('StartTime', 'EndTime', 'Label')]
    x <- x[order(x$StartTime), ]
    .endPrevious <- c(startTime, x$EndTime)
    .startCurrent <- c(x$StartTime, endTime)
    .gap <- .startCurrent - .endPrevious
    # TODO: Check whether annotations are non-overlapping, with any(.gap < 0)
    # Fill Gaps in Annotations
    .gaps <- data.frame(
      StartTime = .endPrevious,
      EndTime = .startCurrent,
      Label = NA
    )
    .gaps <- .gaps[.gap > 0, ]
    x <- rbind(x, .gaps)
    x <- x[order(x$StartTime), ]
    # Initialize the IntervalTier object.
    new(Class = 'IntervalTier',
        name       = .name,
        number     = .number,
        startTimes = x$StartTime,
        endTimes   = x$EndTime,
        labels     = x$Label
    )
  }
)
