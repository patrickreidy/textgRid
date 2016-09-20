#' @include Tier-class.R
NULL


#' PointTier S4 class for Praat TextGrids.
#'
#' The \code{PointTier} class extends the \code{\link[=Tier-class]{Tier}} class.
#' A \code{PointTier} object describes a sequence of labeled points in time.
#' A point's label is typically the annotation of some event in waveform data
#' (e.g., the onset of voicing in speech data).
#'
#' @template Tier-class-slots
#' @slot times A numeric vector, the times of the points in the PointTier.
#' @slot labels A character vector, the labels of the points in the PointTier.
#' @seealso \code{\link{PointTier-constructor}},
#'   \code{\link{PointTier-accessors}}, \code{\link{TextGrid-class}},
#'   \code{\link{Tier-class}}
#' @name PointTier-class
#' @export
#' @importFrom methods setClass
setClass(
  Class = 'PointTier',
  contains = c('Tier'),
  slots    = c(times  = 'numeric',
               labels = 'character')
)
