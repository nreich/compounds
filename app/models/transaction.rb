class Transaction < ActiveRecord::Base
  attr_accessible :amount, :batch_id, :user_id
  belongs_to :batch

  #transaction must remove some amount of the batch
  validates :amount, numericality: { greater_than: 0 }
  validate :amount_not_larger_than_current_batch_amount
  
  before_save do |transaction|
    transaction.amount = amount.truncate(1)
  end

  protected
    def amount_not_larger_than_current_batch_amount
      batch_amount = Batch.find(batch_id).amount
      if amount > batch_amount
        errors.add(:amount, "cannot be more than amount availible")
      end
    end
end

