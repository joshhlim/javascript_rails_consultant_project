class ModelYearServiceRequirementsController < ApplicationController
  before_action :set_model_year_service_requirement, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  
  # GET /model_year_service_requirements/1
  # GET /model_year_service_requirements/1.json
  def show
    @old_model_year_service_requirement = @model_year_service_requirement.replaced
  end
  
  def new
    requirement_category = RequirementCategory.find_by(name: params[:category])
    @model_year_service_requirement = ModelYearServiceRequirement.new(requirement_category: requirement_category,
                                                                      model_year_service_id: params[:model_year_service_id])
    respond_to do |format|
      format.html
      format.js
    end 
  end
  
  def create
    model_year_service_requirement_param = params[:model_year_service_requirement]
    requirement_category_id = model_year_service_requirement_param[:requirement_category_id]
    name = model_year_service_requirement_param[:name]
    detail = model_year_service_requirement_param[:detail]
    model_year_service_id = model_year_service_requirement_param[:model_year_service_id]
    quantity = model_year_service_requirement_param[:quantity]
    quantity_unit = model_year_service_requirement_param[:quantity_unit]
    
    requirement_item =
      RequirementItem.create_with(created_by: current_user, updated_by: current_user)
                     .find_or_create_by(requirement_category_id: requirement_category_id,
                                        name: name, 
                                        detail: detail)
                                      
    @model_year_service_requirement = 
      ModelYearServiceRequirement.new(created_by: current_user,
                                      updated_by: current_user,
                                      requirement_item_id: requirement_item.id,
                                      requirement_category: requirement_item.requirement_category,
                                      model_year_service_id: model_year_service_id)
    
    if detail.present?
      @model_year_service_requirement.needs_detail = true
    end
    
    if quantity.present?
      @model_year_service_requirement.needs_quantity = true
      @model_year_service_requirement.quantity = quantity
    end
    
    if quantity_unit.present?
      @model_year_service_requirement.quantity_unit = quantity_unit
    end
    
    if @model_year_service_requirement.save
      flash[:success] = "Successfully added #{@model_year_service_requirement.requirement_category.name}!"
      redirect_to @model_year_service_requirement
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
    detail = params[:model_year_service_requirement][:detail]
    quantity = params[:model_year_service_requirement][:quantity]
    quantity_unit = params[:model_year_service_requirement][:quantity_unit]
    
    if detail.present?
      new_requirement_item = 
        RequirementItem.create_with(created_by: current_user, updated_by: current_user)
                       .find_or_create_by(requirement_category: @model_year_service_requirement.requirement_category,
                                          name: @model_year_service_requirement.requirement_item.name, 
                                          detail: detail)
    else
      new_requirement_item = RequirementItem.find(@model_year_service_requirement.requirement_item_id)
    end
    
    new_model_year_service_requirement = 
      ModelYearServiceRequirement.create_with(created_by: current_user)
                                 .find_or_create_by(requirement_item_id: new_requirement_item.id,
                                                    requirement_category: @model_year_service_requirement.requirement_category,
                                                    model_year_service: @model_year_service_requirement.model_year_service,
                                                    quantity: quantity,
                                                    quantity_unit: quantity_unit)
    
    if detail.present?
      new_model_year_service_requirement.needs_detail = true
    end
    
    if quantity.present?
      new_model_year_service_requirement.needs_quantity = true
    end
    
    # Set these to inactive (not deleted), as we want other users to help decide if they are actually
    # wrong and need to be replaced. the default for is_inactive is false, so no need to explicitly set it
    # for the new records
    @model_year_service_requirement.is_inactive = true
    
    # This makes it easy to get the old record from the new one and vise-versa, allowing an undo, if needed (among other things)
    @model_year_service_requirement.replaced_by = new_model_year_service_requirement
    new_model_year_service_requirement.replaced = @model_year_service_requirement
    
    @model_year_service_requirement.updated_by = current_user
    new_model_year_service_requirement.updated_by = current_user
    
    respond_to do |format|
      if new_model_year_service_requirement.save && 
           @model_year_service_requirement.save && 
           new_requirement_item.save
        format.html { redirect_to new_model_year_service_requirement, notice: 'Update successful!' }
        format.json { render action: 'show', status: :created, location: new_model_year_service_requirement }
      else
        format.html { render action: 'new' }
        format.json { render json: new_model_year_service_requirement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model_year_service_requirement
      @model_year_service_requirement = ModelYearServiceRequirement.includes(:requirement_item).find(params[:id])
    end
    
    def requirement_item_params
      params.require(:model_year_service_requirement).permit(:detail, :quantity, :quantity_unit)
    end
    
    def model_year_service_requirement_params
      params.require(:model_year_service_requirement).permit(:name, :category, :detail, :quantity, :quantity_unit)
    end
end
