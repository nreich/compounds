require 'spec_helper'

describe Transaction do
  
  before :each do
    @user = FactoryGirl.create(:user)
    @batch = FactoryGirl.create(:batch, amount: 1000)
    @attr = { amount: 10 }
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

    it "should have a relationship with a batch" do
      @transaction.should respond_to :batch
    end

    it "should belong to the right batch" do
      @transaction.batch.should == @batch
    end

  end

end
