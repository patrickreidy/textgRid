library(textgRid)
context('TextGrid')


test_that('TextGrid() instantiates a TextGrid object', {
  .textgrid_file <- '../test.TextGrid'
  expect_s4_class(
    object = TextGrid(.textgrid_file),
    class  = 'TextGrid'
  )
  expect_s4_class(
    object = TextGrid(readLines(.textgrid_file)),
    class  = 'TextGrid'
  )
})


test_that('TextGrid() instantiates NULL if the tier class is neither IntervalTier nor TextTier', {
  .bad_textgrid <- c(
    '    item [0]:',
    '        class = "BadTier" ',
    '        name = "Bad name" ',
    '        xmin = 0 ',
    '        xmax = 10 ',
    '        intervals: size = 1 ',
    '        intervals [1]:',
    '            xmin = 0 ',
    '            xmax = 10 ',
    '            text = "bad label" '
  )
  expect_null(object = TextGrid(.bad_textgrid)[[1]])
})


test_that('TextGrid accessors return slot-values', {
  .textgrid_file <- '../test.TextGrid'
  expect_equal(
    object   = textGridStartTime(TextGrid(.textgrid_file)),
    expected = TextGrid(.textgrid_file)@startTime
  )
  expect_equal(
    object   = textGridStartTime(TextGrid(readLines(.textgrid_file))),
    expected = TextGrid(readLines(.textgrid_file))@startTime
  )
  expect_equal(
    object   = textGridEndTime(TextGrid(.textgrid_file)),
    expected = TextGrid(.textgrid_file)@endTime
  )
  expect_equal(
    object   = textGridEndTime(TextGrid(readLines(.textgrid_file))),
    expected = TextGrid(readLines(.textgrid_file))@endTime
  )
})


test_that('as.data.frame.TextGrid() correctly represents tier number', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words),
    as.data.frame(.textgrid$Phones),
    as.data.frame(.textgrid$Events)
  )
  expect_equal(
    object   = .df_method$TierNumber,
    expected = .df_manual$TierNumber
  )
})


test_that('as.data.frame.TextGrid() correctly represents tier name', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = FALSE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)
  )
  expect_equal(
    object   = .df_method$TierName,
    expected = .df_manual$TierName
  )
  rm(.df_method, .df_manual)
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = TRUE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)
  )
  expect_equal(
    object   = .df_method$TierName,
    expected = .df_manual$TierName
  )
})


test_that('as.data.frame.TextGrid() correctly represents tier type', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = FALSE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)
  )
  expect_equal(
    object   = .df_method$TierType,
    expected = .df_manual$TierType
  )
  rm(.df_method, .df_manual)
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = TRUE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)
  )
  expect_equal(
    object   = .df_method$TierType,
    expected = .df_manual$TierType
  )
})


test_that('as.data.frame.TextGrid() correctly represents interval/point index', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words),
    as.data.frame(.textgrid$Phones),
    as.data.frame(.textgrid$Events)
  )
  expect_equal(
    object   = .df_method$Index,
    expected = .df_manual$Index
  )
})


test_that('as.data.frame.TextGrid() correctly represents interval/point start time', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words),
    as.data.frame(.textgrid$Phones),
    as.data.frame(.textgrid$Events)
  )
  expect_equal(
    object   = .df_method$StartTime,
    expected = .df_manual$StartTime
  )
})


test_that('as.data.frame.TextGrid() correctly represents interval/point end time', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words),
    as.data.frame(.textgrid$Phones),
    as.data.frame(.textgrid$Events)
  )
  expect_equal(
    object   = .df_method$EndTime,
    expected = .df_manual$EndTime
  )
})


test_that('as.data.frame.TextGrid() correctly represents interval/point label', {
  .textgrid  <- TextGrid('../test.TextGrid')
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = FALSE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE),
    as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)
  )
  expect_equal(
    object   = .df_method$Label,
    expected = .df_manual$Label
  )
  rm(.df_method, .df_manual)
  .df_method <- as.data.frame(.textgrid, stringsAsFactors = TRUE)
  .df_manual <- rbind(
    as.data.frame(.textgrid$Words, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE),
    as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)
  )
  expect_equal(
    object   = .df_method$Label,
    expected = .df_manual$Label
  )
})


test_that('as.data.frame.TextGrid() correctly numbers rows by default', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = row.names(as.data.frame(.textgrid)),
    expected = as.character(1:11)
  )
})


test_that('as.data.frame.TextGrid() can override default row names', {
  .textgrid <- TextGrid('../test.TextGrid')
  .labels   <- as.data.frame(.textgrid)$Label
  expect_equal(
    object   = row.names(as.data.frame(.textgrid, row.names = .labels)),
    expected = .labels
  )
})


test_that('TextGrid() of data.frame returns a TextGrid', {
  .textgrid_in <- TextGrid('../test.TextGrid')
  .textgrid_out <- TextGrid(as.data.frame(.textgrid_in))
  expect_s4_class(.textgrid_out, 'TextGrid')
})


test_that('TextGrid() of data.frame returns a TextGrid', {
  .textgrid_in <- TextGrid('../test.TextGrid')
  .textgrid_out <- TextGrid(as.data.frame(.textgrid_in))
  expect_s4_class(.textgrid_out, 'TextGrid')
})


test_that('TextGrid(as.data.frame(x))  equals x', {
  .textgrid_in <- TextGrid('../test.TextGrid')
  .textgrid_out <- TextGrid(as.data.frame(.textgrid_in))
  expect_equal(.textgrid_in@.Data, .textgrid_out@.Data)
  expect_equal(textGridStartTime(.textgrid_in), 
               textGridStartTime(.textgrid_out))
  expect_equal(textGridEndTime(.textgrid_in), 
               textGridEndTime(.textgrid_out))
})
