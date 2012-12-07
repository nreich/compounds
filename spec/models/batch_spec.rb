require 'spec_helper'

describe Batch do
    before :each do
        @attr = { lot_number: 1,
                  date: "2012-12-04",
                  amount: 10.2,
                  barcode: "barcode_text",
                  initial_amount: 25.1,
                  salt: 1,
                  formula_weight: "256.123",
                  molecule_id: 1
                }
    end

    it "should be valid given valid attributes" do
        @batch = Batch.new(@attr)
        @batch.should be_valid
    end

    it "should not be valid given a lot_number less than 1" do
        @batch = Batch.new(@attr.merge(lot_number: 0))
        @batch.should_not be_valid
    end

    it "should not be valid given a non-integer lot_number" do
        @batch = Batch.new(@attr.merge(lot_number: 1.5))
        @batch.should_not be_valid
    end

    it "should not be valid given a blank date" do
        @batch = Batch.new(@attr.merge(date: ""))
        @batch.should_not be_valid
    end

    it "should not be valid given a molecule_id less than 0" do
        @batch = Batch.new(@attr.merge(molecule_id: -1))
        @batch.should_not be_valid
    end

    it "should not be valid given a non-integer molecule_id" do
        @batch = Batch.new(@attr.merge(molecule_id: 1.5))
        @batch.should_not be_valid
    end
end
