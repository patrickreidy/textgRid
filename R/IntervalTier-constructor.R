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
  def  = function(praatText, ...) {
    standardGeneric('IntervalTier')
  }
)

#' @rdname IntervalTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'IntervalTier',
  sig = c(praatText = 'character'),
  def = function(praatText) {
    # Initialize the IntervalTier object.
    new(Class = 'IntervalTier',
        name       = .TierName(praatText),
        number     = .TierNumber(praatText),
        startTimes = .IntervalStartTimes(praatText),
        endTimes   = .IntervalEndTimes(praatText),
        labels     = .IntervalLabels(praatText)
    )
  }
)
