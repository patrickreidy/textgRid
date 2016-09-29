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
as.data.frame.IntervalTier <- function(x, stringsAsFactors = FALSE) {
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
  row.names(.coerced) <- 1:nrow(.coerced)
  return(.coerced)
}


#' @rdname textgRid-as.data.frame
#' @export
as.data.frame.PointTier <- function(x, stringsAsFactors = FALSE) {
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
  row.names(.coerced) <- 1:nrow(.coerced)
  return(.coerced)
}


#' @rdname textgRid-as.data.frame
#' @export
as.data.frame.TextGrid <- function(x, stringsAsFactors = FALSE) {
  .coerced <- Reduce(
    rbind,
    Map(f = as.data.frame, x = x, stringsAsFactors = list(stringsAsFactors))
  )
  row.names(.coerced) <- 1:nrow(.coerced)
  return(.coerced)
}
