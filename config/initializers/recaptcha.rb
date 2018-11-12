Recaptcha.configure do |config|
  config.site_key = ENV.fetch('RECAPTCHA_SITE_KEY') do
    Rails.application.credentials.recaptcha[:site_key] if Rails.env.development?
  end
  config.secret_key = ENV.fetch('RECAPTCHA_SECRET_KEY') do
    Rails.application.credentials.recaptcha[:secret_key] if Rails.env.development?
  end
end
