# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example_#{n}@example.com" }
    name "John Doe"
    password "password"
    password_confirmation "password"
  end
end
