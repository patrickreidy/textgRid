#' @include Tier-class.R IntervalTier-class.R PointTier-class.R TextGrid-class.R
NULL

#' Length of an IntervalTier or PointTier
#'
#' Get the number of intervals on an \code{IntervalTier} or the number of points
#' on a \code{PointTier}.
#'
#' \code{length.IntervalTier()} checks that the vectors stored in the
#' \code{startTimes}, \code{endTimes}, and \code{labels} slots of the
#' \code{IntervalTier} object all have the same length. If so, the length
#' of the \code{labels}-vector is returned; otherwise, \code{NULL} is returned.
#'
#' \code{length.PointTier()} checks that the vectors stored in the
#' \code{times} and \code{labels} slots of the \code{PointTier} object both
#' have the same length. If so, the length of the \code{labels}-vector is
#' returned; otherwise, \code{NULL} is returned.
#'
#' @param x An \code{IntervalTier} or \code{PointTier} object.
#'
#' @return A \code{numeric}. The number of intervals or points on \code{x}.
#'
#' @name textgRid-length
#' @aliases length.IntervalTier length.PointTier
NULL


#' @rdname textgRid-length
#' @export
length.IntervalTier <- function(x) {
  if (length(intervalLabels(x)) == length(intervalStartTimes(x)) &
      length(intervalLabels(x)) == length(intervalEndTimes(x))) {
    .length <- length(intervalLabels(x))
  } else {
    .length <- NULL
  }
  return(.length)
}


#' @rdname textgRid-length
#' @export
length.PointTier <- function(x) {
  if (length(pointLabels(x)) == length(pointTimes(x))) {
    .length <- length(pointLabels(x))
  } else {
    .length <- NULL
  }
  return(.length)
}


