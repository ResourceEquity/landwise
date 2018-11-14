require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_PERSISTENT_URL'] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_PERSISTENT_URL'] }
end

if File.exist?('config/schedule.yml') && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
end
