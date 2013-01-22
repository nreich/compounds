require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    before :each do
      @users = []
      3.times do
        user = FactoryGirl.create(:user)
        @users << user
      end
    end

    it "should return the :index view" do
      get :index
      response.should render_template :index
    end

    it "should populate an array of contacts" do
      get :index
      assigns(:users).should eq(@users)
    end
  end

  describe "GET 'show'" do
    
    before :each do
      @user = FactoryGirl.create(:user)
    end
    
    it "should return the :show view" do
      get :show, id: @user
      response.should render_template :show
    end
    
    it "should assign the requested user to @user" do
      get :show, id: @user
      assigns(:user).should eq(@user)
    end

  end

end
