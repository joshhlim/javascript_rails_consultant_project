class ModelYearServiceSpecificationsController < ApplicationController
  before_action :set_model_year_service_specification, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  
  # GET /model_year_service_specifications/1
  # GET /model_year_service_specifications/1.json
  def show
  end
  
  def new    
    specification = Specification.new(model_year_id: params[:model_year_id])
    @model_year_service_specification = ModelYearServiceSpecification.new(model_year_service_id: params[:model_year_service_id],
                                                                          specification: specification)
    
    respond_to do |format|
      format.html
      format.js
    end 
  end
  
  def create
    specification_param = params[:specification]
    name = specification_param[:name]
    description = specification_param[:description]
    model_year_id = specification_param[:model_year_id]
    single_value_str = specification_param[:single_value_str]
    range_start_str = specification_param[:range_start_str]
    range_end_str = specification_param[:range_end_str]
    model_year_service_id = params[:model_year_service_specification][:model_year_service_id]
    
    specification_category =
      SpecificationCategory.create_with(created_by: current_user, updated_by: current_user)
                           .find_or_create_by(name: name,
                                              description: description)
                                      
    @specification = 
      Specification.create_with(created_by: current_user, updated_by: current_user)
                   .find_or_create_by(model_year_id: model_year_id,
                                      specification_category: specification_category,
                                      single_value_str: single_value_str,
                                      range_start_str: range_start_str,
                                      range_end_str: range_end_str)
    
    @model_year_service_specification =
      ModelYearServiceSpecification.new(created_by: current_user,
                                        updated_by: current_user,
                                        model_year_service_id: model_year_service_id,
                                        specification_id: @specification.id)
    
    if @model_year_service_specification.save
      flash[:success] = "Successfully added Spec!"
      redirect_to @model_year_service_specification.model_year_service
    end
  end
  
  def edit
    respond_to do |format|
      format.html
      format.js
    end    
  end
  
  def update
    # On update, we will keep the old entry, in case it is correct and just flag as inactive
    # A new entry will be made to replace it
    # For model_year_service_specifications, we have to keep them in sync with "specifications" (which apply to the model year)
    # That's why there is a bunch of code to update both models.
    # TODO: It may be good to move a lot of this logic to the model
    specification_param = params[:specification]
    single_value_str = specification_param[:single_value_str]
    range_start_str = specification_param[:range_start_str]
    range_end_str = specification_param[:range_end_str]
    
    @specification = 
      Specification.create_with(created_by: current_user, updated_by: current_user)
                   .find_or_create_by(model_year_id: @model_year_service_specification.specification.model_year_id,
                                      specification_category: @model_year_service_specification.specification_category,
                                      single_value_str: single_value_str,
                                      range_start_str: range_start_str,
                                      range_end_str: range_end_str )

    # Set these to inactive (not deleted), as we want other users to help decide if they are actually
    # wrong and need to be replaced. the default for is_inactive is false, so no need to explicitly set it
    # for the new records
    @model_year_service_specification.specification.is_inactive = true
    
    # This makes it easy to get the old record from the new one and vise-versa, allowing an undo, if needed (among other things)
    @model_year_service_specification.specification.replaced_by = @specification
    @specification.replaced = @model_year_service_specification.specification
    
    @model_year_service_specification.specification.updated_by = current_user
    @model_year_service_specification.specification.save
    
    @model_year_service_specification.specification = @specification
    @model_year_service_specification.specification.save
    @model_year_service_specification.updated_by = current_user
    
    respond_to do |format|
      if @model_year_service_specification.save
        format.html { redirect_to @model_year_service_specification, notice: 'Update successful!' }
        format.json { render action: 'show', status: :created, location: @model_year_service_specification }
      else
        format.html { render action: 'new' }
        format.json { render json: @model_year_service_specification.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_year_service_specification
      @model_year_service_specification = ModelYearServiceSpecification.includes([:specification, :specification_category]).find(params[:id])
    end
    
    def model_year_service_specification_params
      params.require(:specification).permit(:name, :specification_category, :description, :single_value_str, :range_start_str, :range_end_str)
    end
end
