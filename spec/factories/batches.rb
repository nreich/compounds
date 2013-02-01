# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :batch do
    sequence(:lot_number) { |n| n }
    date "2012-12-04"
    amount 1000.5
    barcode "barcode"
    initial_amount 1000.5
    salt_id 1
    formula_weight "9.998"
    association :molecule
  end
end
