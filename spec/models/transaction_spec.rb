require 'spec_helper'
require 'pry'
describe Transaction do
  
  subject(:transaction) { FactoryGirl.create :transaction, batch: batch,
                                              user: user }
  let(:transaction_params) { FactoryGirl.attributes_for(:transaction,
                                          batch: batch) }
  let(:batch) { FactoryGirl.create :batch, molecule: molecule }
  let(:molecule) { FactoryGirl.create :molecule }
  let(:user) { FactoryGirl.create :user }

  it { should respond_to :amount }
  it { should respond_to :user }
  it { should respond_to :batch }

  describe 'new transaction' do
    context 'with valid params' do
      it 'should create a new transaction' do
        new_transaction = batch.transactions.create!(transaction_params)
      end
      it 'should remove the correct amount from the batch' do
        expect {
          new_transaction = batch.transactions.create(transaction_params)
        }.to change(batch, :amount).by(-1 * transaction_params[:amoun].to_f)
      end
      it 'should round the amount to the nearest 0.1' do
        new_transaction1 = batch.transactions.create(transaction_params.
                                                     merge(amount: 1.11))
        new_transaction2 = batch.transactions.create(transaction_params.
                                                     merge(amount: 1.15))
        new_transaction3 = batch.transactions.create(transaction_params.
                                                     merge(amount: 1.16))
        expect(new_transaction1.amount).to eq(1.1)
        expect(new_transaction2.amount).to eq(1.2)
        expect(new_transaction3.amount).to eq(1.2)
      end

    end
    context 'with invalid params' do
      it 'should not accept an amount of 0' do
        new_transaction = batch.transactions.new(transaction_params.
                                                 merge(amount: 0))
        expect(new_transaction).to_not be_valid
      end
      it 'should not accept negative amounts' do
        new_transaction = batch.transactions.new(transaction_params.
                                                 merge(amount: -10))
        expect(new_transaction).to_not be_valid
      end
      context 'where amount is larger than that availible' do
        it 'does not create a new transaction' do
          too_big_transaction = batch.transactions.new(transaction_params.
                                                      merge(amount: 10000))
          expect(too_big_transaction).to_not be_valid
        end
        it 'does not change the amount left in the batch' do
          expect {
            too_big_transaction = batch.transactions.new(transaction_params.
                                                        merge(amount: 10000))
          }.to_not change(batch, :amount)
        end
      end
    end
  end

end
