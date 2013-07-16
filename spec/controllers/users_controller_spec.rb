require 'spec_helper'

describe UsersController do

  let(:user) { FactoryGirl.create :user }

  describe "GET 'index'" do
    before :each do
      @users = []
      3.times do
        user = FactoryGirl.create :user
        @users << user
      end
    end

    it "should render the :index view" do
      get :index
      expect(response).to render_template :index
    end
    it "should populate an array of users" do
      get :index
      expect(assigns :users).to eq(@users)
    end
  end

  describe "GET 'show'" do
    
    it "should return the :show view" do
      get :show, id: user
      expect(response).to render_template :show
    end
    it "should assign the requested user to @user" do
      get :show, id: user
      expect(assigns :user).to eq(user)
    end
  end
end
