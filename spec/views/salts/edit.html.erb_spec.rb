require 'spec_helper'

describe "salts/edit" do
  before(:each) do
    @salt = assign(:salt, stub_model(Salt,
      :name => "MyString"
    ))
  end

  it "renders the edit salt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => salts_path(@salt), :method => "post" do
      assert_select "input#salt_name", :name => "salt[name]"
    end
  end
end
