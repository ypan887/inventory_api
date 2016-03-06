source 'https://rubygems.org'

ruby "2.3.0"

gem 'rails', '4.2.5'
gem "active_model_serializers", github: "rails-api/active_model_serializers"

group :development, :test do
  gem 'spring'  
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
end

group :production do
  gem 'pg'
end
