require 'spec_helper'

describe BatchesController do
  let(:batch) { FactoryGirl.create :batch }
  let(:molecule) { FactoryGirl.create :molecule }
  let(:batch_params) { FactoryGirl.attributes_for :batch }

  describe 'GET index' do
    it "assigns all batches as @batches" do
      batches = []
      3.times { batches << FactoryGirl.create(:batch, molecule: molecule) }
      get :index
      expect(assigns :batches).to eq(batches)
    end
  end

  describe 'GET show' do
    it 'assigns the requested batch as @batch' do
      get :show, { id: batch.to_param }
      expect(assigns :batch).to eq(batch)
    end
  end

  describe 'GET new' do
    it 'assigns a new batch as @batch' do
      get :new
      expect(assigns :batch).to be_a_new(Batch)
    end
  end

  describe 'GET edit' do 
    it 'assigns the requested batch as @batch' do
      get :edit, {id: batch.to_param}
      expect(assigns :batch).to eq(batch)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      before :each do
        batch_params[:molecule_id] = molecule.id
      end

      it 'creates a new Batch' do
        expect {
          post :create, { batch: batch_params }}.to change(Batch, :count).by(1)
      end
      it 'assigns a newly created batch ad @batch' do
        post :create, { batch: batch_params }
        expect(assigns :batch).to be_a(Batch)
        expect(assigns :batch).to be_persisted
      end
      it 'redirect to the created batch' do
        post :create, { batch: batch_params }
        response.should redirect_to Batch.last
      end
    end
    context 'with invalid params' do
      it 'assigns a newly created but unsaved batch as @batch' do
        post :create, { batch: batch_params }
        expect(assigns :batch).to be_a_new(Batch)
      end
      it 're-render the "new" template' do
        post :create, { batch: batch_params }
        expect(response).to render_template "new"
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @update_attributes = batch.attributes.merge(barcode: "new barcode")
      %w{id created_at updated_at}.each do |attr| 
        @update_attributes.delete(attr)
      end
    end

    context 'with valid params' do
      it 'updates the requested batch' do
        put :update, { id: batch.to_param, batch: @update_attributes }
        expect(Batch.find(batch.id).barcode).to eq("new barcode")
      end
      it 'assigns the requested batch as @batch' do
        put :update, { id: batch.to_param, batch: @update_attributes }
        expect(assigns :batch).to eq(batch)
      end
      it 'redirects to the batch' do
        put :update, { id: batch.to_param, batch: @update_attributes }
        expect(response).to redirect_to batch
      end
    end
    context 'with invalid params' do
      before :each do
        @update_attributes[:lot_number] = "not a number"
      end
      it 'does not updated the requested batch' do
        put :update, { id: batch.to_param, batch: @update_attributes }
        expect(Batch.find(batch.id).barcode).to_not eq("new barcode")
      end
      it 're-render the "edit" template' do
        put :update, { id: batch.to_param, batch: @update_attributes }
        expect(response).to render_template "edit"
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested batch' do
      batch
      expect {
        delete :destroy, { id: batch.to_param }
      }.to change(Batch, :count).by(-1)
    end
    it 'redirects to the batches list' do
      delete :destroy, { id: batch.to_param }
      expect(response).to redirect_to batches_url
    end
  end
end
