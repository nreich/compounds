require 'spec_helper'

describe TransactionsController do

  describe "GET 'index'" do
    before :each do
      @transactions = []
      3.times do
        transaction = FactoryGirl.create(:transaction)
        @transactions << transaction
      end
    end

    it "should return the :index view" do
      get :index
      response.should render_template :index
    end

    it "should populate an array of contacts" do
      get :index
      assigns(:transactions).should eq(@transactions)
    end
  end

  describe "GET 'show'" do

    before :each do
      @transaction = FactoryGirl.create(:transaction)
    end

    it "should return the :show view" do
      get :show, id: @transaction
      response.should render_template :show
    end

    it "should assign the requested transaction to @transaction" do
      get :show, id: @transaction
      assigns(:transaction).should eq(@transaction)
    end

  end


end
