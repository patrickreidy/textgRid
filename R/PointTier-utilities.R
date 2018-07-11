
# Extract the times of the points within a block of @praatText.
.PointTimes <- function(praatText, pattern = '^( {12}|\t{3})(time|number)') {
  .times <- .TierTimes(praatText, pattern)
  return(.times)
}


# Extract the labels of the points within a block of @praatText.
.PointLabels <- function(praatText, pattern = '^( {12}|\t{3})(text|mark)') {
  .labels <- .TierLabels(praatText, pattern)
  return(.labels)
}

