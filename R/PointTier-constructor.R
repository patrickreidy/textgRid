#' @include PointTier-class.R
NULL


#' Create an instance of the PointTier class.
#'
#' An S4 generic and S4 methods for creating an \code{\link[=PointTier-class]{PointTier}}
#' object.
#'
#' @param praatText A character vector, the lines of text from a
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
  def  = function(praatText, ...)
    standardGeneric('PointTier')
)


#' @rdname PointTier-constructor
#' @importFrom methods setMethod new
setMethod(
  f   = 'PointTier',
  sig = c(praatText = 'character'),
  def = function(praatText)
    # Initialize the TextTier object.
    new(Class = 'PointTier',
        tierName   = .TierName(praatText),
        tierNumber = .TierNumber(praatText),
        times      = .PointTimes(praatText),
        labels     = .PointLabels(praatText)
    )
)
