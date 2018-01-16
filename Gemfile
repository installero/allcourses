source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta'
gem 'carrierwave', '~> 1.0'
gem 'commonmarker'
gem 'devise'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'letter_avatar'
gem 'mini_magick'
gem 'omniauth-facebook'
gem 'pg', '~> 0.18'
gem 'public_suffix'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'uglifier', '>= 1.3.0'

group :test, :development do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'shoulda-matchers'
end

group :development do
  gem 'capistrano', '~> 3.7'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
