class Batch < ActiveRecord::Base
  attr_accessible :amount, :barcode, :date, :formula_weight, :initial_amount, :molecule_id, :lot_number, :salt
  belongs_to :molecule
  validates :date, format: {with: /\A\d{4}-\d{2}-\d{2}/,
      message: "Must have a batch date of format: dddd-dd-dd"}
  validates :molecule_id, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :lot_number, presence: true, numericality: {only_integer: true, greater_than: 0}
end
