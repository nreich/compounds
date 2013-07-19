class Batch < ActiveRecord::Base
  attr_accessible :amount, :barcode, :date, :initial_amount, :molecule_id, :lot_number, :salt_id, :number_salts
  belongs_to :molecule
  belongs_to :salt
  has_many :transactions
  before_create :set_amount_on_creation
  before_save :calculate_fw
  before_validation :set_lot_number, :check_salt
  validates :date, format: {with: /\A\d{4}-\d{2}-\d{2}/,
      message: "Must have a batch date of format: dddd-dd-dd"}
  validates :molecule_id, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :lot_number, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :number_salts, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :salt_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  private

    #Generally, amount will be the same as current amount on creation of batch
    def set_amount_on_creation
      self.amount ||= self.initial_amount
    end
    
    #There are two special case salts: 'unknown' => 1 and 'none' => 2
    #each should have 0 for number of salts
    def check_salt
      if self.salt_id == 1 || self.salt_id == 2
        self.number_salts = 0
      end
    end

    def set_lot_number
      unless self.lot_number
        highest_number = Batch.where(molecule_id: molecule_id).
          maximum('lot_number')
        if highest_number
          self.lot_number = highest_number + 1
        else
          self.lot_number = 1
        end
      end
    end

    def calculate_fw
      self.formula_weight = self.molecule.molecular_weight
      + self.salt.molecular_weight * self.number_salts
    end

end
