# Extract a @pattern from a string, @x.
.Extract <- function(x, pattern, miss = NA) {
  .extracted <- rep(miss, length(regexpr(pattern, x)))
  .matches   <- regexpr(pattern, x) != -1
  .extracted[.matches] <- regmatches(x, m = regexpr(pattern, x))
  return(.extracted)
}


# Count the number of tiers that occur within a block of @praatText.
.CountTiers <- function(praatText, pattern = '^ {4}item') {
  .count <- length(.TierStartLine(praatText, pattern))
  return(.count)
}


# Extract from a block of @praatText, the lines that match a @pattern.
.PraatLines <- function(praatText, pattern) {
  .lines_of_text <- grep(pattern = pattern, x = praatText, value = TRUE)
  return(.lines_of_text)
}


# Extract the classes of the tiers that occur within a block of @praatText.
.TierClass <- function(praatText, pattern = '^ {8}class') {
  .tier_classes <- .Extract(
    .Extract(.PraatLines(praatText, pattern),
                    pattern = '".*"'),
    pattern = '[^"]+'
  )
  return(.tier_classes)
}


# Find the line numbers that mark the ends of tiers within a block
# of @praatText.
.TierEndLine <- function(praatText, pattern = '^ {4}item') {
  .end_lines <- `[`(
    c(.TierStartLine(praatText, pattern) - 1, length(praatText)),
    2:(.CountTiers(praatText, pattern) + 1)
  )
  return(.end_lines)
}


# Generate a list of index-vectors. Each index-vector denotes the lines
# within a block of @praatText that are spanned by a tier.
.TierIndices <- function(praatText, pattern = '^ {4}item') {
  .tier_indices <- Map(
    `:`,
    .TierStartLine(praatText, pattern),
    .TierEndLine(praatText, pattern)
  )
  return(.tier_indices)
}


# Extract the names of the tiers that occur within a block of @praatText.
.TierName <- function(praatText, pattern = '^ {8}name') {
  .tier_names <- .Extract(
    .Extract(.PraatLines(praatText, pattern),
                    pattern = '".*"'),
    pattern = '[^"]+'
  )
  return(.tier_names)
}


# Extract the numbers of the tiers that occur within a block of @praatText.
.TierNumber <- function(praatText, pattern = '^ {4}item') {
  .tier_numbers <- .Extract(
    .Extract(.PraatLines(praatText, pattern),
                    pattern = '\\[.*\\]'),
    pattern = '[0123456789]+'
  )
  .tier_numbers <- as.integer(.tier_numbers)
  return(.tier_numbers)
}


# Find the line numbers that mark the beginnings of tiers within
# a block of @praatText.
.TierStartLine <- function(praatText, pattern = '^ {4}item') {
  .start_lines <- grep(pattern = pattern, x = praatText)
  return(.start_lines)
}


# Extract the text information (e.g., point marks or interval texts) from
# a block of @praatText.
.TierLabels <- function(praatText, pattern) {
  .texts <- .Extract(
    .Extract(.PraatLines(praatText, pattern),
                    pattern = '".*"'),
    pattern = '[^"]+'
  )
  .texts <- as.character(.texts)
  return(.texts)
}


# Extract the time information (e.g., point times or interval xmins or xmaxs)
# from a block of @praatText.
.TierTimes <- function(praatText, pattern) {
  .times <- .Extract(.PraatLines(praatText, pattern),
                            pattern = '[0123456789]+\\.?[0123456789]*'
  )
  .times <- as.numeric(.times)
  return(.times)
}

