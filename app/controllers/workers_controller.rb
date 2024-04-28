class WorkersController < ApplicationController
    before_action :set_worker, only: [:show, :update, :destroy, :get_shifts]
  
    def index
      @workers = Worker.all
      render json: @workers
    end
  
    def show
      render json: @worker
    end
  
    def create
      @worker = Worker.new(worker_params)
      if @worker.save
        render json: @worker, status: :created
      else
        render json: @worker.errors, status: :unprocessable_entity
      end
    end

    def get_shifts
      if @worker.shifts.present?
        render json: @worker.shifts
      else
        render json: {"message": "The worker has no shifts."}
      end
    end
  
    private
  
    def set_worker
      @worker = Worker.find(params[:id])
    end
  
    def worker_params
      params.require(:worker).permit(:name)
    end
end  