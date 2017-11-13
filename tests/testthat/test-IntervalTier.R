library(textgRid)
context('IntervalTier')


test_that('IntervalTier objects inherit from Tier class', {
  .textgrid <- TextGrid('../test.TextGrid')
  .interval_tier <- .textgrid$Words
  expect_s4_class(object = .interval_tier, class = 'IntervalTier')
  expect_s4_class(object = .interval_tier, class = 'Tier')
})


test_that('IntervalTier() correctly parses tier name and number.', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises two IntervalTiers:
  # Tier 1: Words
  .words_tier <- .textgrid$Words
  expect_equal(object = tierName(.words_tier), expected = 'Words')
  expect_equal(object = tierNumber(.words_tier), expected = 1)
  # Tier 2: Phones
  .phones_tier <- .textgrid$Phones
  expect_equal(object = tierName(.phones_tier), expected = 'Phones')
  expect_equal(object = tierNumber(.phones_tier), expected = 2)
})


test_that('IntervalTier() correctly parses interval start times, end times, and labels', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises two IntervalTiers: (1) Words and (2) Phones.
  # The Words tier comprises the following intervals:
  # 0.0 --  1.0 = <empty>
  # 1.0 --  3.0 = word.1
  # 3.0 --  6.0 = <empty>
  # 6.0 --  9.0 = word.2
  # 9.0 -- 10.0 = <empty>
  .words_tier <- .textgrid$Words
  expect_equal(object   = intervalStartTimes(.words_tier),
               expected = c(0.0, 1.0, 3.0, 6.0, 9.0))
  expect_equal(object   = intervalEndTimes(.words_tier),
               expected = c(1.0, 3.0, 6.0, 9.0, 10.0))
  expect_equal(object   = intervalLabels(.words_tier),
               expected = c('', 'word.1', '', 'word.2', ''))
  # The Phones tier comprises the following intervals:
  # 0.0  -- 1.0  = <empty>
  # 1.0  -- 1.5  = phone.1a
  # 1.5  -- 2.5  = phone.1b
  # 2.5  -- 3.0  = phone.1c
  # 3.0  -- 6.0  = <empty>
  # 6.0  -- 6.75 = phone.2a
  # 6.75 -- 7.25 = phone.2b
  # 7.25 -- 8.25 = phone.2c
  # 8.25 -- 9.0  = phone.2d
  # 9.0  -- 10.0 = <empty>
  .phones_tier <- .textgrid$Phones
  expect_equal(object   = intervalStartTimes(.phones_tier),
               expected = c(0.0, 1.0, 1.5, 2.5, 3.0, 6.0, 6.75, 7.25, 8.25, 9.0))
  expect_equal(object   = intervalEndTimes(.phones_tier),
               expected = c(1.0, 1.5, 2.5, 3.0, 6.0, 6.75, 7.25, 8.25, 9.0, 10.0))
  expect_equal(object   = intervalLabels(.phones_tier),
               expected = c('', 'phone.1a', 'phone.1b', 'phone.1c', '',
                            'phone.2a', 'phone.2b', 'phone.2c', 'phone.2d', ''))
})


test_that('findIntervals() can find intervals with non-empty labels', {
  .textgrid <- TextGrid('../test.TextGrid')
  # [.textgrid] comprises two interval tiers: (1) Words and (2) Phones.
  # The Words tier comprises the following intervals:
  # 0.0 --  1.0 = <empty>
  # 1.0 --  3.0 = word.1
  # 3.0 --  6.0 = <empty>
  # 6.0 --  9.0 = word.2
  # 9.0 -- 10.0 = <empty>
  .words_tier <- .textgrid$Words
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+', 
                                        stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(2, 4),
                 StartTime = c(1.0, 6.0),
                 EndTime   = c(3.0, 9.0),
                 Label     = c('word.1', 'word.2'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+',
                                        stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(2, 4),
                 StartTime = c(1.0, 6.0),
                 EndTime   = c(3.0, 9.0),
                 Label     = c('word.1', 'word.2'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '1', 
                                        stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(2),
                 StartTime = c(1.0),
                 EndTime   = c(3.0),
                 Label     = c('word.1'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '1', 
                                        stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(2),
                 StartTime = c(1.0),
                 EndTime   = c(3.0),
                 Label     = c('word.1'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+', 
                                        from = 6.5, to = 7.5, 
                                        stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(4),
                 StartTime = c(6.0),
                 EndTime   = c(9.0),
                 Label     = c('word.2'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+',
                                        from = 6.5, to = 7.5, 
                                        stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(4),
                 StartTime = c(6.0),
                 EndTime   = c(9.0),
                 Label     = c('word.2'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+',
                                        at = 7.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(4),
                 StartTime = c(6.0),
                 EndTime   = c(9.0),
                 Label     = c('word.2'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .words_tier, pattern = '.+',
                                        at = 7.5, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(4),
                 StartTime = c(6.0),
                 EndTime   = c(9.0),
                 Label     = c('word.2'),
                 stringsAsFactors = TRUE
               ))
  # The Phones tier comprises the following intervals:
  # 0.0  -- 1.0  = <empty>
  # 1.0  -- 1.5  = phone.1a
  # 1.5  -- 2.5  = phone.1b
  # 2.5  -- 3.0  = phone.1c
  # 3.0  -- 6.0  = <empty>
  # 6.0  -- 6.75 = phone.2a
  # 6.75 -- 7.25 = phone.2b
  # 7.25 -- 8.25 = phone.2c
  # 8.25 -- 9.0  = phone.2d
  # 9.0  -- 10.0 = <empty>
  .phones_tier <- .textgrid$Phones
  expect_equal(object   = findIntervals(tier = .phones_tier, pattern = '.+',
                                        stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(2, 3, 4, 6, 7, 8, 9),
                 StartTime = c(1.0, 1.5, 2.5, 6.0, 6.75, 7.25, 8.25),
                 EndTime   = c(1.5, 2.5, 3.0, 6.75, 7.25, 8.25, 9.0),
                 Label     = paste('phone', c('1a', '1b', '1c', '2a', '2b', '2c', '2d'), sep = '.'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, pattern = '.+', 
                                        stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(2, 3, 4, 6, 7, 8, 9),
                 StartTime = c(1.0, 1.5, 2.5, 6.0, 6.75, 7.25, 8.25),
                 EndTime   = c(1.5, 2.5, 3.0, 6.75, 7.25, 8.25, 9.0),
                 Label     = paste('phone', c('1a', '1b', '1c', '2a', '2b', '2c', '2d'), sep = '.'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, pattern = '1', stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(2, 3, 4),
                 StartTime = c(1.0, 1.5, 2.5),
                 EndTime   = c(1.5, 2.5, 3.0),
                 Label     = paste('phone', c('1a', '1b', '1c'), sep = '.'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, pattern = '1', stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(2, 3, 4),
                 StartTime = c(1.0, 1.5, 2.5),
                 EndTime   = c(1.5, 2.5, 3.0),
                 Label     = paste('phone', c('1a', '1b', '1c'), sep = '.'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, from = 6.5, to = 7.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(6, 7, 8),
                 StartTime = c(6.0, 6.75, 7.25),
                 EndTime   = c(6.75, 7.25, 8.25),
                 Label     = paste('phone', c('2a', '2b', '2c'), sep = '.'),
                 stringsAsFactors = FALSE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, from = 6.5, to = 7.5, stringsAsFactors = TRUE),
               expected = data.frame(
                 Index     = c(6, 7, 8),
                 StartTime = c(6.0, 6.75, 7.25),
                 EndTime   = c(6.75, 7.25, 8.25),
                 Label     = paste('phone', c('2a', '2b', '2c'), sep = '.'),
                 stringsAsFactors = TRUE
               ))
  expect_equal(object   = findIntervals(tier = .phones_tier, at = 7.5, stringsAsFactors = FALSE),
               expected = data.frame(
                 Index     = c(8),
                 StartTime = c(7.25),
                 EndTime   = c(8.25),
                 Label     = paste('phone', c('2c'), sep = '.'),
                 stringsAsFactors = FALSE
               ))
})


test_that('as.data.frame.IntervalTier() correctly represents tier number', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(object   = as.data.frame(.textgrid$Words)$TierNumber,
               expected = as.integer(c(1, 1, 1, 1, 1)))
  expect_equal(object   = as.data.frame(.textgrid$Phones)$TierNumber,
               expected = as.integer(c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2)))
})


test_that('as.data.frame.IntervalTier() correctly represents tier name', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = FALSE)$TierName,
    expected = rep('Words', times = 5)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = TRUE)$TierName,
    expected = as.factor(rep('Words', times = 5))
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE)$TierName,
    expected = rep('Phones', times = 10)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE)$TierName,
    expected = as.factor(rep('Phones', times = 10))
  )
})


test_that('as.data.frame.IntervalTier() correctly represents tier type', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = FALSE)$TierType,
    expected = rep('IntervalTier', times = 5)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = TRUE)$TierType,
    expected = as.factor(rep('IntervalTier', times = 5))
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE)$TierType,
    expected = rep('IntervalTier', times = 10)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE)$TierType,
    expected = as.factor(rep('IntervalTier', times = 10))
  )
})


test_that('as.data.frame.IntervalTier() correctly represents interval index', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words)$Index,
    expected = as.integer(c(1:5))
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones)$Index,
    expected = as.integer(c(1:10))
  )
})


test_that('as.data.frame.IntervalTier() correctly represents interval start time', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words)$StartTime,
    expected = c(0.0, 1.0, 3.0, 6.0, 9.0)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones)$StartTime,
    expected = c(0.0, 1.0, 1.5, 2.5, 3.0, 6.0, 6.75, 7.25, 8.25, 9.0)
  )
})


test_that('as.data.frame.IntervalTier() correctly represents interval end time', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words)$EndTime,
    expected = c(1.0, 3.0, 6.0, 9.0, 10.0)
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones)$EndTime,
    expected = c(1.0, 1.5, 2.5, 3.0, 6.0, 6.75, 7.25, 8.25, 9.0, 10.0)
  )
})


test_that('as.data.frame.IntervalTier() correctly represents interval label', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = FALSE)$Label,
    expected = c('', 'word.1', '', 'word.2', '')
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Words, stringsAsFactors = TRUE)$Label,
    expected = as.factor(c('', 'word.1', '', 'word.2', ''))
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = FALSE)$Label,
    expected = c('', paste('phone', c('1a', '1b', '1c'), sep  = '.'), '', 
                 paste('phone', c('2a', '2b', '2c', '2d'), sep = '.'), '')
  )
  expect_equal(
    object   = as.data.frame(.textgrid$Phones, stringsAsFactors = TRUE)$Label,
    expected = as.factor(
      c('', paste('phone', c('1a', '1b', '1c'), sep  = '.'), '', 
        paste('phone', c('2a', '2b', '2c', '2d'), sep = '.'), '')
    )
  )
})


test_that('as.data.frame.IntervalTier() correctly numbers rows by default', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Words)),
    expected = as.character(1:5)
  )
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Phones)),
    expected = as.character(1:10)
  )
})


test_that('as.data.frame.IntervalTier() can override default row names', {
  .textgrid <- TextGrid('../test.TextGrid')
  .rownames <- letters[1:5]
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Words, row.names = .rownames)),
    expected = .rownames
  )
  .rownames <- letters[1:10]
  expect_equal(
    object   = row.names(as.data.frame(.textgrid$Phones, row.names = .rownames)),
    expected = .rownames
  )
})


test_that('length.IntervalTier() returns the number of intervals in well-formed IntervalTiers', {
  .textgrid <- TextGrid('../test.TextGrid')
  expect_equal(
    object   = length(.textgrid$Words),
    expected = length(intervalLabels(.textgrid$Words))
  )
  expect_equal(
    object   = length(.textgrid$Phones),
    expected = length(intervalLabels(.textgrid$Phones))
  )
})


test_that('length.IntervalTier() returns NULL when its argument is ill-formed', {
  .tier1 <- new(Class = 'IntervalTier',
                name       = 'BadTier',
                number     = as.integer(0),
                startTimes = 1:20,
                endTimes   = 21:23,
                labels     = c('a', 'b', 'c'))
  .tier2 <- new(Class = 'IntervalTier',
                name       = 'BadTier',
                number     = as.integer(0),
                startTimes = 1:3,
                endTimes   = 4:23,
                labels     = c('a', 'b', 'c'))
  expect_null(object = length(.tier1))
  expect_null(object = length(.tier2))
})



