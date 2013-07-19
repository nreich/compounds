class Salt < ActiveRecord::Base
  attr_accessible :name, :molecular_weight

  validates :name, :molecular_weight, presence: true
  validates :molecular_weight, numericality: { greater_than_or_equal_to: 0 }
end
