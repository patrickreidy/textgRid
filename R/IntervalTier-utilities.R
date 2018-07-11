
# Extract the start times of the intervals within a block of @praatText.
.IntervalStartTimes <- function(praatText, pattern = '^( {12}|\t{3})xmin') {
  .start_times <- .TierTimes(praatText, pattern)
  return(.start_times)
}


# Extract the end times of the intervals within a block of @praatText.
.IntervalEndTimes <- function(praatText, pattern = '^( {12}|\t{3})xmax') {
  .end_times <- .TierTimes(praatText, pattern)
  return(.end_times)
}


# Extract the text-mark values (interval labels) from a block of @praatText.
.IntervalLabels <- function(praatText, pattern = '^( {12}|\t{3})(text|mark)') {
  .labels <- .TierLabels(praatText, pattern)
  return(.labels)
}

