FactoryGirl.define do
  factory :course do
    sequence(:title) {|n| "Course ##{n}"}
    sequence(:genre) {|n| n % 10}
    sequence(:url) {|n| "http://example#{n % 10}.edu/course-#{n}-url/"}

    association(:provider)
    association(:creator, factory: :user)

    description 'Это супер-пупер курс на неизвестную никому тему!'
  end
end
