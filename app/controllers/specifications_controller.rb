class SpecificationsController < ApplicationController
  before_action :set_specification, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  
  # GET /specifications/1
  # GET /specifications/1.json
  def show
  end
  
  def new    
    @specification = Specification.new(model_year_id: params[:model_year_id])

    respond_to do |format|
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
    
    specification_category =
      SpecificationCategory.create_with(created_by: current_user, updated_by: current_user)
                           .find_or_create_by(name: name,
                                              description: description)
                                      
    @specification = 
      Specification.create(created_by: current_user,
                          updated_by: current_user,
                          model_year_id: model_year_id,
                          specification_category: specification_category,
                          single_value_str: single_value_str,
                          range_start_str: range_start_str,
                          range_end_str: range_end_str)
    
    if @specification.save
      flash[:success] = "Successfully added Spec!"
      redirect_to @specification
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
    # TODO: It may be good to move a lot of this logic to the model
    specification_param = params[:specification]
    name = specification_param[:name]
    description = specification_param[:description]
    model_year_id = @specification.model_year_id
    is_quick_spec = @specification.is_quick_spec
    single_value_str = specification_param[:single_value_str]
    range_start_str = specification_param[:range_start_str]
    range_end_str = specification_param[:range_end_str]
    specification_category = @specification.specification_category
    
    if name.present? || description.present?
      specification_category =
        SpecificationCategory.create_with(created_by: current_user, updated_by: current_user)
                             .find_or_create_by(name: name,
                                                description: description)  
    end
                                    
    new_specification = 
      Specification.create(created_by: current_user,
                          updated_by: current_user,
                          model_year_id: model_year_id,
                          specification_category: specification_category,
                          is_quick_spec: is_quick_spec,
                          single_value_str: single_value_str,
                          range_start_str: range_start_str,
                          range_end_str: range_end_str)
    
    # Set these to inactive (not deleted), as we want other users to help decide if they are actually
    # wrong and need to be replaced. the default for is_inactive is false, so no need to explicitly set it
    # for the new records
    @specification.is_inactive = true
    
    # This makes it easy to get the old record from the new one and vise-versa, allowing an undo, if needed (among other things)
    @specification.replaced_by = new_specification
    new_specification.replaced = @specification
    
    @specification.updated_by = current_user
    new_specification.updated_by = current_user
    
    respond_to do |format|
      if new_specification.save && @specification.save
        @specification.model_year_service_specifications.update_all(specification_id: new_specification.id)
        format.html { redirect_to new_specification, notice: 'Update successful!' }
        format.json { render action: 'show', status: :created, location: new_specification }
      else
        format.html { render action: 'new' }
        format.json { render json: new_model_year_service_requirement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specification
      @specification = Specification.includes(:specification_category).find(params[:id])
    end
    
    def specification_params
      params.require(:specification).permit(:name, :specification_category, :description, :single_value_str, :range_start_str, :range_end_str)
    end
end
