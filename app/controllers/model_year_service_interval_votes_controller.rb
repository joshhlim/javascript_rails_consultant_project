class ModelYearServiceIntervalVotesController < ApplicationController
  
    def create
      @vote = ModelYearServiceIntervalVote.new(vote_params)
      if signed_in?
        @vote.user_id = current_user.id
        @vote.is_guest = false
      else
        @vote.is_guest = true
      end
      @vote.ip_address = request.remote_ip
      @vote.session_id = request.session_options[:id]
      if @vote.save
        flash.now[:success] = "Vote successfully recorded!"
      else
        flash.now[:error] = "Vote was not recorded!"
      end
      
      respond_to do |format|
        format.html { render :nothing => true }
        format.js
        format.json { render json: @vote }
      end
    end
    
    private
  
      def vote_params
        params.permit(:model_year_service_id, :vote_type_id)
      end
end
