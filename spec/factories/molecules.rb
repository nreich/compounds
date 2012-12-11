# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :molecule do
    name "molecule_name"
    molecular_weight 125.123
    #association :batch
  end
end
