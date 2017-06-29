class UserVehiclesController < ApplicationController
  before_action :set_user_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  # GET /user_vehicles
  # GET /user_vehicles.json
  def index
    if current_user.admin?
      @user_vehicles = UserVehicle.all
    elsif signed_in?
      @user_vehicles = UserVehicle.where(user_id: current_user.id)
    else
      redirect_to root_url
    end
  end

  # GET /user_vehicles/1
  # GET /user_vehicles/1.json
  def show
    @model_year_services = @user_vehicle.model_year_services.paginate(page: params[:page])
  end

  # GET /user_vehicles/new
  def new
    @makes = Make.all.order('name ASC')
    @user_vehicle = UserVehicle.new
  end

  # GET /user_vehicles/1/edit
  def edit
  end

  # POST /user_vehicles
  # POST /user_vehicles.json
  def create
    @user_vehicle = UserVehicle.new(user_vehicle_params)
    @user_vehicle.user = current_user
    @user_vehicle.model_year_id = params[:model_year_id] unless !params[:model_year_id]

    respond_to do |format|
      if @user_vehicle.save
        format.html { redirect_to @user_vehicle, notice: "Successfully added \"#{@user_vehicle.full_display}\" to your garage." }
        format.json { render action: 'show', status: :created, location: @user_vehicle }
      else
        @makes = Make.all.order('name ASC')
        format.html { render action: 'new' }
        format.json { render json: @user_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_vehicles/1
  # PATCH/PUT /user_vehicles/1.json
  def update

    respond_to do |format|
      if @user_vehicle.update(user_vehicle_params)
        data = "{\"services\": \"#{services_list(@user_vehicle.mileage)}\", \"vehicle_id\": \"#{@user_vehicle.id}\", \"vehicle_mileage\": \"#{@user_vehicle.mileage}\"}".to_json
        format.html { redirect_to @user_vehicle, notice: "Successfully updated \"#{@user_vehicle.full_display}\"." }
        format.json { head :no_content }
        format.js {render json: data}
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_vehicle.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /user_vehicles/1
  # DELETE /user_vehicles/1.json
  def destroy

    @user_vehicle.destroy
    respond_to do |format|
      format.html { redirect_to user_vehicles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_vehicle
      @user_vehicle = UserVehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_vehicle_params
      params.require(:user_vehicle).permit(:model_year_id, :user_id, :name, :mileage, :image_url, :video_url, :privacy_id)
    end

    #generate list of services li's
    def services_list(mileage)
      list = ""
      ModelYear.find(@user_vehicle.model_year_id).model_year_services.main_services. each do |service|
        if service.need_service?(mileage)
          link_name = "#{service.service.name}"
          link_path = "#{model_year_service_path(service.id)}"
          list += "<li><a href = '#{link_path}'>#{link_name}</a></li>"
        else
          list += ""
        end
      end
      list
    end
end
