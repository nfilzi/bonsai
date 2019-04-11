source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# defaults
gem 'rails', '~> 5.2.2'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

# own gems
gem 'devise'
gem 'simple_form'

# assets
gem 'bootstrap', '~> 4.1.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 3.5'

gem 'simplecov', require: false, group: :test

gem 'httparty'
gem 'blueprinter'
gem 'oj'

group :development, :test do
  gem 'rubocop'
  gem 'rspec-rails', '~> 3.8'

  gem 'factory_bot_rails'
  gem 'shoulda-matchers'

  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'geckodriver-helper'

  gem 'capybara'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
