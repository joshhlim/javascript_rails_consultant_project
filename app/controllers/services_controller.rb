class ServicesController < ApplicationController
  def index
    @services = Service.all.order('item_action_display ASC')
    respond_to do |format|
      format.json { render json: @services }
    end
  end
end
