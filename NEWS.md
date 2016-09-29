# v1.0.1.9000

**_Current development version on Github_**

* `Tier@number` slot changed from `numeric` to `integer`.
* `as.data.frame` methods for `IntervalTier`s, `PointTier`s, and `TextGrid`s.
* `stringsAsFactors` argument added to `find*()` functions.
* `myExample.TextGrid` file available in `inst/extdata/`.


# v1.0.1

**_Current released version on CRAN_**

Functions for reading Praat `.TextGrid` files into R.

```r
TextGrid(textGrid)         # Read the annotations in the @textGrid filepath.
findIntervals(tier, ...)   # Return a data.frame of the contentful intervals
                           # from an Interval @tier.
findPoints(tier, ...)      # Return a data.frame of the contentful points
                           # from a Point @tier.
```

See `README.md` for a description of the S4 class system used to structure
TextGrid data.
