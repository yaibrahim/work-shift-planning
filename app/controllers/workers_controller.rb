class WorkersController < ApplicationController
    before_action :set_worker, only: [:show, :update, :destroy]
  
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
  
    private
  
    def set_worker
      @worker = Worker.find(params[:id])
    end
  
    def worker_params
      params.require(:worker).permit(:name)
    end
end  