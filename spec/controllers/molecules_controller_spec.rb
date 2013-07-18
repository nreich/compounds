require 'spec_helper'

describe MoleculesController do

  let(:molecule) { FactoryGirl.create(:molecule) }
  let(:molecule_params) { FactoryGirl.attributes_for(:molecule) }

  describe 'GET index' do
    it 'assigns all molecules as @molecules' do
      molecules = []
      3.times { molecules << FactoryGirl.create(:molecule) }
      get :index
      expect(assigns :molecules).to eq(molecules)
    end
  end

  describe 'GET show' do
    it 'assigns the requested molecule as @molecule' do
      get :show, {id: molecule.to_param}
      expect(assigns :molecule).to eq(molecule)
    end
  end

  describe 'GET new' do
    it 'assigns a new molecule as @molecule' do
      get :new
      expect(assigns :molecule).to be_a_new(Molecule)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested molecule as @molecule' do
      get :edit, {id: molecule.to_param}
      expect(assigns :molecule).to eq(molecule)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new Molecule' do
        expect {
          post :create, {molecule: molecule_params}
        }.to change(Molecule, :count).by(1)
      end
      it 'assigns a newly created molecule as @molecule' do
        post :create, {molecule: molecule_params}
        expect(assigns :molecule).to be_a(Molecule)
        expect(assigns :molecule).to be_persisted
      end
      it 'redirects to the created molecule' do
        post :create, {molecule: molecule_params}
        expect(response).to redirect_to Molecule.last
      end
    end
    context 'with invalid params' do
      before :each do
        molecule_params[:name] = ""
      end

      it 'assigns a newly created but unsaved molecule as @molecule' do
        post :create, { molecule: molecule_params}
        expect(assigns :molecule).to be_a_new(Molecule)
      end

      it 're-renders the "new" template' do
        post :create, { molecule: molecule_params}
        expect(response).to render_template "new"
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before :each do
        @update_attributes = molecule.attributes.merge(name: "new name")
        %w{id created_at updated_at}.each do |attr| 
          @update_attributes.delete(attr)
        end
      end

      it 'updates the requested molecule' do
        put :update, {id: molecule.to_param, molecule: @update_attributes}
        expect(Molecule.find(molecule.id).name).to eq("new name")
      end
      it 'assigns the requested molecule as @molecule' do
        put :update, {id: molecule.to_param, molecule: @update_attributes}
        expect(assigns :molecule).to eq(molecule)
      end
      it 'redirects to the molecule' do
        put :update, {id: molecule.to_param, molecule: @update_attributes}
        expect(response).to redirect_to molecule
      end
    end
    context 'with invalid params' do
      before :each do
        @update_attributes = molecule.attributes.merge(name: "")
        %w{id created_at updated_at}.each do |attr| 
          @update_attributes.delete(attr)
        end
      end

      it 'assigns the molecule as @molecule' do
        put :update, {id: molecule.to_param, molecule: @update_attributes}
        expect(assigns :molecule).to eq(molecule)
      end
      it 're-render the "edit" template' do
        put :update, {id: molecule.to_param, molecule: @update_attributes}
        expect(response).to render_template "edit"
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested molecule' do
      molecule
      expect {
        delete :destroy, {id: molecule.to_param}
      }.to change(Molecule, :count).by(-1)
    end
    it 'redirects to the molecules list' do
      delete :destroy, {id: molecule.to_param}
      expect(response).to redirect_to molecules_url
    end
  end

end
