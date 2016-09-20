#' @include Tier-class.R
NULL


#' IntervalTier S4 class for Praat TextGrids.
#'
#' The \code{IntervalTier} class extends the \code{\link[=Tier-class]{Tier}} class. An
#' \code{IntervalTier} object describes a sequence of non-overlapping labeled
#' intervals. An interval's label is typically the annotation of some contiguous
#' portion of waveform data (e.g., a phonetic segment or word in speech data).
#'
#' @template Tier-class-slots
#' @slot startTimes A numeric vector, the start times of the intervals in
#'   the IntervalTier.
#' @slot endTimes A numeric vector, the end times of the intervals in the
#'   IntervalTier.
#' @slot labels A character vector, the labels of the intervals in the
#'   IntervalTier.
#' @seealso \code{\link{IntervalTier-constructor}},
#'   \code{\link{IntervalTier-accessors}}, \code{\link{TextGrid-class}},
#'   \code{\link{Tier-class}}
#' @name IntervalTier-class
#' @export
#' @importFrom methods setClass
setClass(
  Class = 'IntervalTier',
  contains = c('Tier'),
  slots    = c(startTimes = 'numeric',
               endTimes   = 'numeric',
               labels     = 'character')
)
