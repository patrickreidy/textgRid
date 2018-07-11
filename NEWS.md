# v1.0.2

**_Current development version on Github_**

* `encoding` argument added to `TextGrid()` constructor in order to handle
  non-ASCII characters in .TextGrid files, which is useful for IPA symbols and
  symbols from the world's languages. By default (`encoding = NULL`), the
  encoding of file is guessed using `readr::guess_encoding`; however, this
  can be overridden by identifying the encoding explicitly (e.g., 
  `encoding = "UTF-8"` or `encoding "UTF-16BE"`).
* Some versions of Praat write TextGrid files with spaces; other versions write
  with tabs. Previous versions of `textgRid` assumed spaces, but now both 
  formats can be handled.


# v1.0.1.9001

* `writeTextGrid` function for `TextGrid`s.


# v1.0.1.9000

* `length` methods for `IntervalTier`s and `PointTier`s.
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
