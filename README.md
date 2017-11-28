# Development log

* App created  
  ```
  rails new allcourses -T --skip-spring --skip-turbolinks
  ```  
* pushed to bitbucket
* added bootstrap 4: https://github.com/twbs/bootstrap-rubygem
* added rspec: https://github.com/rspec/rspec-rails
* added guard: https://github.com/guard/guard https://github.com/guard/guard-rspec
* Provider + Course models added
* DB setup
  CREATE USER allcourses WITH PASSWORD '*' CREATEDB REPLICATION CONNECTION LIMIT 10;
  rails db:create
  rails db:migrate
  rails db:test:prepare
* Add devise User
  rails g devise:install
  rails db:migrate
  rails g devise User
  rails db:migrate
  rails g devise:views:bootstrapped (https://github.com/king601/devise-bootstrapped)
* Add letter_opener
* Provider validations & specs (+ shoulda matcher)
* Course validations
* Add Review model
* Add CommonMarker to Review
* Add carrierwave picture to Course
  https://github.com/carrierwaveuploader/carrierwave

## Capistrano setup

* Gemfile `:development`   
  `gem 'capistrano', '~> 3.7'
   gem 'capistrano-rails', '~> 1.2'
   gem 'capistrano-passenger', '~> 0.2'
   gem 'capistrano-rbenv', '~> 2.1'`
* `cap install STAGES=production`
* To the END of Capfile   
 ```
  require 'capistrano/rbenv'
  require 'capistrano/rails'
  require 'capistrano/passenger'
  
  set :rbenv_type, :user
  set :rbenv_ruby, '2.4.1'
  ```
* deploy.rb  
```
set :application, 'allcourses'
set :repo_url, 'git@github.com:installero/allcourses.git'
set :deploy_to, '/home/deploy/apps/allcourses'
append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'
```
* deploy/production.rb  
  `server 'allcours.es', user: 'deploy', roles: %w{app db web}`
* production.rb mailer options set up
* nginx configuration step, no new code
  

  
# TBD

- Views and controllers...
- custom devise form messages:  
  [https://github.com/plataformatec/devise/wiki/How-To:-Integrate-I18n-Flash-Messages-with-Devise-and-Bootstrap]
- кастомазация лэйаута и связанных вьюх, включая сгенеренные девайзовские
- Имя+Фамилия и невидимая Рекапча на девайзовскую регистрацию

