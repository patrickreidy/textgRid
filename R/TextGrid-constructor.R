#' @include Tier-class.R IntervalTier-class.R PointTier-class.R
NULL


#' Create an instance of the TextGrid class.
#'
#' An S4 generic and S4 methods for creating a \code{\link[=TextGrid-class]{TextGrid}}
#' object.
#'
#' @param textGrid A character vector
#' @param ... optional arguments for multiple dispatch (in development).
#' @param encoding The character encoding of the .TextGrid file. If \code{NULL},
#'   then the encoding of the file is guessed using \code{\link[readr]{guess_encoding}}.
#'   Plausible encodings that might be used by Praat are \code{"ASCII"},
#'   \code{"UTF-8"}, or \code{"UTF-16BE"} (if non-ASCII characters occur in
#'   the TextGrid).
#'
#' @return A \code{\link[=TextGrid-class]{TextGrid}} object.
#'
#' @section Details for signature \code{c(textGrid = 'character')}:
#'  If \code{textGrid} is a string (i.e., a character vector with
#'  \code{length(textGrid)=1}), then it is assumed that the \code{textGrid}
#'  argument is the path to a \code{.TextGrid} file. Otherwise, the
#'  \code{textGrid} argument is assumed to be a character vector whose
#'  elements are the lines of some \code{.TextGrid} file.
#'
#' @name TextGrid-constructor
#' @aliases TextGrid
#' @seealso \code{\link{TextGrid-class}}, \code{\link{TextGrid-accessors}}
#' @export
setGeneric(
  name = 'TextGrid',
  def  = function(textGrid, ...)
    standardGeneric('TextGrid')
)

#' @rdname TextGrid-constructor
#' @export
setMethod(
  f   = 'TextGrid',
  sig = c(textGrid = 'character'),
  def = function(textGrid, encoding = NULL) {
    if (length(textGrid) == 1) {
      if (is.null(encoding)) {
        encoding <- readr::guess_encoding(textGrid)[[1, "encoding"]]
      }
      .textgrid <- .ReadPraatFile(textGrid, encoding)
    } else {
      .textgrid <- textGrid
    }
    new(Class = 'TextGrid',
        .PraatText2TierObjects(.textgrid, pattern = "^( {4}|\t)item"),
        startTime = .TextGridTime(.textgrid, pattern = '^xmin'),
        endTime = .TextGridTime(.textgrid, pattern = '^xmax')
    )
  })
