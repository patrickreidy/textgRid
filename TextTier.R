# Author:       Patrick Reidy
# Email:        <patrick.francis.reidy@gmail.com>
# Affiliations: The Ohio State University, Department of Linguistics
# Date:         May 13, 2014
# Purpose:      Define the TextTier S4 class and methods for manipulating
#               objects of that class.
# Reference:    <www.praat.org>





################################################################################
# Class definition                                                             #
################################################################################

setClass(
  Class = 'TextTier',
  contains = c('Tier'),
  slots    = c(pointTimes = 'numeric',
               pointMarks = 'character')
  )





################################################################################
# TextTier object construction                                                 #
################################################################################

#############################################################################
#  Utility functions                                                        #
#############################################################################
#  Note: These functions are defined in terms of .TierTimes and .TierTexts,
#         which are both defined in the 'General utility functions' section
#         of Tier.r.

.PointTimes <- function(praatText, pointTimesRegEx = '^ {12}(time|number)')
  .TierTimes(praatText, timeRegEx = pointTimesRegEx)

.PointMarks <- function(praatText, pointMarksRegEx = '^ {12}(text|mark)')
  .TierTexts(praatText, textRegEx = pointMarksRegEx)

#############################################################################
#  Generic constructor function                                             #
#############################################################################

setGeneric(
  name = 'TextTier',
  def  = function(tierData, tierName, tierNumber, pointTimes, pointMarks, ...) 
    standardGeneric('TextTier')
  )

setMethod(
  f   = 'TextTier',
  sig = c(tierData = 'character', 
          tierName = 'missing', tierNumber = 'missing',
          pointTimes = 'missing', pointMarks = 'missing'),
  def = function(tierData)
    # Initialize the TextTier object.
    new(Class = 'TextTier',
        tierName   = .TierName(tierData),
        tierNumber = .TierNumber(tierData),
        pointTimes = .PointTimes(tierData),
        pointMarks = .PointMarks(tierData)
        )
)





################################################################################
# Methods                                                                      #
################################################################################

#############################################################################
#  length / size                                              length / size #
#############################################################################

# length
setMethod(
  f   = 'length',
  sig = c(x = 'TextTier'),
  def = function(x)
    length(pointMarks(x))
)

#############################################################################
#  @pointTimes get-method                                       @pointTimes #
#############################################################################

# pointTimes
if (! isGeneric('pointTimes'))
  setGeneric(
    name = 'pointTimes', 
    def  = function(x) 
      standardGeneric('pointTimes')
    )
setMethod(
  f   = 'pointTimes', 
  sig = c(x = 'TextTier'), 
  def = function(x) 
    x@pointTimes
  )

# times
if (! isGeneric('times'))
  setGeneric(
    name = 'times',
    def  = function(x)
      standardGeneric('times')
    )
setMethod(
  f   = 'times',
  sig = c(x = 'TextTier'),
  def = function(x)
    pointTimes(x)
  )

#############################################################################
#  @pointMarks get-method                                       @pointMarks #
#############################################################################

# pointMarks
if (! isGeneric('pointMarks'))
  setGeneric(
    name = 'pointMarks',
    def  = function(x)
      standardGeneric('pointMarks')
    )
setMethod(
  f   = 'pointMarks',
  sig = c(x = 'TextTier'),
  def = function(x)
    x@pointMarks
  )

# marks
if (! isGeneric('marks'))
  setGeneric(
    name = 'marks',
    def  = function(x)
      standardGeneric('marks')
  )
setMethod(
  f   = 'marks',
  sig = c(x = 'TextTier'),
  def = function(x)
    pointMarks(x)
  )

#############################################################################
#  show                                                                show #
#############################################################################

setMethod(
  f   = 'show',
  sig = c(object = 'TextTier'),
  def = function(object) {
   message('<<<>>> TextTier <<<>>>')
   message('')
   message(sprintf('Tier no.:  %d', tierNumber(object)))
   message(sprintf('Tier name: %s', tierName(object)))
   message(sprintf('Tier size: %d', tierSize(object)))
   if (length(object) > 0) {
     message('')
     message('Points:')
     precis  <- 5
     maxInt  <- max(nchar(floor(pointTimes(object)))) + precis + 1
     timeFmt <- paste('%', maxInt, '.', precis, 'f', sep = '')
     lineFmt <- paste(timeFmt, '%s')
     for (p in seq_along(object))
       message(sprintf(lineFmt, pointTimes(object)[p], pointMarks(object)[p]))
   }
   })


