source 'https://rubygems.org'

ruby "2.3.0"

gem 'rails', '4.2.5'
gem "active_model_serializers", github: "rails-api/active_model_serializers"

# Aws deployment
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rbenv', github: "capistrano/rbenv"

gem 'sqlite3'

group :development do
  gem 'pry-rails'
end

group :development, :test do
  gem 'spring'  
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
  gem 'pry'
end

