#' @include Tier-class.R IntervalTier-class.R PointTier-class.R TextGrid-class.R
NULL


#' Find points within a PointTier.
#'
#' Find points according to various search criteria: e.g., that occur within a
#' time range, whose labels match a pattern.
#'
#' @param tier A \code{PointTier} object.
#' @param pattern A regular expression for matching point labels.
#'   Default is \code{'*'} so that the search finds all points within
#'   \code{[from, to]}.
#' @param from A numeric, the earliest time from which to search for points.
#'   Default is \code{-Inf} so that the search includes the start of \code{tier}.
#' @param to A numeric, the latest time to which to search for points.
#'   Default is \code{Inf} so that the search includes the end of \code{tier}.
#' @param ... optional arguments passed to \code{grep}.
#' @return A \code{data.frame} whose rows correspond to the points found
#'   according to the search criteria, and whose columns are:
#'   \code{$Index}, \code{$Time}, \code{$Label}.
#' @name findPoints
#' @seealso \code{\link{PointTier-class}}, \code{\link{grep}}
#' @export
findPoints <- function(tier, pattern = '*', from = -Inf, to = Inf, ...) {
  .within_interval <- which(from <= pointTimes(tier) & pointTimes(tier) <= to)
  .match_label     <- grep(pattern = pattern, x = pointLabels(tier), ...)
  .indices         <- intersect(.within_interval, .match_label)
  .points          <- data.frame(
    Index = .indices,
    Time  = pointTimes(tier)[.indices],
    Label = pointLabels(tier)[.indices]
  )
  return(.points)
}



#' Find intervals within an IntervalTier.
#'
#' Find intervals according to various search criteria.
#'
#' Default behavior of \code{findIntervals} is to search for intervals within
#' \code{[from, to]}. If the \code{at} argument is a non-empty numeric vector,
#' then this default behavior is overridden, and the \code{tier} is searched
#' only at the time given by \code{at}.
#'
#' @param tier An \code{IntervalTier} object.
#' @param pattern A regular expression for matching interval labels.
#'   Default is \code{'*'} so that the search finds all intervals within
#'   \code{[from, to]}.
#' @param from A numeric, the earliest time from which to search for intervals.
#'   Default is \code{-Inf} so that the search includes the start of \code{tier}.
#' @param to A numeric, the latest time to which to search for intervals.
#'   Default is \code{Inf} so that the search includes the end of \code{tier}.
#' @param at A numeric, an exact time at which to find intervals.
#'   Default is \code{numeric()} so that intervals are searched within
#'   \code{[from, to]}.
#' @param ... optional arguments passed to \code{grep}.
#' @return A \code{data.frame} whose rows correspond to the intervals found
#'   according to the search criteria, and whose columns are:
#'   \code{$Index}, \code{$StartTime}, \code{$EndTime}, \code{$Label},
#' @name findIntervals
#' @seealso \code{\link{IntervalTier-class}}, \code{\link{grep}}
#' @export
findIntervals <- function(tier, pattern = '*', from = -Inf, to = Inf, at = numeric(), ...) {
  if (length(at) > 0) {
    .match_time <- which(
      intervalStartTimes(tier) <= at &
        at <= intervalEndTimes(tier)
    )
  } else {
    .match_time <- which(
      intervalStartTimes(tier) < to &
        intervalEndTimes(tier) > from
    )
  }
  .match_label <- grep(pattern = pattern, x = intervalLabels(tier), ...)
  .indices     <- intersect(.match_time, .match_label)
  .intervals   <- data.frame(
    Index     = .indices,
    StartTime = intervalStartTimes(tier)[.indices],
    EndTime   = intervalEndTimes(tier)[.indices],
    Label     = intervalLabels(tier)[.indices]
  )
  return(.intervals)
}
