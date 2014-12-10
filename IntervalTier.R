# Author:       Patrick Reidy
# Email:        <patrick.francis.reidy@gmail.com>
# Affiliations: The Ohio State University, Department of Linguistics
# Date:         May 13, 2014
# Purpose:      Define the IntervalTier S4 class and methods for manipulating
#               objects of that class.
# Reference:    <www.praat.org>





################################################################################
# Class definition                                                             #
################################################################################

setClass(
  Class = 'IntervalTier',
  contains = c('Tier'),
  slots    = c(intervalXMins = 'numeric',
               intervalXMaxs = 'numeric',
               intervalTexts = 'character')
  )





################################################################################
# IntervalTier object construction                                             #
################################################################################

#############################################################################
#  Utility functions                                                        #
#############################################################################
#  Note: These functions are defined in terms of .TierTimes and .TierTexts,
#        which are both defined in the 'General utility functions' section
#        of Tier.r.

.IntervalXMins <- function(praatText, intXMinsRegEx = '^ {12}xmin')
  .TierTimes(praatText, timeRegEx = intXMinsRegEx)

.IntervalXMaxs <- function(praatText, intXMaxsRegEx = '^ {12}xmax')
  .TierTimes(praatText, timeRegEx = intXMaxsRegEx)

.IntervalTexts <- function(praatText, intTextsRegEx = '^ {12}(text|mark)')
  .TierTexts(praatText, textRegEx = intTextsRegEx)

#############################################################################
#  Generic constructor function                                             #
#############################################################################

setGeneric(
  name = 'IntervalTier',
  def  = function(tierData, tierName, tierNumber, 
                  intervalXMins, intervalXMaxs, intervalTexts)
    standardGeneric('IntervalTier')
  )

setMethod(
  f   = 'IntervalTier',
  sig = c(tierData = 'character', 
          tierName = 'missing', tierNumber = 'missing',
          intervalXMins = 'missing', intervalXMaxs = 'missing',
          intervalTexts = 'missing'),
  def = function(tierData)
    # Initialize the IntervalTier object.
    new(Class = 'IntervalTier',
        tierName      = .TierName(tierData),
        tierNumber    = .TierNumber(tierData),
        intervalXMins = .IntervalXMins(tierData),
        intervalXMaxs = .IntervalXMaxs(tierData),
        intervalTexts = .IntervalTexts(tierData)
        )
  )





################################################################################
# Methods                                                                      #
################################################################################

#############################################################################
#  @intervalTexts get-method                                 @intervalTexts #
#############################################################################

# intervalTexts
if (! isGeneric('intervalTexts'))
  setGeneric(
    name = 'intervalTexts', 
    def  = function(x) 
      standardGeneric('intervalTexts')
  )
setMethod(
  f   = 'intervalTexts', 
  sig = c(x = 'IntervalTier'), 
  def = function(x) 
    x@intervalTexts
)

# intervalLabels
if (! isGeneric('intervalLabels'))
  setGeneric(
    name = 'intervalLabels',
    def  = function(x)
      standardGeneric('intervalLabels')
    )
setMethod(
  f   = 'intervalLabels',
  sig = c(x = 'IntervalTier'),
  def = function(x)
    intervalTexts(x)
  )

#############################################################################
#  @intervalXMaxs get-method                                 @intervalXMaxs #
#############################################################################

# intervalXMaxs
if (! isGeneric('intervalXMaxs'))
  setGeneric(
    name = 'intervalXMaxs', 
    def  = function(x) 
      standardGeneric('intervalXMaxs')
  )
setMethod(
  f   = 'intervalXMaxs', 
  sig = c(x = 'IntervalTier'), 
  def = function(x) 
    x@intervalXMaxs
)

#############################################################################
#  @intervalXMins get-method                                 @intervalXMins #
#############################################################################

# intervalXMins
if (! isGeneric('intervalXMins'))
  setGeneric(
    name = 'intervalXMins', 
    def  = function(x) 
      standardGeneric('intervalXMins')
  )
setMethod(
  f   = 'intervalXMins', 
  sig = c(x = 'IntervalTier'), 
  def = function(x) 
    x@intervalXMins
)

#############################################################################
#  length                                                            length #
#############################################################################

# length
setMethod(
  f   = 'length',
  sig = c(x = 'IntervalTier'),
  def = function(x)
    length(intervalTexts(x))
)

#############################################################################
#  show                                                                show #
#############################################################################

setMethod(
  f   = 'show',
  sig = c(object = 'IntervalTier'),
  def = function(object) {
    message('<<<>>> IntervalTier <<<>>>')
    message('')
    message(sprintf('Tier no.:  %d', tierNumber(object)))
    message(sprintf('Tier name: %s', tierName(object)))
    message(sprintf('Tier size: %d', tierSize(object)))
    message('')
    message('Intervals:')
    precis  <- 5
    xMinWidth <- max(nchar(floor(intervalXMins(object)))) + precis + 1
    xMaxWidth <- max(nchar(floor(intervalXMaxs(object)))) + precis + 1
    xMinFmt <- paste('%', xMinWidth, '.', precis, 'f', sep = '')
    xMaxFmt <- paste('%', xMaxWidth, '.', precis, 'f', sep = '')
    lineFmt <- paste(xMinFmt, '---', xMaxFmt, '%s')
    for (p in seq_along(object)) {
      message(sprintf(lineFmt, 
                      intervalXMins(object)[p], 
                      intervalXMaxs(object)[p],
                      ifelse(!is.na(intervalTexts(object)), intervalTexts(object), '')[p]))
    }
    })
