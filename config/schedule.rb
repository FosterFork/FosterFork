# Learn more: http://github.com/javan/whenever

every :hour do
  runner "Statistic.snapshot"
end