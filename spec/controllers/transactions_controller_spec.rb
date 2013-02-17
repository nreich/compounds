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

  describe "POST 'create'" do

    before :each do
      @batch = FactoryGirl.create(:batch)
      @user = FactoryGirl.create(:user)
      sign_in @user
      @attr = { amount: 1.5 }
    end

    describe "success" do

      it "should create a new transaction given valid attributes" do
        lambda do
          post :create, transaction: @attr, batch_id: @batch.id
        end.should change(Transaction, :count).by(1)
      end

      it "should redirect to the batch" do
        post :create, transaction: @attr, batch_id: @batch.id
        response.should redirect_to(@batch)
      end

      it "should have a flash message of success" do
        post :create, transaction: @attr, batch_id: @batch.id
        flash[:success].should =~ /transaction successful/i
      end

    end

    describe "failure" do

      it "should not create a new transaction given invalid attributes" do
        lambda do
          post :create, transaction: @attr.merge(amount: 100000),
                        batch_id: @batch.id
        end.should_not change(Transaction, :count)
      end

      it "should redirect to the batch" do
        post :create, transaction: @attr.merge(amount: 100000),
                      batch_id: @batch.id
        response.should redirect_to(@batch)
      end

      it "should have a flash message notifying of failure" do
        post :create, transaction: @attr.merge(amount: 100000),
                      batch_id: @batch.id
        flash[:notice].should =~ /transaction failed/i
      end

    end

  end


end
