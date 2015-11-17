require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'task_list/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Dysnomia
  class Application < Rails::Application
    # Make Settings available before rails application initialization process
    Config::Integration::Rails::Railtie.preload

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :de

    # Load locales from subdirectories
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Add assets for EpicEditor
    config.assets.precompile += ['epiceditor/base.css', 'epiceditor/editor.css', 'epiceditor/preview.css']

    # Add devise layout stylesheet
    config.assets.precompile += ['devise.css']

    # Add image assets
    config.assets.precompile += %w(controllers/*.js *.png *.jpg *.jpeg *.gif *.ogg)

    # Exception handling through app
    config.exceptions_app = self.routes

    # Mailer options
    config.action_mailer.smtp_settings = {openssl_verify_mode: 'none'}
  end
end
