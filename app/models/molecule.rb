class Molecule < ActiveRecord::Base
  attr_accessible :molecular_weight, :name
  has_many :batches
  validates :name, presence: true, uniqueness: true
  validates :molecular_weight, presence: true
end
