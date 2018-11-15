CarrierWave.configure do |config|
  if Rails.env.development?
    config.storage = :file
  elsif Rails.env.staging? || Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV.fetch('AWS_BUCKET_NAME') { "#{Rails.application.credentials.aws[:bucket]}-#{Rails.env}" }

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY') { Rails.application.credentials.aws[:access] },
      aws_secret_access_key: ENV.fetch('AWS_SECRET_KEY') { Rails.application.credentials.aws[:secret] },
      region:                ENV.fetch('AWS_REGION') { Rails.application.credentials.aws[:region] },
      endpoint:              "https://s3.#{ENV.fetch('AWS_REGION') { Rails.application.credentials.aws[:region] }}.amazonaws.com"
    }

    config.fog_attributes = {
      'Cache-Control' => 'max-age=315576000'
    }

    config.storage = :fog
  end
end
