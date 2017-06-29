class FeatureRequestsController < ApplicationController
  def create
      @feature_request = FeatureRequest.new(feature_request_params)
      if signed_in?
        @feature_request.user_id = current_user.id
      end
      
      @feature_request.ip_address = request.remote_ip
      @feature_request.session_id = request.session_options[:id]
      if @feature_request.save
        flash.now[:notice] = "Feature is not available yet, a request was recorded to move it up the priority list!"
      else
        flash.now[:notice] = "Feature is not available yet, but we're working on it!"
      end
      
      respond_to do |format|
        format.html { render :nothing => true }
        format.js
        format.json { render json: @feature_request }
      end
    end
    
    private
  
      def feature_request_params
        params.permit(:feature_id)
      end
end
