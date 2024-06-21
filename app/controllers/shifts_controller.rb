class ShiftsController < ApplicationController
    before_action :set_shift, only: [:show, :update, :destroy]
  
    def index
      @shifts = Shift.all.order(date: :DESC)
      render json: @shifts
    end
  
    def show
      render json: @shift
    end
  
    def create
      # byebug
      @shift = Shift.new(shift_params)
  
      if @shift.save
        render json: @shift, status: :created
      else
        render json: @shift.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @shift.update(shift_params)
        render json: @shift
      else
        render json: @shift.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @shift.destroy
    end

    def shift_with_workers
      @shifts_with_workers = Shift.order(date: :DESC).includes(:worker).map { |shift| { start_time: shift.start_time&.strftime("%H:%M"), end_time: shift.end_time&.strftime("%H:%M"), date: shift.date, worker_name: shift.worker.name } }
      render json: @shifts_with_workers
    end
  
    private
      def set_shift
        @shift = Shift.find(params[:id])
      end
  
      def shift_params
        params.require(:shift).permit(:start_time, :end_time, :date, :worker_id)
      end
end  