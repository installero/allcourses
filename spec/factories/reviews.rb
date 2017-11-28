FactoryBot.define do
  factory :review do
    association(:user)
    association(:course)
    sequence(:rating) {|n| n % 2 == 0 ? nil : n % 5 + 1}
    text 'ну так себе курс'
    html '<p>ну так себе курс</p>'
  end
end
