# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :salt do
    sequence(:name) {|n| "salt#{n}" }
    molecular_weight 100
  end
end
