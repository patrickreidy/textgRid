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

* Tier
* IntervalTier
* PointTier
* TextGrid

## S4 generics:

* TextGrid()

  Usage: TextGrid('path/to/my.TextGrid')

  Value: A TextGrid object, which is a list of IntervalTier and PointTier objects.
