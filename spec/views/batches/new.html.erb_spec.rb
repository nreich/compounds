require 'spec_helper'

describe "batches/new" do
  before(:each) do
    assign(:batch, stub_model(Batch,
      :number => 1,
      :amount => 1.5,
      :barcode => "MyString",
      :initial_amount => 1.5,
      :salt => 1,
      :formula_weight => "9.99",
      :molecule_id => 1
    ).as_new_record)
  end

  it "renders new batch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => batches_path, :method => "post" do
      assert_select "input#batch_number", :name => "batch[number]"
      assert_select "input#batch_amount", :name => "batch[amount]"
      assert_select "input#batch_barcode", :name => "batch[barcode]"
      assert_select "input#batch_initial_amount", :name => "batch[initial_amount]"
      assert_select "input#batch_salt", :name => "batch[salt]"
      assert_select "input#batch_formula_weight", :name => "batch[formula_weight]"
      assert_select "input#batch_molecule_id", :name => "batch[molecule_id]"
    end
  end
end
