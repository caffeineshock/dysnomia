every 1.day, :at => '5:00 am' do
  runner "CleanReadMarksWorker.perform_async"
end