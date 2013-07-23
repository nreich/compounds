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

  before :each do
    @user = FactoryGirl.create(:user)
    @batch = FactoryGirl.create(:batch, amount: 1000)
    @attr = { amount: 10, user_id: @user.id }
  end

  describe 'new transaction' do
    context 'with valid params' do
      it 'should create a new transaction' do
        new_transaction = batch.transactions.create!(transaction_params)
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

  it "should create a new instance given valid attributes" do
    @transaction = @batch.transactions.new(@attr)
    @transaction.should be_valid
  end

  it "should not accept an amount of 0" do
    @transaction = @batch.transactions.new(amount: 0)
    @transaction.should_not be_valid
  end

  it "should not accept negative amounts" do
    @transaction = @batch.transactions.new(amount: -10)
    @transaction.should_not be_valid
  end

  it "should not accept amounts larger than the current size of the batch" do
    @transaction = @batch.transactions.new(amount: 100000)
    @transaction.save.should_not be_true
  end

  it "should round amounts to the nearest 0.1" do
    @transaction = @batch.transactions.create(amount: 1.11)
    @transaction.amount.should == 1.1
  end

  describe "assosciations" do

    before :each do
      @transaction = @batch.transactions.new(@attr)
    end

    describe "with batch" do

      it "should have a relationship with a batch" do
        @transaction.should respond_to :batch
      end

     it "should belong to the right batch" do
        @transaction.batch.should == @batch
      end

      it "should remove the right amount from a batch when saved" do
        amount_before = @batch.amount
        @transaction.save!
        @batch.reload
        amount_after = @batch.amount
        @transaction.amount.should == amount_before - amount_after
      end
    end

    describe "with user" do

      it "should have a relationship with a user" do
        @transaction.should respond_to :user
      end

      it "should have the right user" do
        @transaction.user.should == @user
      end

    end

  end

end
