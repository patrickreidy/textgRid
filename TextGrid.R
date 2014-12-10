# Author:       Patrick Reidy
# Email:        <patrick.francis.reidy@gmail.com>
# Affiliations: The Ohio State University, Department of Linguistics
# Date:         May 13, 2014
# Purpose:      Define the TextGrid S4 class and methods for manipulating
#               objects of that class.
# Reference:    <www.praat.org>





################################################################################
# Class definition                                                             #
################################################################################

setClass(
  Class = 'TextGrid',
  contains = c('list'),
  slots    = c(textGridXMin = 'numeric',
               textGridXMax = 'numeric')
  )





################################################################################
# TextGrid object construction                                                 #
################################################################################

#############################################################################
#  Utility functions                                                        #
#############################################################################

.ReadPraatText <- function(tgFilePath)
  readLines(tgFilePath)

.TextGridTime <- function(praatText, tgTimeRegEx)
  as.numeric(
    .ExtractRegExpr(.PraatLines(praatText, tgTimeRegEx),
                    pattern = '[0123456789]+\\.?[0123456789]*'
    ))

.SplitPraatTextIntoTiers <- function(praatText, tierRegEx = '^ {4}item')
  Map(
    `[`,
    rep(list(praatText), .CountTiers(praatText, tierRegEx)),
    .TierIndices(praatText, tierRegEx)
    )

.TierText2TierObject <- function(tierText, tierClass)
  if (tierClass == 'TextTier') TextTier(tierText) else IntervalTier(tierText)

.PraatText2TierObjects <- function(praatText, tierRegEx = '^ {4}item') {
  tier.text    <- .SplitPraatTextIntoTiers(praatText, tierRegEx)
  tier.classes <- .TierClass(praatText)
  tier.objects <- Map(.TierText2TierObject, tier.text, tier.classes)
  names(tier.objects) <- .TierName(praatText)
  return(tier.objects)
}

#############################################################################
#  Generic constructor function                                             #
#############################################################################

setGeneric(
  name = 'TextGrid',
  def  = function(textGridData, textGridXMin, textGridXMax)
    standardGeneric('TextGrid')
)

setMethod(
  f   = 'TextGrid',
  sig = c(textGridData = 'character',
          textGridXMin = 'missing', textGridXMax = 'missing'),
  def = function(textGridData) {
    if (length(textGridData) == 1) 
      textGridData <- .ReadPraatText(textGridData)
    new(Class = 'TextGrid',
        .PraatText2TierObjects(textGridData),
        textGridXMin = .TextGridTime(textGridData, tgTimeRegEx = '^xmin'),
        textGridXMax = .TextGridTime(textGridData, tgTimeRegEx = '^xmax')
        )
    })





################################################################################
# Methods                                                                      #
################################################################################

#############################################################################
#  findIntervals                                              findIntervals #
#############################################################################

if (! isGeneric('findIntervals'))
  setGeneric(
    name = 'findIntervals',
    def  = function(textGrid, intervalTier, pattern, label, xmin, xmax, time)
      standardGeneric('findIntervals')
    )
setMethod(
  f   = 'findIntervals',
  sig = c(textGrid = 'TextGrid', intervalTier = 'ANY', 
          pattern = 'character', label = 'missing',
          xmin = 'missing', xmax = 'missing', time = 'missing'),
  def = function(textGrid, intervalTier, pattern)
    grep(pattern = pattern, x = intervalLabels(textGrid[[intervalTier]]))
  )
setMethod(
  f   = 'findIntervals',
  sig = c(textGrid = 'TextGrid', intervalTier = 'ANY',
          pattern = 'missing', label = 'character',
          xmin = 'missing', xmax = 'missing', time = 'missing'),
  def = function(textGrid, intervalTier, label)
    which(intervalLabels(textGrid[[intervalTier]]) == label)
  )
setMethod(
  f   = 'findIntervals',
  sig = c(textGrid = 'TextGrid', intervalTier = 'ANY',
          pattern = 'missing', label = 'missing',
          xmin = 'numeric', xmax = 'numeric', time = 'missing'),
  def = function(textGrid, intervalTier, xmin, xmax)
    which(intervalXMins(textGrid[[intervalTier]]) < xmax &
            intervalXMaxs(textGrid[[intervalTier]]) > xmin)
  )
setMethod(
  f   = 'findIntervals',
  sig = c(textGrid = 'TextGrid', intervalTier = 'ANY',
          pattern = 'missing', label = 'missing',
          xmin = 'missing', xmax = 'missing', time = 'numeric'),
  def = function(textGrid, intervalTier, time) {
    .intervalAtTime <- function(textGrid, intervalTier, time)
      which(intervalXMins(textGrid[[intervalTier]]) <= time &
              intervalXMaxs(textGrid[[intervalTier]]) >= time)
    Reduce(c, 
           Map(.intervalAtTime, 
               textGrid = list(textGrid),
               intervalTier = intervalTier,
               time = time))
  })

#############################################################################
#  findPoints                                                    findPoints #
#############################################################################

if (! isGeneric('findPoints'))
  setGeneric(
    name = 'findPoints',
    def  = function(textGrid, textTier, xmin, xmax)
      standardGeneric('findPoints')
    )
setMethod(
  f   = 'findPoints',
  sig = c(textGrid = 'TextGrid', textTier = 'ANY',
          xmin = 'numeric', xmax = 'numeric'),
  def = function(textGrid, textTier, xmin, xmax)
    which(xmin <= pointTimes(textGrid[[textTier]]) &
            pointTimes(textGrid[[textTier]]) <= xmax)
  )


#############################################################################
#  @textGridXMin get-method                                   @textGridXMin #
#############################################################################

# textGridXMin
if (! isGeneric('textGridXMin'))
  setGeneric(
    name = 'textGridXMin', 
    def  = function(x) 
      standardGeneric('textGridXMin')
    )
setMethod(
  f   = 'textGridXMin', 
  sig = c(x = 'TextGrid'), 
  def = function(x) 
    x@textGridXMin
  )

# startTime
if (! isGeneric('startTime'))
  setGeneric(
    name = 'startTime',
    def  = function(x)
      standardGeneric('startTime')
    )
setMethod(
  f   = 'startTime',
  sig = c(x = 'TextGrid'),
  def = function(x)
    textGridXMin(x)
  )

#############################################################################
#  @textGridXMax get-method                                   @textGridXMax #
#############################################################################

# textGridXMax
if (! isGeneric('textGridXMax'))
  setGeneric(
    name = 'textGridXMax', 
    def  = function(x) 
      standardGeneric('textGridXMax')
    )
setMethod(
  f   = 'textGridXMax', 
  sig = c(x = 'TextGrid'), 
  def = function(x) 
    x@textGridXMax
  )

# endTime
if (! isGeneric('endTime'))
  setGeneric(
    name = 'endTime',
    def  = function(x)
      standardGeneric('endTime')
    )
setMethod(
  f   = 'endTime',
  sig = c(x = 'TextGrid'),
  def = function(x)
    textGridXMax(x)
  )
