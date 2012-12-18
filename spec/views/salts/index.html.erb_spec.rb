require 'spec_helper'

describe "salts/index" do
  before(:each) do
    assign(:salts, [
      stub_model(Salt,
        :name => "Name"
      ),
      stub_model(Salt,
        :name => "Name"
      )
    ])
  end

  it "renders a list of salts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
