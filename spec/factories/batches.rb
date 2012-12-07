# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :batch do
    lot_number 1
    date "2012-12-04"
    amount 1.5
    barcode "barcode"
    initial_amount 1.5
    salt 1
    formula_weight "9.998"
    molecule_id 1
  end
end