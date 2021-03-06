Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  config.i18n.fallbacks = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.reload_classes_only_on_change = true

  # Don't care if the mailer can't send.
  ##config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.default_url_options = { host: ENV.fetch('MAILER_HOST', 'localhost'), port: 3000 }
  # email sending process
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :letter_opener
  #config.action_mailer.delivery_method = :smtp
  # Defaults to:
  # config.action_mailer.sendmail_settings = {
  #   location: '/usr/sbin/sendmail',
  #   arguments: '-i -t'
  # }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: 'hello@qwerteach.com'}
  config.web_console.whitelisted_ips = '0.0.0.0/0.0.0.0'

  # background image in css file
  config.serve_static_files = true

  config.action_mailer.smtp_settings = {
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :domain => 'localhost',
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
  }
  #config.middleware.use Rack::GoogleAnalytics, :tracker => 'UA-60202325-2'
  config.middleware.use(Rack::Tracker) do
    handler :google_analytics, { tracker: 'UA-60202325-2'}
  end
    # config asset_url 
  config.action_mailer.asset_host = "http://localhost:3000"

end
