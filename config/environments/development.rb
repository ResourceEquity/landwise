Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.allow_concurrency = true

  # Do not eager load code on boot.
  config.eager_load = true

  # Show full error reports.
  config.consider_all_requests_local = false

  # Enable/disable caching. By default caching is disabled.
  config.action_controller.perform_caching = true

  config.reload_classes_only_on_change = false

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.public_file_server.headers = {
    'Cache-Control' => 'public, s-maxage=31536000, max-age=15552000',
    'Expires' => "#{1.year.from_now.to_formatted_s(:rfc822)}"
  }

  # config.public_file_server.headers = { 'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}" }

  # Enable caching
  # config.cache_store = :mem_cache_store, ENV['MEMCACHEDCLOUD_SERVERS'].split(','), { username: ENV['MEMCACHEDCLOUD_USERNAME'], password: ENV['MEMCACHEDCLOUD_PASSWORD'] }
  # config.cache_store = :dalli_store, { namespace: "motherboard_#{Rails.env}", socket_timeout: 3, compress: true }
  config.cache_store = :redis_cache_store, { url: 'redis://127.0.0.1:6379/0', compress: true, driver: :hiredis }

  # Use a real queuing backend for Active Job (and separate queues per environment)
  config.active_job.queue_adapter     = :sidekiq

  config.active_job.queue_name_prefix = "resourceequity_#{Rails.env}"

  config.action_controller.asset_host = 'resourceequity.ngrok.io'

  config.action_mailer.default_url_options = { host: config.action_controller.asset_host }

  config.action_mailer.asset_host = "https://#{config.action_controller.asset_host}"

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.delivery_method = :letter_opener # :smtp

  config.action_mailer.perform_deliveries = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.active_storage.service = :amazon

  logger           = ActiveSupport::Logger.new(STDOUT)
  logger.formatter = config.log_formatter
  config.logger    = ActiveSupport::TaggedLogging.new(logger)

  config.log_level = :debug

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::FileUpdateChecker

  Rails.application.routes.default_url_options[:host] = config.action_controller.asset_host

  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.add_footer = true
    Bullet.raise = false
  end
end
