require 'rails_helper'

RSpec.describe WorkersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      worker = Worker.create(name: 'John Doe')
      get :show, params: { id: worker.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new worker' do
        expect {
          post :create, params: { worker: { name: 'Alice' } }
        }.to change(Worker, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { worker: { name: 'Alice' } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable_entity status' do
        post :create, params: { worker: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #get_shifts' do
    it 'returns the worker\'s shifts' do
      worker = Worker.create(name: 'Jane')
      shift = Shift.create(worker: worker, start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29")
      get :get_shifts, params: { id: worker.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).first['id']).to eq(shift.id)
    end

    it 'returns a message if the worker has no shifts' do
      worker = Worker.create(name: 'Bob')
      get :get_shifts, params: { id: worker.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']).to eq('The worker has no shifts.')
    end
  end
end