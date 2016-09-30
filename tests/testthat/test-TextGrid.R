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

