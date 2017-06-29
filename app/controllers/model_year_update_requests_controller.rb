class ModelYearUpdateRequestsController < ApplicationController
  
    def create
      @request = ModelYearUpdateRequest.new(vote_params)
      if signed_in?
        @request.user_id = current_user.id
        @request.is_guest = false
      else
        @request.is_guest = true
      end
      @request.ip_address = request.remote_ip
      @request.session_id = request.session_options[:id]
      if @request.save
        flash.now[:success] = "Request successfully recorded!"
      else
        flash.now[:error] = "Request was not recorded!"
      end
      
      respond_to do |format|
        format.html { render :nothing => true }
        format.js
        format.json { render json: @request }
      end
    end
    
    private
  
      def vote_params
        params.permit(:model_year_id)
      end
end
