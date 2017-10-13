FactoryGirl.define do
  factory :provider do
    sequence(:title) {|n| "Rrovider ##{n}"}
    sequence(:domain) {|n| "example#{n}.edu"}
  end
end
