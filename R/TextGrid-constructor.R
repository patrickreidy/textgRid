#' @include Tier-class.R IntervalTier-class.R PointTier-class.R
NULL


#' Create an instance of the TextGrid class.
#'
#' An S4 generic and S4 methods for creating a \code{\link[=TextGrid-class]{TextGrid}}
#' object.
#'
#' @param textGrid A character vector
#' @param ... optional arguments for multiple dispatch (in development).
#' @return A \code{\link[=TextGrid-class]{TextGrid}} object.
#' @section Details for signature \code{c(textGrid = 'character')}:
#'  If \code{textGrid} is a string (i.e., a character vector with
#'  \code{length(textGrid)=1}), then it is assumed that the \code{textGrid}
#'  argument is the path to a \code{.TextGrid} file. Otherwise, the
#'  \code{textGrid} argument is assumed to be a character vector whose
#'  elements are the lines of some \code{.TextGrid} file.
#' @name TextGrid-constructor
#' @aliases TextGrid
#' @seealso \code{\link{TextGrid-class}}, \code{\link{TextGrid-accessors}}
#' @export
#' @importFrom methods setGeneric
setGeneric(
  name = 'TextGrid',
  def  = function(textGrid, ...)
    standardGeneric('TextGrid')
)

#' @rdname TextGrid-constructor
#' @export
#' @importFrom methods setMethod new
setMethod(
  f   = 'TextGrid',
  sig = c(textGrid = 'character'),
  def = function(textGrid) {
    if (length(textGrid) == 1) {
      .textgrid <- .ReadPraatFile(textGrid)
    } else {
      .textgrid <- textGrid
    }
    new(Class = 'TextGrid',
        .PraatText2TierObjects(.textgrid),
        startTime = .TextGridTime(.textgrid, pattern = '^xmin'),
        endTime = .TextGridTime(.textgrid, pattern = '^xmax')
    )
  })
