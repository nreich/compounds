require 'spec_helper'

describe TransactionsController do

  let(:transaction) { FactoryGirl.create :transaction, batch: batch }
  let(:transaction_params) { FactoryGirl.attributes_for(:transaction,
                              batch: batch).merge(batch_id: batch.id) }
  let(:molecule) { FactoryGirl.create :molecule }
  let(:batch) { FactoryGirl.create :batch }
  let(:user) { FactoryGirl.create :user }

  context 'for a normal user' do
    before :each do
      sign_in user
    end

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
      it "should return the :show view" do
        get :show, id: transaction
        expect(response).to render_template :show
      end
      it "should assign the requested transaction to @transaction" do
        get :show, id: transaction
        expect(assigns :transaction).to eq(transaction)
      end
    end

    describe "POST 'create'" do
      describe "success" do
        it "should create a new transaction given valid attributes" do
          expect {
            post :create, transaction: transaction_params
          }.to change(Transaction, :count).by(1)
        end
        it "should redirect to the batch" do
          post :create, transaction: transaction_params
          expect(response).to redirect_to(
            batch_path transaction_params[:batch_id])
        end
        it "should have a flash message of success" do
          post :create, transaction: transaction_params
          flash[:success].should =~ /transaction successful/i
        end
      end

      describe "failure" do
        it "should not create a new transaction given invalid attributes" do
          expect {
            post :create, transaction: transaction_params.merge(amount: 100000)
          }.to_not change(Transaction, :count)
        end
        it "should redirect to the batch" do
          post :create, transaction: transaction_params.merge(amount: 100000)
          expect(response).to redirect_to(batch)
        end
        it "should have a flash message notifying of failure" do
          post :create, transaction: transaction_params.merge(amount: 100000)
          expect(flash[:notice]).to  match /transaction failed/i
        end
      end
    end
  end

  context 'for an admin' do
    before :each do
      user.add_role :admin
      sign_in user
    end

    describe 'GET edit' do
    end
  end



end
