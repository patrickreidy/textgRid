#' @include Tier-class.R IntervalTier-class.R PointTier-class.R TextGrid-class.R
NULL


#' Coerce to a data.frame.
#'
#' Coerce an \code{IntervalTier}, \code{PointTier}, or \code{TextGrid} object
#' to a \code{data.frame}.
#'
#' \code{IntervalTier}s and \code{PointTier}s are coerced by passing them to
#' \code{findIntervals()} and \code{findPoints()}, respectively. Only intervals
#' and points that have contentful, non-empty labels are returned after coercion.
#'
#' @param x An \code{IntervalTier}, \code{PointTier}, or \code{TextGrid} object.
#' @param row.names \code{NULL} or a character vector giving the row names for
#'   the returned \code{data.frame}. If \code{NULL} (the default), the rows
#'   of the returned \code{data.frame} are named numerically beginning at 1.
#' @param optional A logical, default is \code{FALSE}.
#'   If \code{TRUE}, setting row names and converting column names is optional.
#' @param ... Additional optional arguments. (Only here for consistency with
#'   the generic.)
#' @param stringsAsFactors A logical, default is \code{FALSE}.
#' @return A \code{data.frame} object whose rows represent the contentful
#'   intervals or points within \code{object}, and whose columns are:
#'   \code{TierNumber}, \code{TierName}, \code{TierType},
#'   \code{Index}, \code{StartTime}, \code{EndTime}, \code{Label}.
#' @name textgRid-as.data.frame
#' @aliases as.data.frame.IntervalTier as.data.frame.PointTier as.data.frame.TextGrid
NULL


#' @rdname textgRid-as.data.frame
#' @export
as.data.frame.IntervalTier <- function(x, row.names = NULL, optional = FALSE, ..., stringsAsFactors = FALSE) {
  .intervals <- findIntervals(tier = x, stringsAsFactors = stringsAsFactors)
  .tier_data <- data.frame(
    TierNumber = tierNumber(x),
    TierName   = tierName(x),
    TierType   = as.character(class(x)),
    stringsAsFactors = stringsAsFactors
  )
  .coerced   <- cbind(
    .tier_data[rep(1, times = nrow(.intervals)), ],
    .intervals
  )
  if (is.null(row.names)) {
    row.names(.coerced) <- seq_len(nrow(.coerced))
  } else {
    row.names(.coerced) <- row.names
  }
  return(.coerced)
}


#' @rdname textgRid-as.data.frame
#' @export
as.data.frame.PointTier <- function(x, row.names = NULL, optional = FALSE, ..., stringsAsFactors = FALSE) {
  .points <- with(findPoints(tier = x), {
    data.frame(
      Index     = Index,
      StartTime = Time,
      EndTime   = Time,
      Label     = Label,
      stringsAsFactors = stringsAsFactors
    )
  })
  .tier_data <- data.frame(
    TierNumber = tierNumber(x),
    TierName   = tierName(x),
    TierType   = as.character(class(x)),
    stringsAsFactors = stringsAsFactors
  )
  .coerced   <- cbind(
    .tier_data[rep(1, times = nrow(.points)), ],
    .points
  )
  if (is.null(row.names)) {
    row.names(.coerced) <- seq_len(nrow(.coerced))
  } else {
    row.names(.coerced) <- row.names
  }
  return(.coerced)
}


#' @rdname textgRid-as.data.frame
#' @export
as.data.frame.TextGrid <- function(x, row.names = NULL, optional = FALSE, ..., stringsAsFactors = FALSE) {
  .coerced <- Reduce(
    rbind,
    Map(f = as.data.frame, x = x, stringsAsFactors = list(stringsAsFactors))
  )
  if (is.null(row.names)) {
    row.names(.coerced) <- seq_len(nrow(.coerced))
  } else {
    row.names(.coerced) <- row.names
  }
  return(.coerced)
}
