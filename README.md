# textgRid

[![Build Status](https://travis-ci.org/patrickreidy/textgRid.svg?branch=master)](https://travis-ci.org/patrickreidy/textgRid)
[![Coverage Status](https://coveralls.io/repos/github/patrickreidy/textgRid/badge.svg?branch=master)](https://coveralls.io/github/patrickreidy/textgRid)

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

## Details on S4 classes

The textgRid package defines four S4 classes, whose slots and accessors are 
described in the tables below.

#### Tier

Slot      | Type      | Accessor 
----------|-----------|---------------
`@name`   | character | `tierName()`
`@number` | integer   | `tierNumber()`

#### `IntervalTier` (inherits from Tier)

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
`@.Data`     | list (of `IntervalTier`s and `PointTier`s) |
`@startTime` | numeric                                    | `textGridStartTime()`
`@endTime`   | numeric                                    | `textGridEndTime()`

