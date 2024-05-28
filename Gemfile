source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.3"

gem "rails", "~> 7.0.7"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "jquery-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "faker", "2.21.0"
gem "pagy"
gem "mailtrap"
gem "figaro"
gem "active_storage_validations", "0.9.8"
gem "image_processing", "1.12.2"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: true
gem "sass-rails"
gem "bootstrap-sass"
gem "i18n"
gem "config"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "pry"
end

group :production do
  gem "pg", "1.3.5"
  gem "aws-sdk-s3", "1.114.0", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
