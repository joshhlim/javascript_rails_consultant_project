class ModelYearsController < ApplicationController
  before_action :set_model_year, only: [:show, :edit, :update, :destroy]

  # GET /model_years
  # GET /model_years.json
  def index
    if request.format == :json
      @model_years = ModelYear.all
    else
      @model_years = ModelYear.paginate(page: params[:page])
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @model_years }
    end
  end
  
  def index_for_model
    @model_years = ModelYear.where(model_id: params[:model_id]).order('year DESC')
    respond_to do |format|
      format.json { render json: @model_years }
    end
  end

  # GET /model_years/1
  # GET /model_years/1.json
  def show
    set_model_year
    @model_year_services = @model_year.model_year_services.paginate(page: params[:page])
    @quick_specs = @model_year.specifications.where(is_quick_spec: true, is_deleted: false, is_inactive: false)
  end

  # GET /model_years/new
  def new
    @model_year = ModelYear.new
  end

  # GET /model_years/1/edit
  def edit
  end

  # POST /model_years
  # POST /model_years.json
  def create
    @model_year = ModelYear.new(model_year_params)

    respond_to do |format|
      if @model_year.save
        format.html { redirect_to @model_year, notice: 'ModelYear was successfully created.' }
        format.json { render action: 'show', status: :created, location: @model_year }
      else
        format.html { render action: 'new' }
        format.json { render json: @model_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model_years/1
  # PATCH/PUT /model_years/1.json
  def update
    respond_to do |format|
      if @model_year.update(model_year_params)
        format.html { redirect_to @model_year, notice: 'ModelYear was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @model_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /model_years/1
  # DELETE /model_years/1.json
  def destroy
    @model_year.destroy
    respond_to do |format|
      format.html { redirect_to model_years_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_year
      @model_year = ModelYear.find(params[:id])
    end
    
    def get_model_year_full_name(model_year)
      "#{model_year.year.to_s} #{model_year.make.name} #{model_year.model.name}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_year_params
      params.require(:model_year).permit(:name, :model_year_id)
    end
end
