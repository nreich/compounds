require 'spec_helper'

describe Batch do
    before :each do
        @molecule = FactoryGirl.create :molecule
        @attr = { lot_number: 1,
                  date: "2012-12-04",
                  amount: 10.2,
                  barcode: "barcode_text",
                  initial_amount: 25.1,
                  salt_id: 1,
                  formula_weight: "256.123",
                  molecule_id: 1
                }
    end

    it "should be valid given valid attributes" do
        @batch = @molecule.batches.new(@attr)
        @batch.should be_valid
    end

    it "should not be valid given a non-integer lot_number" do
        @batch = @molecule.batches.new(@attr.merge(lot_number: 1.5))
        @batch.should_not be_valid
    end

    it "should not be valid given a blank date" do
        @batch = @molecule.batches.new(@attr.merge(date: ""))
        @batch.should_not be_valid
    end

    it "should have initial and current amount the same if current amount not specified" do
      @batch = @molecule.batches.new(@attr.merge(amount: nil))
      @batch.save
      @batch.amount.should eq(@batch.initial_amount)
    end

    describe "molecule relationship" do

        it "should have a relationship with a molecule" do
            @batch = @molecule.batches.new(@attr)
            @batch.should respond_to :molecule
        end

        it "should belong to the right molecule" do
            @batch = @molecule.batches.new(@attr)
            @batch.molecule.should == @molecule
        end

    end

    describe "assosciations" do

        it "should have a relationship with a salt" do
            @batch = @molecule.batches.new(@attr)
            @batch.should respond_to :salt
        end

        it "should have the right salt" do
            @salt = Salt.create({ name: "trifluoroacetate"})
            @batch = @molecule.batches.new(@attr.merge(salt_id: @salt.id))
            @batch.salt.name.should == @salt.name
        end

        it "should have a relationship with transactions" do
          @batch = @molecule.batches.new(@attr)
          @batch.should respond_to :transactions
        end

        it "should have the right transaction" do
          @batch = @molecule.batches.new(@attr) 
          @transaction = @batch.transactions.new(amount: 1)
          @batch.transactions.first.should equal(@transaction)
        end
      

    end
end
