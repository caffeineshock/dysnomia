if Rails.env.development?
  require 'rack-mini-profiler'

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
  Rack::MiniProfiler.config.start_hidden = true
  Rack::MiniProfiler.config.toggle_shortcut = 'Shift+P'
end