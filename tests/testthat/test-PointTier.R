library(textgRid)
context('PointTier')


test_that('PointTier objects inherit from Tier class', {
  .textgrid <- TextGrid('../test.TextGrid')
  .point_tier <- .textgrid$Events
  expect_s4_class(object = .point_tier, class = 'PointTier')
  expect_s4_class(object = .point_tier, class = 'Tier')
})


test_that('PointTier() correctly parses tier name and number.', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises one PointTier:
  # Tier 3: Events
  .events_tier <- .textgrid$Events
  expect_equal(object = tierName(.events_tier), expected = 'Events')
  expect_equal(object = tierNumber(.events_tier), expected = 3)
})


test_that('PointTier() correctly parses point times and labels', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises one PointTier: (3) Events.
  # The Events tier comprises the following points:
  # 6.75 = voicingOn
  # 8.25 = voicingOff
  .events_tier <- .textgrid$Events
  expect_equal(object   = pointTimes(.events_tier),
               expected = c(6.75, 8.25))
  expect_equal(object   = pointLabels(.events_tier),
               expected = paste0('voicing', c('On', 'Off')))
})


test_that('findPoints() can find points with non-empty labels', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises one PointTier: (3) Events.
  # The Events tier comprises the following points:
  # 6.75 = voicingOn
  # 8.25 = voicingOff
  .events_tier <- .textgrid$Events
  expect_equal(object   = findPoints(tier = .events_tier, pattern = 'On', stringsAsFactors = FALSE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, pattern = 'On', stringsAsFactors = TRUE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, pattern = 'on', ignore.case = TRUE, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, pattern = 'on', ignore.case = TRUE, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, from = 6.5, to = 7.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, from = 6.5, to = 7.5, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, to = 7.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, to = 7.5, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index = c(1),
                 Time  = c(6.75),
                 Label = c('voicingOn'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, from = 6.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index = c(1, 2),
                 Time  = c(6.75, 8.25),
                 Label = paste0('voicing', c('On', 'Off')),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findPoints(tier = .events_tier, from = 6.5, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index = c(1, 2),
                 Time  = c(6.75, 8.25),
                 Label = paste0('voicing', c('On', 'Off')),
                 stringsAsFactors = TRUE
               ))
})
