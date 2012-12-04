class Molecule < ActiveRecord::Base
  attr_accessible :molecular_weight, :name

  validates :name, presence: true, uniqueness: true
  validates :molecular_weight, presence: true
end
