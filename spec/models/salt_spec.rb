require 'spec_helper'

describe Salt do

  subject(:salt) { FactoryGirl.create(:salt) }
  let(:attr) { Hash[name: "Acetate", molecular_weight: 100] }


  it { should respond_to :name }
  it { should respond_to :molecular_weight }

  describe 'new salt' do
    context 'given valid attributes' do
      let(:attr) { Hash[name: "Acetate", molecular_weight: 100] }
      it 'should be valid' do
        salt = Salt.new(attr)
        expect(salt).to be_valid
      end
    end
    context 'given invalid attributes' do
      it 'should be invalid without a name' do
        salt = Salt.new(attr.merge(name: ""))
        expect(salt).to_not be_valid
      end
      it 'should be invalid without a molecular weight' do
        attr.delete(:molecular_weight)
        salt = Salt.new(attr)
        expect(salt).to_not be_valid
      end
      it 'should be invalid with a non-numeric molecular weight' do
        salt = Salt.new(attr.merge(molecular_weight: "non a number"))
        expect(salt).to_not be_valid
      end
      it 'should be invalid if molecular weight is negative' do
        salt = Salt.new(attr.merge(molecular_weight: -1))
        expect(salt).to_not be_valid
      end
    end
  end
end
