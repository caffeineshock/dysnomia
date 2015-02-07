source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use edge version of sprockets-rails
gem 'sprockets-rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use Capistrano for deployment
gem 'capistrano', require: false, group: :development
gem 'capistrano-rails', group: :development
gem 'capistrano-bundler', group: :development
gem 'capistrano-rbenv', '~> 2.0', group: :development

# Foundation framework
gem 'foundation-rails'

# Foundation icon font
gem 'foundation-icons-sass-rails'

# Normalize.css
gem 'normalize-rails'

# Thin app server
gem 'thin'

# Public activity feed (from github to address attr_accesible problem)
gem 'public_activity', github: 'pokonski/public_activity'

# PostgreSQL
gem 'pg', group: :production

# Brakeman (static code analysis)
gem 'brakeman', require: false, group: :development

# Class-diagrams
gem 'rails-erd', require: false, group: :development

# Bundling of jquery library FullCalendar
gem 'fullcalendar-rails'

# JQuery UI
gem 'jquery-ui-rails', '~>4.2'

# Validations for datetimes
gem 'validates_timeliness', '~> 3.0'

# Rack miniprofiler
gem 'rack-mini-profiler', require: false

# Beatiful select fields
gem 'select2-rails'

# Generation and parsing of .ics files
gem 'icalendar'

# WYSIWYG editor for Markdown
gem 'epic-editor-rails', github: 'zethussuen/epic-editor-rails'

# Gem to create complex forms easily 
gem 'simple_form', '~> 3.0.1'

# Colorpicker
gem 'jquery-minicolors-rails'

# Gem to copy content to clipboard
gem 'zeroclipboard-rails', github: 'zeroclipboard/zeroclipboard-rails'

# Provides behaviour to mark models as read
gem 'unread'

# Recurring events
gem 'ice_cube'

# Pagination
gem 'will_paginate'

# Spinner without images or css
gem 'spinjs-rails', '1.3'

# Glue between Rails and Faye server for asynchronous pub/sub
gem 'private_pub', github: 'caffeineshock/private_pub', branch: 'js_publish'

# use specific version of cookiejar, because higher version fail with faye
gem 'cookiejar', '0.3.0'

# Manage multiple processes of the app
gem 'foreman'

# Better format for exceptions
gem 'better_errors', group: :development
gem 'binding_of_caller', group: :development

# Analyze gems for known vulnerabilities
gem 'gemsurance', group: :development

# Gem to add file attachments to model instances
gem 'paperclip'

# Use redis as cache
gem 'redis-rails'

# Directly map between redis and ruby objects
gem 'redis-objects'

# Access to Discourse API
gem 'discourse_api'

# Shhh
gem 'quiet_assets', group: :development

# Warns about N + 1 queries
gem 'bullet', group: :development

# Post-processing user-provided content
gem 'html-pipeline'
gem 'gemoji'
gem 'github-markdown'
gem 'sanitize'

# Tests
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'timecop'
end

group :development do
  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false
end

group :test, :development do
  gem 'rspec-rails'
end

# Live-reloading in browser
group :development do
  gem 'rack-livereload'
  gem 'guard-livereload'
  gem 'guard-bundler', require: false
end

# Automatic brakeman executiopn
gem 'guard-brakeman', group: :development

# Automatically execute migrations on changes
gem 'guard-migrate', group: :development

# AuthN
gem 'devise'
gem 'devise-i18n'
gem 'devise-async'
gem 'devise_invitable'

# Code metrics
gem 'metric_fu'

# Model decorators
gem 'draper'

# Send exceptions via mail
gem 'exception_notification'

# Access global settings
gem 'rails_config'

# Set settings for AR instances
gem 'ledermann-rails-settings'

# Keyboard shortcuts
gem 'mousetrap-rails'

# Asynchronous Job processing
gem 'sidekiq'

# Monitoring of sidekiq
gem 'sinatra', '>= 1.3.0', require: false

# Use routes in Javascript
gem 'js-routes'

# Readline
gem 'rb-readline', require: false

# Inspect mails sent by ActionMailer
gem "letter_opener", group: :development
gem 'letter_opener_web', '~> 1.2.0', group: :development

# Domain events
gem 'wisper'

# Slugs in URLs
gem 'friendly_id'

# Cron jobs
gem 'whenever', require: false

# momentjs is needed by fullcalendar
gem 'momentjs-rails'