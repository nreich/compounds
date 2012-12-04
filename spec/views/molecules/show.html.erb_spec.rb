require 'spec_helper'

describe "molecules/show" do
  before(:each) do
    @molecule = assign(:molecule, stub_model(Molecule,
      :name => "Name",
      :molecular_weight => "Molecular Weight"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Molecular Weight/)
  end
end
