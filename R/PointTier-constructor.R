#' @include PointTier-class.R
NULL


#' Create an instance of the PointTier class.
#'
#' An S4 generic and S4 methods for creating an \code{\link[=PointTier-class]{PointTier}}
#' object.
#'
#' @param x A character vector, the lines of text from a
#'   \code{.TextGrid} file that define a PointTier.
#' @param ... optional arguments for multiple dispatch (in development).
#' @return A \code{\link[=PointTier-class]{PointTier}} object. Values for the
#'   \code{tierName}, \code{tierNumber}, \code{times}, and \code{labels}
#'   slots are parsed automatically from the \code{praatText}.
#' @name PointTier-constructor
#' @aliases PointTier
#' @seealso \code{\link{PointTier-class}}, \code{\link{PointTier-accessors}}
#' @importFrom methods setGeneric
setGeneric(
  name = 'PointTier',
  def  = function(x, ...)
    standardGeneric('PointTier')
)


#' @rdname PointTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'PointTier',
  sig = c(x = 'character'),
  def = function(x)
    # Initialize the TextTier object.
    new(Class = 'PointTier',
        name       = .TierName(x),
        number     = .TierNumber(x),
        times      = .PointTimes(x),
        labels     = .PointLabels(x)
    )
)


#' @rdname PointTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'PointTier',
  sig = c(x = 'data.frame'),
  def = function(x)
    # TODO: Check if TierName column exists exists
    # TODO: Check if TierNumber col exists
    # TODO: Check if StartTime col exists
    # TODO: Check if Label col exists
    # Initialize the TextTier object.
    new(Class = 'PointTier',
        name       = x$TierName[1],
        number     = x$TierNumber[1],
        times      = x$StartTime,
        labels     = x$Label
    )
)
