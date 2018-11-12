PDFKit.configure do |config|
  # config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
  config.default_options = {
    :page_size => 'Letter',
    :print_media_type => false
  }
  # Use only if your external hostname is unavailable on the server.
  if Rails.env.development?
    config.root_url = "http://localhost:8080"
    config.verbose = true
  end
end
