class Transaction < ActiveRecord::Base
  resourcify
  attr_accessible :amount, :batch_id, :user_id
  belongs_to :batch
  belongs_to :user

  #transaction must remove some amount of the batch
  validates :amount, numericality: { greater_than: 0 }
  validate :amount_not_larger_than_current_batch_amount
  
  before_save do |transaction|
    transaction.amount = amount.truncate(1)
  end
  after_save :update_batch_amount

  protected
    def amount_not_larger_than_current_batch_amount
      batch_amount = Batch.find(batch_id).amount
      if amount > batch_amount
        errors.add(:amount, "cannot be more than amount availible")
      end
    end

    def update_batch_amount
      batch = Batch.find(batch_id)
      new_batch_amount = batch.amount - amount
      batch.update_attribute('amount', new_batch_amount)
    end
end

