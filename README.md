# IMDB for online courses
[Allcours.es](http://Allcours.es) — independent online courses database with ratings, reviews and 
personal course information.  
*v. 0.1.0, not released yet* 

# Open source
You can make a difference by contributing to this project and spreading the word. 

**Developer** — follow the [Setup guide](#setup-guide) and send us your pull-requests.  
**Not** developer — welcome to share your ideas and thoughts on *hi@allcours.es*

**License**  
Any commercial use of the code or any part of it aside of the allcours.es website should be 
explicitely approved by the founders Michael Butlitsky (@aristofun) and Vadim Venediktov (@installero).

# TODO
A bunch of things to implement for the release, before talking roadmaps: 

- [x] ~~Invisible recaptcha on signup & adding new course~~
- [ ] Fetch course info using course URL from popular providers
- [ ] Complete course CRUD
- [ ] Complete Review CRUD
- [ ] Review Lists in user profile, in index page, on the course page
- [ ] Course Lists by genre, in user profile ("courses he had taken") with sorting by date, by rating
- [ ] Add autocontent generator to dev using Faker gem
- [ ] Create privacy policy page to enable Facebook log in (in dev mode now)
- [ ] Restrict users to update their own profile only (every one can update anybody's profile now)
- [ ] Index page filled with recently added courses and reviews
- [ ] Log in using Google, Github
- [ ] Show users' ratings on course page, course partial etc.
- [ ] customize devise form messages [howto](https://github.com/plataformatec/devise/wiki/How-To:-Integrate-I18n-Flash-Messages-with-Devise-and-Bootstrap)
- [ ] Personal course notes feature (MD private richtext area)
- [x] ~~Configure email notifications (to confirm users, for example)~~
- [x] ~~Log in using Facebook~~
- [x] ~~Default user avatars~~
- [ ] Favicon

# Setup guide

This is Rails 5, ruby 2.4.1, Postgres 9.6, Capistrano 3, nginx-passenger web application 
living at [Allcours.es](http://Allcours.es). Master branch is deployed by product owners (@installero, @aristofun) on a regular basis.

## 1. Ready
* Install and setup Postgres 9.6 locally.  
* Ruby 2.4.1 using RBENV/RVM is recommended.  

## 2. Steady
Set up your local Postgres DB. **Beware of collation and ctype**, we use UTF8 and en_US.UTF-8

For example:
 
``` sh
> psql
CREATE USER username_for_allcourses WITH PASSWORD '<your password>' CREATEDB REPLICATION CONNECTION LIMIT 10;
CREATE DATABASE db_name_for_dev WITH LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' ENCODING=UTF8 OWNER=username_for_allcourses;
CREATE DATABASE db_name_for_test WITH LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' ENCODING=UTF8 OWNER=username_for_allcourses;
```
 
Check connection:

```
psql -h localhost -U <username_for_allcourses> -W <db_name_for_(dev|test)>
```

## 3. Go!
* Download the code (fork/clone repo)
* `bundle install`
* `bundle exec rails db:migrate`
* Configure your copy of `config/database.yml` according to your Postgres configuration 
* Configure your copy of `config/secrets.yml` according to secrets.example.yml 

Now you can run it locally  `bundle exec rails s`.
Specs `bundle exec rspec`


# Devlog
*This chapter to be erased after release*

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
