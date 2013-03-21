# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
10.times do |n|
  User.create!(name: "user#{n}", email: "user#{n}@example.com",
               password: "password", password_confirmation: "password")
end

Molecule.delete_all
10.times do |n|
  Molecule.create!(name: "molecule #{n}", molecular_weight: 120 + 10 * n)
end

Salt.delete_all
10.times do |n|
  Salt.create!(name: "salt #{n}")
end

Batch.delete_all
10.times do |n|
  n.times do
    Batch.create!(lot_number: n, date: DateTime.now, initial_amount: 10 * n,
                  barcode: "1234#{n}", salt_id: n, formula_weight: 150 + 10 * n,
                  molecule_id: n)
  end
end

Transaction.delete_all
User.all.each do |user|
  Transaction.create!(user_id: user.id, batch_id: user.id, amount: 2)
end

