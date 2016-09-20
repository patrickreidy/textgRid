library(textgRid)
context('TextGrid')


test_that('TextGrid() instantiates a TextGrid object', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_s4_class(object = .textgrid, class = 'TextGrid')
})


test_that('TextGrid accessors return slot-values', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(object   = textGridStartTime(.textgrid),
               expected = .textgrid@startTime)
  expect_equal(object   = textGridEndTime(.textgrid),
               expected = .textgrid@endTime)
})
