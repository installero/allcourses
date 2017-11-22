source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'pg'
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'bootstrap', '~> 4.0.0.beta'
gem 'font-awesome-rails'

gem 'public_suffix' # top level domains check
gem 'commonmarker' # markdown parser used by github

gem 'simple_form'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test, :development do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'letter_opener'
  gem 'devise-bootstrapped', github: 'king601/devise-bootstrapped', branch: 'bootstrap4'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

