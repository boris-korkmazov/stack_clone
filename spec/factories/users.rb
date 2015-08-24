FactoryGirl.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end
  factory :user do
    email
    password '12345678'
  end

end