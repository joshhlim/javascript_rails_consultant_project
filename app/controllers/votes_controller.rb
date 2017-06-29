class VotesController < ApplicationController
  
    def create
      vote_params #Check parameters passed in
      vote_type_id = params[:vote][:vote_type_id]
      user_id = nil
      is_guest = true
      ip_address = request.remote_ip
      session_id = request.session_options[:id]
      success_count = 0
      failure_count = 0
      
      if signed_in?
        user_id = current_user.id
        is_guest = false
      end
      
      # Vote type is stored in local variable, and we do not want the block below using this
      params[:vote].delete(:vote_type_id)
      
      params[:vote].each do |key, value|
        @vote = Vote.new("#{key}" => value, vote_type_id: vote_type_id)
        @vote.user_id = user_id
        @vote.is_guest = is_guest
        @vote.ip_address = ip_address
        @vote.session_id = session_id

        if @vote.save
          success_count += 1
        else
          failure_count += 1
        end
      end
      
      if failure_count == 0 && success_count > 0
        flash.now[:success] = "Vote successfully recorded!"
      else
        flash.now[:error] = "#{failure_count} #{'Vote'.pluralize(failure_count)} not recorded!"
      end
      
      respond_to do |format|
        format.html { render :nothing => true }
        format.js
        format.json { render json: @vote }
      end
    end
    
    private
  
      def vote_params
        params.require(:vote).permit(:model_year_service_specification_id, 
                                     :specification_id, 
                                     :vote_type_id,
                                     :video_id)
      end
end
