# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActionMailer::Base.perform_deliveries = false

20.times do
  FactoryGirl.create(:user, email: "user#{SecureRandom.hex(3)}@example.com")
end

10.times do
  num = SecureRandom.hex(2)
  url = "http://example#{num}.edu/course-#{num}-url/"
  FactoryGirl.create(:course, url: url, creator: User.all.sample)
end

user_course_pairs = User.all.to_a.product(Course.all.to_a)
user_course_pairs.each {|i| FactoryGirl.create(:review, course: i[1], user: i[0])}
