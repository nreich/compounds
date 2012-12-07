require 'spec_helper'

describe "batches/index" do
  before(:each) do
    assign(:batches, [
      stub_model(Batch,
        :number => 1,
        :amount => 1.5,
        :barcode => "Barcode",
        :initial_amount => 1.5,
        :salt => 2,
        :formula_weight => "9.99",
        :molecule_id => 3
      ),
      stub_model(Batch,
        :number => 1,
        :amount => 1.5,
        :barcode => "Barcode",
        :initial_amount => 1.5,
        :salt => 2,
        :formula_weight => "9.99",
        :molecule_id => 3
      )
    ])
  end

  it "renders a list of batches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Barcode".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
