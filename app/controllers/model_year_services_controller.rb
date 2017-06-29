class ModelYearServicesController < ApplicationController
  before_action :set_model_year_service, only: [:show, :edit, :update, :destroy, :edit_interval, :update_interval]
  before_action :signed_in_user, only: [:edit, :update, :destroy, :edit_interval, :update_interval]

  # GET /maintenance/lookup
  def lookup
  end

  # GET /load
  def show_from_dropdown
    # A non-signed in user can click "View & Save" requiring them to create an account
    if params[:commit] == "Save & View"
      session[:model_year_id] = params[:model_year_id]
      session[:model_year_service_id] = params[:model_year_service_id]
      redirect_to signup_url, notice: "Create an account to save your bikes and tools."
    elsif params[:commit] == "View"
      show_vehicle_requested
    end

    # Users have option of giving model_year_service, and model_year on home page

  end

  # GET /model_year_services
  # GET /model_year_services.json
  def index
    if request.format == :json
      @model_year_services = ModelYearService.includes(:service)
    else
      @model_year_services = ModelYearService.paginate(page: params[:page]).
                                              order(model_year_service_update_requests_count: :desc).
                                              includes(:service)
    end

    respond_to do |format|
      format.html
      format.json { render json: @model_year_services }
    end
  end

  def index_for_model_year
    @model_year_services = ModelYearService.where(model_year_id: params[:model_year_id]).includes(:service)
    @services = [];
    @model_year_services.all.each do |mys|
      @services.push({id: mys.id, name: mys.service.name})
    end
    respond_to do |format|
      format.json { render json: @services }
    end
  end

  # GET /model_year_services/1
  # GET /model_year_services/1.json
  def show
    @model_year_service_specifications = @model_year_service.model_year_service_specifications.includes(:specification_category)
    @videos = @model_year_service.videos
    @requirement_categories = @model_year_service.requirement_categories.uniq
    @service_requirements = []

    @requirement_categories.each do |category|
      items = @model_year_service.model_year_service_requirements.
                                  includes(:requirement_item, :model_year_service_requirement_votes).
                                  where(requirement_category_id: category.id,
                                        is_deleted: false,
                                        is_inactive: false)
      requirement = { name: category.name, items: items}
      @service_requirements.push(requirement)
    end

    if !@service_requirements.any?
      @requirement_categories = RequirementCategory.all
    end
    #@requirement_categories =
    #              ModelYearServiceRequirements.find_by(model_year_service_id: @model_year_service.id)

  end

  # GET /model_year_services/new
  def new
    @model_year_service = ModelYearService.new
  end

  # GET /model_year_services/1/edit
  def edit
  end

  # GET /edit_model_year_service_interval/1
  def edit_interval
  end

  # GET /update_model_year_service_interval/1
  def update_interval
    interval = Interval.new(interval_params)
    @model_year_service.interval.updated_by = interval.created_by = interval.updated_by = current_user

    # Set these to inactive (not deleted), as we want other users to help decide if they are actually
    # wrong and need to be replaced. the default for is_inactive is false, so no need to explicitly set it
    # for the new records
    @model_year_service.interval.is_inactive = true

    # This makes it easy to get the old record from the new one and vise-versa, allowing an undo, if needed (among other things)
    @model_year_service.interval.replaced_by = interval
    interval.replaced = @model_year_service.interval
    @model_year_service.interval.save

    @model_year_service.interval = interval
    @model_year_service.interval.save

    respond_to do |format|
      if @model_year_service.save
        format.html { render 'show_interval', notice: 'Update successful!' }
        format.json { render action: 'show', status: :created, location: @model_year_service }
      else
        flash[:error] = "Error updating interval!"
        format.html { redirect_to model_year_path(@model_year_service.model_year) }
        format.json { render json: @model_year_service.errors, status: :unprocessable_entity }
      end
    end



  end

  # POST /model_year_services
  # POST /model_year_services.json
  def create
    @model_year_service = ModelYearService.new(model_params)

    respond_to do |format|
      if @model_year_service.save
        format.html { redirect_to @model, notice: 'ModelYearService was successfully created.' }
        format.json { render action: 'show', status: :created, location: @model_year_service }
      else
        format.html { render action: 'new' }
        format.json { render json: @model_year_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model_year_services/1
  # PATCH/PUT /model_year_services/1.json
  def update
    respond_to do |format|
      if @model_year_service.update(model_params)
        format.html { redirect_to @model, notice: 'ModelYearService was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @model_year_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /load_default_requirements/1
  # PATCH/PUT /load_default_requirements/1.json
  def load_default_requirements
    set_model_year_service
    if @model_year_service.model_year_service_requirements.any?
      respond_to do |format|
        format.html { redirect_to @model_year_service, notice: 'Cannot load standard tool/supply list when the list is already started.' }
        format.json { head :no_content }
      end
    else
      @model_year_service.service.default_requirements.each do |dreq|
        @model_year_service.model_year_service_requirements.
                            build(model_year_service_id: params[:id],
                                  requirement_item_id: dreq.requirement_item.id,
                                  requirement_category_id: dreq.requirement_item.requirement_category.id,
                                  needs_detail: dreq.requirement_item.needs_detail,
                                  needs_quantity: dreq.requirement_item.needs_quantity)
      end

      respond_to do |format|
        if @model_year_service.save
          format.html { redirect_to @model_year_service, notice: 'Tools/Supplies successfully added.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @model_year_service, notice: 'Tools/Supplies could not be added.' }
          format.json { render json: @model_year_service.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /model_year_services/1
  # DELETE /model_year_services/1.json
  def destroy
    @model_year_service.destroy
    respond_to do |format|
      format.html { redirect_to model_year_services_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_year_service
      @model_year_service = ModelYearService.find(params[:id])
      @model_year = ModelYear.find(@model_year_service.model_year.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_year_service_params
      params.require(:model_year_service).permit(:model_year_id, :service_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interval_params
      params.require(:interval).permit(:first_service_miles, :interval_miles, :interval_months)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_vehicle_params
      params.require(:commit)
      params.permit(:make_id, :model_id, :model_year_id, :model_year_service_id)
    end

    # Take user to requested page (model_year_service, and model_year can be optional)
    def show_vehicle_requested
      if is_string_an_id(params[:service_id]) && is_string_an_id(params[:model_year_id])
        # Load the model_year_service page
        model_year_service = get_model_year_service(params[:service_id], params[:model_year_id])
        redirect_to model_year_service
      elsif is_string_an_id(params[:model_year_id])
        redirect_to ModelYear.find(params[:model_year_id])
      elsif is_string_an_id(params[:model_id])
        redirect_to Model.find(params[:model_id])
      elsif is_string_an_id(params[:make_id])
        redirect_to Make.find(params[:make_id])
      else
        redirect_to root_url
      end
    end

    def is_string_an_id(object)
      object.present? && (object.is_a? String) && object.is_id?
    end

    def get_model_year_service(service_id, model_year_id)
      ModelYearService.find_or_create_by(service_id: service_id, model_year_id: model_year_id)
    end
end
