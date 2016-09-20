# textgRid

The software application Praat can be used to annotate waveform data
(e.g., to mark intervals of interest or to label events).
These annotations are stored in a Praat TextGrid object, which consists of
a number of interval tiers and point tiers. An interval tier consists of
sequential (i.e., not overlapping) labeled intervals. A point tier consists
of labeled events that have no duration. The textgRid package provides 
S4 classes, generics, and methods for accessing information that is stored
in Praat TextGrid objects.

## S4 classes:

The textgRid package defines four S4 classes, whose slots and accessors are 
described in the tables below.

###### `Tier`

Slot      | Type      | Accessor 
----------|-----------|---------------
`@name`   | character | `tierName()`
`@number` | numeric   | `tierNumber()`

###### `IntervalTier` (inherits from `Tier`)

Slot          | Type      | Accessor
--------------|-----------|-----------------------
`@startTimes` | numeric   | `intervalStartTimes()`
`@endTimes`   | numeric   | `intervalEndTimes()`
`@labels`     | character | `intervalLabels()`

###### `PointTier` (inherits from `Tier`)

Slot      | Type      | Accessor
----------|-----------|---------------
`@times`  | numeric   | `pointTimes()`
`@labels` | character | `pointLabels()`

###### `TextGrid`

Slot         | Type                                       | Accessor
-------------|--------------------------------------------|----------------------
`@.Data`     | list (of `IntervalTier`s and `PointTier`s) |
`@startTime` | numeric                                    | `textGridStartTime()`
`@endTime`   | numeric                                    | `textGridEndTime()`



## `TextGrid` object instantiation:

An instance of the `TextGrid` class is created with the S4 generic function
`TextGrid()`.
