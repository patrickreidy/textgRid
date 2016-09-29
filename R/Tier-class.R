
#' Tier S4 class for Praat TextGrids.
#'
#' The \code{Tier} class is extended by the \code{\link[=PointTier-class]{PointTier}}
#' and \code{\link[=IntervalTier-class]{IntervalTier}} classes. As such, the
#' \code{Tier} class encapsulates only very general information that is common
#' to both subtypes of tier-like object.
#'
#' @template Tier-class-slots
#' @seealso \code{\link{IntervalTier-class}}, \code{\link{PointTier-class}},
#'   \code{\link{TextGrid-class}}, \code{\link{Tier-accessors}}
#' @name Tier-class
#' @aliases Tier
#' @export
#' @importFrom methods setClass
setClass(
  Class = 'Tier',
  contains = c(),
  slots    = c(name   = 'character',
               number = 'integer')
)
