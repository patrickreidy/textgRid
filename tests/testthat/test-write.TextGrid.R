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