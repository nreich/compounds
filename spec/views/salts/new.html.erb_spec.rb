require 'spec_helper'

describe "salts/new" do
  before(:each) do
    assign(:salt, stub_model(Salt,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new salt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => salts_path, :method => "post" do
      assert_select "input#salt_name", :name => "salt[name]"
    end
  end
end
