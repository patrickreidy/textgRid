#' @include TextGrid-class.R
NULL

#' Access the slots of TextGrid objects.
#'
#' Functions for accessing the slots of a \code{\link[=TextGrid-class]{TextGrid}}
#' object.
#' @param textGrid An \code{\link[=TextGrid-class]{TextGrid}} object.
#' @name TextGrid-accessors
#' @seealso \code{\link{TextGrid-class}},
#'   \code{\link{TextGrid-constructor}}
NULL


#' @rdname TextGrid-accessors
#' @export
textGridStartTime <- function(textGrid) {
  textGrid@startTime
}


#' @rdname TextGrid-accessors
#' @export
textGridEndTime <- function(textGrid) {
  textGrid@endTime
}

