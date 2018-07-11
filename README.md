# textgRid

[![Build Status](https://travis-ci.org/patrickreidy/textgRid.svg?branch=master)](https://travis-ci.org/patrickreidy/textgRid)
[![Coverage Status](https://coveralls.io/repos/github/patrickreidy/textgRid/badge.svg?branch=master&bust=1)](https://coveralls.io/github/patrickreidy/textgRid)

The software application Praat can be used to annotate waveform data
(e.g., to mark intervals of interest or to label events).
These annotations are stored in a Praat TextGrid object, which consists of
Interval Tiers and Point Tiers. 
An Interval Tier consists of sequential (i.e., not overlapping) labeled 
intervals. 
A Point Tier consists of labeled events. 
The `textgRid` package provides S4 classes, generics, and methods for 
accessing annotations stored in Praat TextGrid objects.

## Installation

To install the current released version from CRAN:

```r
install.packages('textgRid')
```

To install the current development version from Github:

```r
devtools::install_github('textgRid', username = 'patrickreidy')
```

## Examples

#### Read the contents of a .TextGrid file.
```r
textgrid <- TextGrid(system.file('extdata', 'myExample.TextGrid', 
                                 package = 'textgRid'))
```

#### Find all labeled intervals or points on a given tier.
```r
# Find all labeled intervals on the $Words IntervalTier.
findIntervals(textgrid$Words)
#   Index StartTime EndTime  Label
# 1     2         1       3 word.1
# 2     4         6       9 word.2

# Find all labeled intervals on the $Phones IntervalTier.
findIntervals(textgrid$Phones)
#   Index StartTime EndTime    Label
# 1     2      1.00    1.50 phone.1a
# 2     3      1.50    2.50 phone.1b
# 3     4      2.50    3.00 phone.1c
# 4     6      6.00    6.75 phone.2a
# 5     7      6.75    7.25 phone.2b
# 6     8      7.25    8.25 phone.2c
# 7     9      8.25    9.00 phone.2d

# Find all intervals associated with word.2 on the $Phones IntervalTier.
findIntervals(textgrid$Phones, pattern = '2')
#   Index StartTime EndTime    Label
# 1     6      6.00    6.75 phone.2a
# 2     7      6.75    7.25 phone.2b
# 3     8      7.25    8.25 phone.2c
# 4     9      8.25    9.00 phone.2d

# Alternatively...
findIntervals(
  tier = textgrid$Phones,
  from = findIntervals(textgrid$Words, pattern = 'word.2')$StartTime,
  to   = findIntervals(textgrid$Words, pattern = 'word.2')$EndTime
)
#   Index StartTime EndTime    Label
# 1     6      6.00    6.75 phone.2a
# 2     7      6.75    7.25 phone.2b
# 3     8      7.25    8.25 phone.2c
# 4     9      8.25    9.00 phone.2d

# Find all labeled points on the $Events PointTier.
findPoints(textgrid$Events)
#   Index Time      Label
# 1     1 6.75  voicingOn
# 2     2 8.25 voicingOff
```

#### Coerce a TextGrid object to a data.frame.
```r
as.data.frame(textgrid)
#    TierNumber TierName     TierType Index StartTime EndTime      Label
# 1           1    Words IntervalTier     2      1.00    3.00     word.1
# 2           1    Words IntervalTier     4      6.00    9.00     word.2
# 3           2   Phones IntervalTier     2      1.00    1.50   phone.1a
# 4           2   Phones IntervalTier     3      1.50    2.50   phone.1b
# 5           2   Phones IntervalTier     4      2.50    3.00   phone.1c
# 6           2   Phones IntervalTier     6      6.00    6.75   phone.2a
# 7           2   Phones IntervalTier     7      6.75    7.25   phone.2b
# 8           2   Phones IntervalTier     8      7.25    8.25   phone.2c
# 9           2   Phones IntervalTier     9      8.25    9.00   phone.2d
# 10          3   Events    PointTier     1      6.75    6.75  voicingOn
# 11          3   Events    PointTier     2      8.25    8.25 voicingOff
```

#### Write a TextGrid object to a Praat-compatible .TextGrid file.
```r
writeTextGrid(textgrid, path = 'test_out.TextGrid')
```

#### Read a TextGrid that contains non-ASCII characters.
```r
# Guess the encoding.
nonASCII <- TextGrid(system.file('extdata', 'nonASCII.TextGrid', package = 'textgRid'),
                     encoding = NULL)

# Or, explicitly provide the (correct) encoding.
nonASCII <- TextGrid(system.file('extdata', 'nonASCII.TextGrid', package = 'textgRid'),
                     encoding = "UTF-16BE")

# An error occurs if the provided encoding is incorrect.
TextGrid(system.file('extdata', 'nonASCII.TextGrid', package = 'textgRid'),
                     encoding = "UTF-8")

# Coerce the TextGrid to a data.frame.
as.data.frame(nonASCII)[1:2, ]
#   TierNumber TierName     TierType Index StartTime EndTime                      Label
# 1          1  Bengali IntervalTier     1         0       1   চকলেট এবং চিনাবাদাম মাখন
# 2          2  Chinese IntervalTier     1         0       1             巧克力和花生醬

# Non-ASCII characters can be used as patterns in searches.
findIntervals(nonASCII$Bengali, pattern = "চকলেট")
#   Index StartTime EndTime                    Label
# 1     1         0       1 চকলেট এবং চিনাবাদাম মাখন
```

## Details on S4 classes

The textgRid package defines four S4 classes, whose slots and accessors are 
described in the tables below.

#### Tier

Slot      | Type      | Accessor 
----------|-----------|---------------
`@name`   | character | `tierName()`
`@number` | integer   | `tierNumber()`

#### IntervalTier (inherits from Tier)

Slot          | Type      | Accessor
--------------|-----------|-----------------------
`@startTimes` | numeric   | `intervalStartTimes()`
`@endTimes`   | numeric   | `intervalEndTimes()`
`@labels`     | character | `intervalLabels()`

#### PointTier (inherits from Tier)

Slot      | Type      | Accessor
----------|-----------|---------------
`@times`  | numeric   | `pointTimes()`
`@labels` | character | `pointLabels()`

#### TextGrid

Slot         | Type                                       | Accessor
-------------|--------------------------------------------|----------------------
`@.Data`     | list (of IntervalTiers and PointTiers)     |
`@startTime` | numeric                                    | `textGridStartTime()`
`@endTime`   | numeric                                    | `textGridEndTime()`

