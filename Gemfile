source 'https://rubygems.org'

source 'https://gem.minow.io' do
  gem 'voltron', '~> 0.2'
  gem 'voltron-flash', '~> 0.1.7'
  gem 'voltron-notify', '~> 0.2.2'
end

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'autoprefixer-rails'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'ckeditor'
gem 'cocoon'
gem 'colorize'
gem 'custom_error_message', github: 'thethanghn/custom-err-msg'
gem 'devise'
gem 'fog-aws'
gem 'hiredis'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'jquery-rails'
gem 'mailgun-ruby', '~> 1.1.6'
gem 'paperclip', '>= 5.0'
gem 'pdfkit'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2.1'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'rolify'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 0.6.3'
gem 'sunspot_rails'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate'
gem 'yajl-ruby', require: 'yajl/json_gem'

group :staging, :production do
  gem 'newrelic_rpm'
  gem 'heroku-deflater'
end

group :development, :test do
  gem 'annotate'
  gem 'awesome_print'
  gem 'bullet'
  gem 'chromedriver-helper'
  gem 'knapsack'
  gem 'parallel_tests'
  gem 'progress_bar'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'brakeman', require: false
  gem 'flamegraph'
  gem 'foreman', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rack-mini-profiler'
  gem 'rails-erd', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'stackprof'
end

group :test do
  gem 'capybara-selenium'
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'launchy'
  gem 'mocha'
  gem 'rails-controller-testing'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
