require 'spec_helper'

describe "batches/show" do
  before(:each) do
    @batch = assign(:batch, stub_model(Batch,
      :number => 1,
      :amount => 1.5,
      :barcode => "Barcode",
      :initial_amount => 1.5,
      :salt => 2,
      :formula_weight => "9.99",
      :molecule_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/Barcode/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
    rendered.should match(/9.99/)
    rendered.should match(/3/)
  end
end
