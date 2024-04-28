class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def record_not_found
        render json: {"message": "Record not found!", "status": "404"}
    end
end
