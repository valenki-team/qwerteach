require File.expand_path('../boot', __FILE__)

require 'rails/all'
#require 'bourbon'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Qwerteach
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/jobs)

    paths.add 'notificators', eager_load: true
    paths.add 'reports', eager_load: true
    paths.add 'app/models/abilities', eager_load: true

    config.active_record.default_timezone = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Brussels'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    I18n.available_locales = [:en, :fr, :be, :ch, :abv] #abv = abréviations
    I18n.default_locale = :fr
    config.middleware.use I18n::JS::Middleware

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    #configuring actionmailer to access mailserver
    config.action_mailer.smtp_settings = {
     address: "",
     port: 587,
     domain: "",
     user_name:"" ,
     password:"" ,
     authentication: :plain,
     enable_starttls_auto: true
    }

    config.exceptions_app = self.routes



config.action_mailer.default_url_options = {
    host: ENV['DEFAULT_URL']
}
    config.to_prepare do
      Administrate::ApplicationController.helper Qwerteach::Application.helpers
    end
  end

end

