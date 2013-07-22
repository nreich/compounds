require 'spec_helper'

describe SaltsController do

  let(:salt) { FactoryGirl.create :salt }
  let(:salt_params) { FactoryGirl.attributes_for :salt }
  let(:user) { FactoryGirl.create :user }

  context 'for a normal user' do

    before :each do
      sign_in user 
    end
  
    describe 'GET index' do
      before :each do
        @salts = []
        3.times { @salts << FactoryGirl.create(:salt) }
      end

      it 'assigns all salts as @salts' do
        get :index
        expect(assigns :salts).to eq(@salts)
      end
    end

    describe 'GET show' do
      it 'assigns the requested salt as @salt' do
        get :show, { id: salt.to_param }
        expect(assigns :salt).to eq(salt)
      end
    end

    describe 'GET new' do
      it 'redirects to home page' do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe 'GET edit' do
      it 'redirects to home page' do
        get :edit, { id: salt.to_param }
        expect(response).to redirect_to root_path
      end
    end

    describe 'POST create' do
      it 'does not create a new Salt' do
        expect {
          post :create, { salt: salt_params }
        }.to_not change(Salt, :count)
      end
    end
    describe 'PUT update' do
      it 'does not update the salt' do
        put :update, { id: salt.to_param, salt: { name: "new name" }}
        expect(Salt.find(salt.id).name).to_not eq("new name" )
      end
    end
    describe 'DELETE destroy' do
      it 'does not destroy the requested salt' do
        salt
        expect {
          delete :destroy, { id: salt.to_param }
        }.to change(Salt, :count).by(0)
      end
    end

  end

  context 'for an admin' do
    
    before :each do
     user.add_role :admin
     sign_in user
    end 

    describe 'GET new' do
      it 'assigns a new salt as @salt' do
        get :new
        expect(assigns :salt).to be_a_new(Salt)
      end
    end

    describe 'GET edit' do
      it 'assigns the requested salt as @salt' do
        get :edit, { id: salt.to_param }
        expect(assigns :salt).to eq(salt)
      end
    end

    describe 'POST create' do
      context 'with valid params' do
        it 'creates a new Salt' do
          expect {
            post :create, { salt: salt_params }
          }.to change(Salt, :count).by(1)
        end
        it 'assigns a newly created salt as @salt' do
          post :create, salt: salt_params
          expect(assigns :salt).to be_a(Salt)
          expect(assigns :salt).to be_persisted
        end
        it 'redirects to the created salt' do
          post :create, salt: salt_params
          expect(response).to redirect_to Salt.last
        end
      end
      context 'with invalid params' do
        let(:invalid_params) { salt_params.merge(name: "") }

        it 'assigns a newly created but unsaved salt as @salt' do
          post :create, { salt: invalid_params }
          expect(assigns :salt).to be_a_new(Salt)
        end
        it 're-render the "new" template' do
          post :create, { salt: invalid_params }
          expect(response).to render_template "new"
        end
      end
    end

    describe 'PUT update' do
      context 'with valid params' do
        before :each do
          put :update, { id: salt.to_param, salt: { name: "new name" }}
        end

        it 'updates the requested salt' do
          expect(Salt.find(salt.id).name).to eq("new name" )
        end
        it 'assigns the requested salt as @salt' do
          expect(assigns :salt).to eq(salt)
        end
        it 'redirect to the salt' do
          expect(response).to redirect_to salt
        end
      end
      context 'with invalid params' do
        before :each do
          put :update, { id: salt.to_param, salt: { molecular_weight: "not a #" }}
        end

        it 'assigns the salt as @salt' do
          expect(assigns :salt).to eq(salt)
        end
        it 're-renders the "edit" template' do
          expect(response).to render_template "edit"
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested salt' do
        salt
        expect {
          delete :destroy, { id: salt.to_param }
        }.to change(Salt, :count).by(-1)
      end
      it 'redirects to the salts list' do
        delete :destroy, { id: salt.to_param }
        expect(response).to redirect_to salts_url
      end
    end
  end

end
