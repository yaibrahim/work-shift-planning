# spec/controllers/shifts_controller_spec.rb

require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do

  let!(:worker) { Worker.create(name: 'Test Worker') }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      shift = Shift.create(start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29", worker_id: Worker.last.id)
      get :show, params: { id: shift.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new shift' do
        expect {
          post :create, params: { shift: { start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29", worker_id: Worker.last.id } }
        }.to change(Shift, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { shift: { start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00", date: "2024-04-29", worker_id: Worker.last.id } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable_entity status' do
        post :create, params: { shift: { start_time: nil, end_time: nil, date: nil, worker_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested shift' do
      shift = Shift.create(start_time: "2024-04-29T16:00:00", end_time: "2024-04-29T23:59:59", date: "2024-04-29", worker_id: Worker.last.id)
      expect {
        delete :destroy, params: { id: shift.id }
      }.to change(Shift, :count).by(-1) 
    end
  end

  describe 'PUT #update' do
        let!(:shift) { Shift.create(start_time: "2024-04-29T08:00:00", end_time: "2024-04-29T16:00:00", date: "2024-04-29", worker_id: worker.id) }

        context 'with valid params' do
            let(:valid_params) { { start_time: "2024-04-29T00:00:00", end_time: "2024-04-29T08:00:00" } }
            before { patch :update, params: { id: shift.id, shift: valid_params } }

            it 'updates the requested shift' do
                expect(shift.reload.start_time.strftime("%Y-%m-%dT%H:%M:%S"))
                .to eq(valid_params[:start_time])

                expect(shift.reload.end_time.strftime("%Y-%m-%dT%H:%M:%S"))
                .to eq(valid_params[:end_time])
            end

            it 'returns a success status' do
                expect(response).to have_http_status(:ok)
            end
        end

        context 'with invalid params' do
            context 'with invalid start time (after end time)' do
                let(:invalid_params) { { start_time: "2024-04-30T14:00:00", end_time: "2024-04-30T12:00:00" } }

                before { put :update, params: { id: shift.id, shift: invalid_params } }

                it 'does not update the shift' do
                    expect(shift.reload.start_time).to_not eq(invalid_params[:start_time])
                end

                it 'returns an unprocessable_entity status' do
                    expect(response).to have_http_status(:unprocessable_entity)
                end
            end
        end
   end
end