class LoadVehicleController < ApplicationController
  before_action :set_load_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /load_vehicle
  # GET /load_vehicle.json
  def index
    @load_vehicle = LoadVehicle.all
    respond_to do |format|
      format.json { render json: @load_vehicle }
    end
  end
  
  def index_for_make
    @load_vehicle = LoadVehicle.where(make_id: params[:make_id]).order('name ASC')
    respond_to do |format|
      format.json { render json: @load_vehicle }
    end
  end

  # GET /load_vehicle/1
  # GET /load_vehicle/1.json
  def show
  end

  # GET /load_vehicle/new
  def new
    @load_vehicle = LoadVehicle.new
  end

  # GET /load_vehicle/1/edit
  def edit
  end

  # POST /load_vehicle
  # POST /load_vehicle.json
  def create
    @load_vehicle = LoadVehicle.new(load_vehicle_params)

    respond_to do |format|
      if @load_vehicle.save
        format.html { redirect_to @load_vehicle, notice: 'LoadVehicle was successfully created.' }
        format.json { render action: 'show', status: :created, location: @load_vehicle }
      else
        format.html { render action: 'new' }
        format.json { render json: @load_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /load_vehicle/1
  # PATCH/PUT /load_vehicle/1.json
  def update
    respond_to do |format|
      if @load_vehicle.update(load_vehicle_params)
        format.html { redirect_to @load_vehicle, notice: 'LoadVehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @load_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /load_vehicle/1
  # DELETE /load_vehicle/1.json
  def destroy
    @load_vehicle.destroy
    respond_to do |format|
      format.html { redirect_to load_vehicle_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load_vehicle
      @load_vehicle = LoadVehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_vehicle_params
      params.require(:load_vehicle).permit(:name, :load_vehicle_id, :make_id)
    end
end
