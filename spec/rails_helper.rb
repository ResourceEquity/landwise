# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'vcr'
require 'simplecov'
require 'colorize'
require 'webmock/rspec'
require 'selenium/webdriver'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter
])

SimpleCov.start 'rails' do
  add_filter '_spec.rb'
  add_filter '/cache/'
end

if ENV['TEST_ENV_NUMBER']
  SimpleCov.at_exit do
    result = SimpleCov.result
    result.format! if ParallelTests.number_of_running_processes <= 1
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'support/factory_bot'
require 'spec_helper'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include RequestHelper, type: :request

  config.silence_filter_announcements = true if ENV['TEST_ENV_NUMBER']

  chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

  options = {}
  options[:args] = ['window-size=1600,1200', 'no-sandbox', 'disable-web-security', 'allow-running-insecure-content']
  options[:args] << 'headless' unless ENV['GUI'].present?
  options[:binary] = chrome_bin if chrome_bin

  Capybara.register_driver :headless_chrome do |app|
    Capybara::Selenium::Driver.new(app,
       browser: :chrome,
       options: Selenium::WebDriver::Chrome::Options.new(options)
     )
  end

  Capybara.javascript_driver = :headless_chrome

  Capybara.configure do |config|
    config.default_max_wait_time = 30
  end

  Capybara.configure do |c|
    c.always_include_port = true
  end

  config.before(:each, type: :system) do
    driven_by :headless_chrome
  end

  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
  end

  # Delete all screenshots that may have been captured from previous runs
  # of the suite, so that only new, relevant screenshots appear in the dir
  config.before(:all, type: :system) do
    if ENV['TEST_ENV_NUMBER'] == ''
      Dir.glob("#{::Rails.root}/tmp/screenshots/*.png").each { |file| File.delete(file) }
    end
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
