#' @include Tier-class.R IntervalTier-class.R PointTier-class.R TextGrid-class.R
NULL


#' Write Praat-compatible TextGrid.
#' 
#' Convert a \code{TextGrid} object to a Praat-compatible character string and 
#' (optionally) write it to a file.
#' 
#' @param x A \code{TextGrid} object to be written. 
#' @param path Either a character string naming a file to write to, a connection 
#' open for writing, or \code{NULL} (default) for no output. When writing to 
#' file or connection, \code{path} is passed on as the \code{con} argument to 
#' \code{\link{writeLines}}
#' @param ... Additional arguments passed on to \code{\link{writeLines}} 
#' when writing to a file or connection.
#' @return A character vector, Each element is one row of the TextGrid file.
#' 
#' @seealso \code{\link{TextGrid-class}}
#' @name writeTextGrid
#' @export
writeTextGrid <- function(x, path = NULL, ...)  {
  .tiers <- x@.Data
  .nTiers <- length(.tiers)

  .header <- c(
            'File type = "ooTextFile"',
            'Object class = "TextGrid"',
            '',
    sprintf('xmin = %g', textGridStartTime(x)),
    sprintf('xmax = %g', textGridEndTime(x)),
            'tiers? <exists>',
    sprintf('size = %g', .nTiers),
            'item []:'
  )
  .tiers <- sapply(.tiers, function(t) {
    if (inherits(t, "IntervalTier")) { 
      return(writeIntervalTier(t)) 
    } else if (inherits(t, "PointTier")) {
      return(writePointTier(t))
    }
  })
  
  .out <- c(.header, unlist(.tiers))
  if (!is.null(path)) {
    writeLines(.out, con = path, ...) 
    return(invisible(.out))
  } else {
    return(.out)
  }
}


# convert IntervalTier object into a Praat-compatible character vector and 
# (optionally) write it to a file.
writeIntervalTier <- function(x, path = NULL, ...) {
  .tierStart <- min(intervalStartTimes(x))
  .tierEnd <- max(intervalEndTimes(x))
  .labels <- replace(intervalLabels(x), is.na(intervalLabels(x)), "")
  .tierLen <- length(.labels)
  
  .header <- c(
    sprintf('    item[%d]:', tierNumber(x)),
            '        class = "IntervalTier"',
    sprintf('        name = "%s"', tierName(x)),
    sprintf('        xmin = %g', .tierStart),
    sprintf('        xmax = %g', .tierEnd),
    sprintf('        intervals: size = %d', .tierLen)
  )
  .annotations <- mapply(function(startTime, endTime, label) {
    c(sprintf('            xmin = %g', startTime),
      sprintf('            xmax = %g', endTime),
      sprintf('            text = "%s"', label))
  }, intervalStartTimes(x), intervalEndTimes(x), .labels, SIMPLIFY = T)
  
  .out <- c(.header, .annotations)
  if (!is.null(path)) {
    writeLines(.out, con = path, ...) 
    return(invisible(.out))
  } else {
    return(.out)
  }
}


# convert PointTier object into a Praat-compatible character vector and 
# (optionally) write it to a file.
writePointTier <- function(x, path = NULL, ...) {
  .tierStart <- min(pointTimes(x))
  .tierEnd <- max(pointTimes(x))
  .labels <- replace(pointLabels(x), is.na(pointLabels(x)), "")
  .tierLen <- length(.labels)
  
  .header <- c(
    sprintf('    item[%d]:', tierNumber(x)),
            '        class = "TextTier"',
    sprintf('        name = "%s"', tierName(x)),
    sprintf('        xmin = %g', .tierStart),
    sprintf('        xmax = %g', .tierEnd),
    sprintf('        points: size = %d', .tierLen)
  )
  .annotations <- mapply(function(time, label) {
    c(sprintf('            number = %g', time),
      sprintf('            mark = "%s"', label))
  }, pointTimes(x), .labels, SIMPLIFY = T)
  
  .out <- c(.header, .annotations)
  if (!is.null(path)) {
    writeLines(.out, con = path, ...) 
    return(invisible(.out))
  } else {
    return(.out)
  }
}