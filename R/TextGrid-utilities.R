#' @include Tier-class.R IntervalTier-class.R PointTier-class.R
NULL


# Read the contents of @file, returning a character vector whose elements are
# the lines of @file.
.ReadPraatFile <- function(file, encoding) {
  .con <- file(file, open = "rt", encoding = encoding)
  .praat_text <- readLines(.con)
  close(.con)
  return(.praat_text)
}



# For extracting the start time and end time from the header.
.TextGridTime <- function(praatText, pattern) {
  .time <- .Extract(.PraatLines(praatText, pattern),
                    pattern = '[0123456789]+\\.?[0123456789]*')
  .time <- as.numeric(.time)
  return(.time)
}


# Partition a block of @praatText into a list of sub-blocks, each sub-block
# corresponding to the lines that define a tier within @praatText.
.SplitPraatTextIntoTiers <- function(praatText, pattern = '^( {4}|\t)item') {
  .tier_blocks <- Map(
    `[`,
    rep(list(praatText), .CountTiers(praatText, pattern)),
    .TierIndices(praatText, pattern)
  )
  return(.tier_blocks)
}


# Initialize an IntervalTier or a PointTier object from a block of @praatText.
# Controlled by @tierClass, which is either 'PointTier' or 'IntervalTier'.
.TierText2TierObject <- function(praatText, tierClass) {
  if (tolower(tierClass) == 'intervaltier') {
    .tier_object <- IntervalTier(praatText)
  } else if (tolower(tierClass) == 'texttier') {
    .tier_object <- PointTier(praatText)
  } else {
    .tier_object <- NULL
  }
  return(.tier_object)
}


# The real engine for creating TextGrid objects.
.PraatText2TierObjects <- function(praatText, pattern = '^( {4}|\t)item') {
  .tier_text    <- .SplitPraatTextIntoTiers(praatText, pattern)
  .tier_classes <- .TierClass(praatText)
  .tier_objects <- Map(.TierText2TierObject, .tier_text, .tier_classes)
  names(.tier_objects) <- .TierName(praatText)
  return(.tier_objects)
}
