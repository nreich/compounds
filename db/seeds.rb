# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DatabaseCleaner.clean_with(:truncation,
                           only: ['users', 'molecules', 'salts', 'batches', 'transactions']
                          )

User.delete_all
(1..9).each do |n|
  User.create!(name: "user#{n}", email: "user#{n}@example.com",
               password: "password", password_confirmation: "password")
end

Molecule.delete_all
(1..10).each do |n|
  Molecule.create!(name: "molecule #{n}", molecular_weight: 120 + 10 * n)
end

salts = %w{ unknown none hydrochloric triflouroacetate acetate formate hydrobromic methansulfonic triflourmethansulfonic ascorbate }
Salt.delete_all
salts.each { |salt| Salt.create!(name: salt, molecular_weight: 100 + rand(1..100)) }

Batch.delete_all
(0..9).each do |n|
  (0..9).each do |m|
    Batch.create!(date: DateTime.now,
                  initial_amount: 10 * (n + 1),
                  barcode: "1234#{n}#{m}", salt_id: (n % 10) + 1,
                  number_salts: 1, formula_weight: 150 + 10 * n,
                  molecule_id: n + 1 )
  end
end

Transaction.delete_all
User.all.each do |user|
  Transaction.create!(user_id: user.id, batch_id: user.id, amount: 2)
end

