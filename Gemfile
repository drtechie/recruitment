# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.8"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.2.1"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 3.11"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2.2"

# Use ActiveStorage variant
# gem "mini_magick", "~> 4.8"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i(mri mingw x64_mingw)
end

group :development do
  gem "annotate", require: false
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "hirb"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "pry-byebug"
  gem "pry-stack_explorer"
  gem "rails-erd"
  gem "rubocop", require: false
  gem "search_object"
  gem "search_object_graphql"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

gem "active_admin_datetimepicker"
gem "activeadmin"
gem "activeadmin_addons"
gem "activeadmin_json_editor"
gem "activerecord_json_validator"
gem "acts_as_tree"
gem "awesome_rails_console"
gem "cancancan"
gem "codemirror-rails"
gem "devise"
gem "dotenv-rails", "~> 2.5"
gem "mina", "~> 1.2"
gem "mina-puma", require: false, github: "untitledkingdom/mina-puma"
gem "nested_form_fields"
gem "redcarpet"
gem "resque"
gem "resque-scheduler"
gem "statesman"

gem "foreman", "~> 0.88.1"
