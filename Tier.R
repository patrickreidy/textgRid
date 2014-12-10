# Author:       Patrick Reidy
# Email:        <patrick.francis.reidy@gmail.com>
# Affiliations: The Ohio State University, Department of Linguistics
# Date:         May 8, 2014
# Purpose:      Define the Tier S4 class and methods for manipulating objects
#               of that class.
# Reference:    <www.praat.org>





################################################################################
# General utility functions                                                    #
################################################################################

# Extracting a regular expression from a string.
if (! exists('.ExtractRegExpr'))
  .ExtractRegExpr <- function(x, pattern, miss = NA) {
    extracted <- rep(miss, length(regexpr(pattern, x)))
    matches   <- regexpr(pattern, x) != -1
    extracted[matches] <- regmatches(x, m = regexpr(pattern, x))
    return(extracted)
  }

# Extracting the lines of Praat text that match a given regular expression.
.PraatLines <- function(praatText, lineRegEx)
  grep(pat = lineRegEx, x = praatText, val = TRUE)

# Count the number of tiers that are defined in Praat text
.CountTiers <- function(praatText, tierRegEx = '^ {4}item')
  length(.TierStartLine(praatText, tierRegEx))

# Find the line numbers that mark the beginnings of tiers in Praat text.
.TierStartLine <- function(praatText, tierRegEx = '^ {4}item')
  grep(pattern = tierRegEx, x = praatText)

# Find the lines numbers that mark the ends of tiers in Praat text.
.TierEndLine <- function(praatText, tierRegEx = '^ {4}item')
  `[`(
    c(.TierStartLine(praatText, tierRegEx) - 1, length(praatText)), # vector
    2:(.CountTiers(praatText, tierRegEx) + 1)                        # indices
  )

# Generate a list of numeric vectors, each of which is the sequence of 
# numbers designating which sequences of lines of Praat text define which 
# tiers.
.TierIndices <- function(praatText, tierRegEx = '^ {4}item')
  Map(
    `:`, 
    .TierStartLine(praatText, tierRegEx),
    .TierEndLine(praatText, tierRegEx)
    )

# Extract the classes of the tiers from lines of Praat text that define one
# or more tiers.
.TierClass <- function(praatText, tierClassRegEx = '^ {8}class')
  .ExtractRegExpr(
    .ExtractRegExpr(.PraatLines(praatText, tierClassRegEx),
                    pattern = '".*"'),
    pattern = '[^"]+'
    )


# Extract the names of the tiers from lines of Praat text that define one or
# more tiers.
.TierName <- function(praatText, tierNameRegEx = '^ {8}name')
  .ExtractRegExpr(
    .ExtractRegExpr(.PraatLines(praatText, tierNameRegEx),
                    pattern = '".*"'),
    pattern = '[^"]+'
    )

# Extract the numbers of the tiers from the lines of Praat text that define one
# or more tiers
.TierNumber <- function(praatText, tierNumberRegEx = '^ {4}item')
  as.numeric(
    .ExtractRegExpr(
      .ExtractRegExpr(.PraatLines(praatText, tierNumberRegEx),
                      pattern = '\\[.*\\]'),
      pattern = '[0123456789]+'
      ))

# Extract the time information (e.g., point times or interval xmins or xmaxs)
# from the lines of Praat text that define it.
.TierTimes <- function(praatText, timeRegEx)
  as.numeric(
    .ExtractRegExpr(.PraatLines(praatText, timeRegEx),
                    pattern = '[0123456789]+\\.?[0123456789]*'
                    ))

# Extract the text information (e.g., point marks or interval texts) from the
# lines of Praat text that define it.
.TierTexts <- function(praatText, textRegEx)
  as.character(
    .ExtractRegExpr(
      .ExtractRegExpr(.PraatLines(praatText, textRegEx),
                      pattern = '".*"'),
      pattern = '[^"]+'
      ))





################################################################################
#   Class definition                                                           #
################################################################################

# The Tier class generalizes Praat's TextTier and IntervalTier types of object,
# both of which have the following types of information in common:
#   1) a Tier name;
#   2) a Tier number;
#   3) a Tier class, i.e. either 'TextTier' or 'IntervalTier';
#   4) a start time;
#   5) an end time; and
#   6) a size.
# Of these six types of information, the Tier class only formally includes 
# two as formal attributes (slots):
#   a) @tierName
#   b) @tierNumber
# The other four types of information are omitted for the following reasons:
#   3) class      -- automatic as an object of type Tier;
#   4) start time -- stored at the TextGrid level;
#   5) end time   -- stored at the TextGrid level;
#   6) size       -- easier to deduce on the fly.

setClass(
  Class = 'Tier',
  contains = c(),
  slots    = c(tierName   = 'character',
               tierNumber = 'numeric')
  )





################################################################################
# Methods                                                                      #
################################################################################

#############################################################################
#  @tierName get-methods                                          @tierName #
#############################################################################

# tierName
if (! isGeneric('tierName'))
  setGeneric(
    name = 'tierName', 
    def  = function(x) 
      standardGeneric('tierName')
    )
setMethod(
  f   = 'tierName', 
  sig = c(x = 'Tier'), 
  def = function(x) 
    x@tierName
  )

# name
if (! isGeneric('name'))
  setGeneric(
    name = 'name',
    def  = function(x)
      standardGeneric('name')
    )
setMethod(
  f   = 'name',
  sig = c(x = 'Tier'),
  def = function(x)
    tierName(x)
  )

#############################################################################
# @tierNumber get-methods                                       @tierNumber #
#############################################################################

# tierNumber
if (! isGeneric('tierNumber'))
  setGeneric(
    name = 'tierNumber',
    def  = function(x)
      standardGeneric('tierNumber')
    )
setMethod(
  f   = 'tierNumber',
  sig = c(x = 'Tier'),
  def = function(x)
    x@tierNumber
  )

# number
if (! isGeneric('number'))
  setGeneric(
    name = 'number',
    def  = function(x)
      standardGeneric('number')
    )
setMethod(
  f   = 'number',
  sig = c(x = 'Tier'),
  def = function(x)
    tierNumber(x)
  )

#############################################################################
# tierSize                                                         tierSize #
#############################################################################

# size
if (! isGeneric('size'))
  setGeneric(
    name = 'size',
    def  = function(x)
      standardGeneric('size')
  )
setMethod(
  f   = 'size',
  sig = c(x = 'Tier'),
  def = function(x)
    length(x)
)

# tierSize
if (! isGeneric('tierSize'))
  setGeneric(
    name = 'tierSize',
    def  = function(x)
      standardGeneric('tierSize')
  )
setMethod(
  f   = 'tierSize',
  sig = c(x = 'Tier'),
  def = function(x)
    length(x)
)
