require 'spec_helper'

describe Molecule do

    before :each do
        @attr = { name: "new molecule", molecular_weight: 123.456 }
    end

    it "should create a new molecule given valid attributes" do
        @molecule = Molecule.create(@attr)
        @molecule.should be_valid
    end

    it "should not create a molecule without a name" do
        @molecule = Molecule.create(@attr.merge(name: ""))
        @molecule.should_not be_valid
    end

    it "should not allow a molecule without a molecular weight" do
        @molecule = Molecule.create(name: "no mw molecule")
        @molecule.should_not be_valid
    end

    it "should not create a molecule with a duplicate name" do
        @molecule = Molecule.create(@attr)
        @molecule2 = Molecule.create(@attr)
        @molecule2.should_not be_valid
    end

end
