# Steps

* rails new allcourses -T --skip-spring --skip-turbolinks
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
* Add redcarpet to Review

TBD

Views and controllers...
  custom devise form messages:
    https://github.com/plataformatec/devise/wiki/How-To:-Integrate-I18n-Flash-Messages-with-Devise-and-Bootstrap
    кастомазация лэйаута и связанных вьюх, включая сгенеренные девайзовские
