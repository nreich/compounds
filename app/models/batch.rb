class Batch < ActiveRecord::Base
  attr_accessible :amount, :barcode, :date, :formula_weight, :initial_amount, :molecule_id, :lot_number, :salt_id
  belongs_to :molecule
  belongs_to :salt
  has_many :transactions
  before_create :set_amount_on_creation
  before_validation :set_lot_number
  validates :date, format: {with: /\A\d{4}-\d{2}-\d{2}/,
      message: "Must have a batch date of format: dddd-dd-dd"}
  validates :molecule_id, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :lot_number, presence: true, numericality: {only_integer: true, greater_than: 0}

  private

    #Generally, amount will be the same as current amount on creation of batch
    def set_amount_on_creation
      self.amount ||= self.initial_amount
    end

    def set_lot_number
      unless self.lot_number
        highest_number = Batch.where(molecule_id: molecule_id).
          maximum('lot_number')
        self.lot_number = highest_number + 1
      end
    end

end
