class ShiftsController < ApplicationController
    before_action :set_shift, only: [:show, :update, :destroy]
  
    def index
      @shifts = Shift.all
      render json: @shifts
    end
  
    def show
      render json: @shift
    end
  
    def create
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
  
    private
      def set_shift
        @shift = Shift.find(params[:id])
      end
  
      def shift_params
        params.require(:shift).permit(:start_time, :end_time, :date, :worker_id)
      end
end  