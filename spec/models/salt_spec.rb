require 'spec_helper'

describe Salt do

    before :each do
        @attr = { name: "Hydroclorate" }
    end

    it "should have a name attribute" do
        @salt = Salt.new(@attr)
        @salt.should respond_to :name
    end

end
