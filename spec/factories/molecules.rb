# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :molecule do
    sequence(:name) { |n| "molecule #{n}" }
    molecular_weight 125.123
    #association :batch
  end
end
