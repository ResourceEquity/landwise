Recaptcha.configure do |config|
  config.site_key = ENV.fetch('RECAPTCHA_SITE_KEY') { Rails.application.credentials.recaptcha[:site_key] }
  end
  config.secret_key = ENV.fetch('RECAPTCHA_SECRET_KEY') { Rails.application.credentials.recaptcha[:secret_key] }
  end
end
