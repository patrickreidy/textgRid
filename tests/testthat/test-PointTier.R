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


test_that('as.data.frame.PointTier() correctly represents tier number', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events)$TierNumber,
    expected = as.integer(c(3, 3))
  )
})


test_that('as.data.frame.PointTier() correctly represents tier name', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)$TierName,
    expected = rep('Events', times = 2)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)$TierName,
    expected = as.factor(rep('Events', times = 2))
  )
})


test_that('as.data.frame.PointTier() correctly represents tier type', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)$TierType,
    expected = rep('PointTier', times = 2)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)$TierType,
    expected = as.factor(rep('PointTier', times = 2))
  )
})


test_that('as.data.frame.PointTier() correctly represents point index', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events)$Index,
    expected = as.integer(1:2)
  )
})


test_that('as.data.frame.PointTier() correctly represents point start time', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events)$StartTime,
    expected = c(6.75, 8.25)
  )
})


test_that('as.data.frame.PointTier() correctly represents point end time', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events)$EndTime,
    expected = c(6.75, 8.25)
  )
})


test_that('as.data.frame.PointTier() equates point start time and point end time', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events)$StartTime,
    expected = as.data.frame(.textgrid$Events)$EndTime
  )
})


test_that('as.data.frame.PointTier() correctly represents point label', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = FALSE)$Label,
    expected = paste0('voicing', c('On', 'Off'))
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Events, stringsAsFactors = TRUE)$Label,
    expected = as.factor(paste0('voicing', c('On', 'Off')))
  )
})


test_that('as.data.frame.PointTier() correctly numbers rows by default', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Events)),
    expected = as.character(1:2)
  )
})


test_that('as.data.frame.PointTier() can override default row names', {
  .textgrid <- TextGrid('../test.TextGrid')
  .events <- as.data.frame(.textgrid$Events)$Label
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Events, row.names = .events)),
    expected = .events
  )
})


test_that('length.PointTier() returns the number of points in well-formed PointTiers', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = length(.textgrid$Events),
    expected = length(pointLabels(.textgrid$Events))
  )
})


test_that('length.PointTier() returns NULL when its argument is ill-formed', {
  .point_tier <- new(Class = 'PointTier',
                     name   = 'BadTier',
                     number = as.integer(0),
                     times  = 1:10,
                     labels = c('a', 'b', 'c'))
  expect_null(length(.point_tier))
})
