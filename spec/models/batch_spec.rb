require 'spec_helper'

describe Batch do
  subject(:batch) { FactoryGirl.create :batch }
  let(:molecule) { FactoryGirl.create :molecule }
  before :each do
    @molecule = FactoryGirl.create :molecule
    @attr = { lot_number: 1,
              date: "2012-12-04",
              amount: 10.2,
              barcode: "barcode_text",
              initial_amount: 25.1,
              salt_id: 3,
              formula_weight: "256.123",
              molecule_id: 1,
              number_salts: 1
            }
  end

  it { should respond_to :lot_number }
  it { should respond_to :date }
  it { should respond_to :amount }
  it { should respond_to :initial_amount }
  it { should respond_to :barcode }
  it { should respond_to :formula_weight }
  it { should respond_to :salt }
  it { should respond_to :molecule }
  it { should respond_to :number_salts }

  describe 'new batch' do
    let(:attr) { Hash[lot_number: 1, date: "2012-12-04", amount: 10.2,
      barcode: "barcode_text", initial_amount: 25.1, salt_id: 3,
      formula_weight: "256.123", molecule_id: 1, number_salts: 1] }

    context 'with valid attributes' do
      it 'should be valid' do
        new_batch = molecule.batches.new(attr)
        expect(new_batch).to be_valid
      end
    end
    context 'when a lot number is not given' do
      context 'if this is the first batch of a molecule' do
        it 'should set the lot number to 1' do
          attr.delete(:lot_number)
          first_batch = molecule.batches.create(attr)
          expect(first_batch.lot_number).to eq(1)
        end
      end
      context 'if this is not the first batch of a molecule' do
        it 'should set lot number one more than highest lot numbered batch of that molecule' do
          previous_batch = FactoryGirl.create :batch, molecule: molecule
          previous_lot_number = previous_batch.lot_number
          attr.delete(:lot_number)
          new_batch = molecule.batches.create(attr)
          expect(new_batch.lot_number).to eq(previous_lot_number + 1)
        end
      end
    end
    context 'when no salt is *unknown*' do
      it 'should set number of salts to 0' do
        unknown_salt_batch = molecule.batches.create(attr.merge(salt_id: 1))
        expect(unknown_salt_batch.number_salts).to eq(0)
      end
    end
    context 'when salt of *none* is given' do
      it 'should set number of salts to 0' do
        no_salt_batch = molecule.batches.create(attr.merge(salt_id: 2))
        expect(no_salt_batch.number_salts).to eq(0)
      end
    end
    context 'with invalid attributes' do
      it 'should not be valid if lot_number is not an integer' do
        new_batch = molecule.batches.new(attr.merge(lot_number: 1.5))
        expect(new_batch).to_not be_valid
      end
      it 'should not be valid if date is not properly formatted' do
        new_batch = molecule.batches.new(attr.merge(date: "5-6-75"))
        expect(new_batch).to_not be_valid
      end
      it 'should not be valid if number of salts not given' do
        new_batch = molecule.batches.new(attr.merge(number_salts: ""))
        expect(new_batch).to_not be_valid
      end
      it 'should not be valid if a salt in not given' do
        new_batch = molecule.batches.new(attr.merge(salt_id: ""))
        expect(new_batch).to_not be_valid
      end
    end      
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
