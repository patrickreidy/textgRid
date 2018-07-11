library(textgRid)
context('TextGrid')


test_that('writeTextGrid() returns valid TextGrid character vector', {
  .fin <- '../test.TextGrid'
  .textgrid <- TextGrid(.fin)
  .textgrid_lines <- writeTextGrid(.textgrid)

  expect_s4_class(
    object = TextGrid(.textgrid_lines),
    class  = 'TextGrid'
  )
})


test_that('writeTextGrid() output is identical to input TextGrid', {
  .fin <- '../test.TextGrid'
  .textgrid_in <- TextGrid(.fin)
  .textgrid_lines <- writeTextGrid(.textgrid_in)
  .textgrid_out <- TextGrid(.textgrid_lines)

  expect_identical(.textgrid_out, .textgrid_in)
})


test_that('writeTextGrid() can write to file', {
  .fin <- '../test.TextGrid'
  .fout <- '../test_out.TextGrid'
  .textgrid_in <- TextGrid(.fin)
  writeTextGrid(.textgrid_in, path = .fout)
  .textgrid_out <- TextGrid(.fout)

  expect_identical(.textgrid_out, .textgrid_in)
  file.remove(.fout)
})


test_that('writeIntervalTier() can write to file', {
  .fin <- '../test.TextGrid'
  .fout <- '../test_out.TextGrid'
  .textgrid_in <- TextGrid(.fin)
  .tier <- .textgrid_in@.Data[[1]] # an ItervalTier

  .tier_in <- writeIntervalTier(.tier)
  writeIntervalTier(.tier, path = .fout)
  .tier_out <- readLines(.fout)

  expect_identical(.tier_in, .tier_out)
  file.remove(.fout)
})


test_that('writePointTier() can write to file', {
  .fin <- '../test.TextGrid'
  .fout <- '../test_out.TextGrid'
  .textgrid_in <- TextGrid(.fin)
  .tier <- .textgrid_in@.Data[[3]] # a PointTier

  .tier_in <- writePointTier(.tier)
  writePointTier(.tier, path = .fout)
  .tier_out <- readLines(.fout)

  expect_identical(.tier_in, .tier_out)
  file.remove(.fout)
})
