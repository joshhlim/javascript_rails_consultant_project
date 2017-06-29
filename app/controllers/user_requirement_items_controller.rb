class UserRequirementItemsController < ApplicationController
  before_action :set_user_requirement_item, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  
  # GET /user_requirement_items
  # GET /user_requirement_items.json
  def index
    if current_user.admin?
      @user_requirement_items = UserRequirementItem.all
    elsif signed_in?
      @user_requirement_items = UserRequirementItem.where(user_id: current_user.id)
    else
      redirect_to root_url          
    end
  end

  # GET /user_requirement_items/1
  # GET /user_requirement_items/1.json
  def show
    @user_vehicle_services = ComplexQuery.user_vehicle_services_for_user_requirement_item(@user_requirement_item.id)
  end

  # GET /user_requirement_items/new
  def new
    @tools = RequirementItem.where(is_deleted: false, is_inactive: false).order("name ASC, detail_numbers ASC")
    @user_requirement_item = UserRequirementItem.new
  end

  # GET /user_requirement_items/1/edit
  def edit
  end
  
  # POST /toolbox_quick_add.json
  def quick_add
    @user_requirement_item = UserRequirementItem.new(requirement_item_id: params[:requirement_item_id])
    @user_requirement_item.user_id = current_user.id
    
    if @user_requirement_item.save
      flash.now[:success] = "Successfully added #{@user_requirement_item.requirement_item.name} to toolbox!"
    else
      flash.now[:error] = "Failed to add to toolbox!"
    end
    
    respond_to do |format|
      format.html { render :nothing => true }
      format.js
      format.json { render json: @user_requirement_item }
    end
  end

  # POST /user_requirement_items
  # POST /user_requirement_items.json  
  def create
    @user_requirement_item = UserRequirementItem.new(user_requirement_item_params)
    @user_requirement_item.user_id = current_user.id    
    
    respond_to do |format|
      if @user_requirement_item.save
          format.html { redirect_to @user_requirement_item, notice: "Successfully added #{@user_requirement_item.requirement_item.name} to toolbox!" }
          format.json { render json: @user_requirement_item }
      else
        flash.now[:error] = "Failed to add to toolbox!"
        @tools = RequirementItem.where(is_deleted: false, is_inactive: false).order("name ASC, detail_numbers ASC")
        format.html { render action: 'new' }
        format.json { render json: @user_vehicle.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /user_requirement_items/1
  # PATCH/PUT /user_requirement_items/1.json
  def update
    
    respond_to do |format|
      if @user_requirement_item.update(user_requirement_item_params)
        format.html { redirect_to @user_requirement_item, notice: 'User vehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_requirement_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_requirement_items/1
  # DELETE /user_requirement_items/1.json
  def destroy
    
    @user_requirement_item.destroy
    respond_to do |format|
      format.html { redirect_to user_requirement_items_url }
      format.json { head :no_content }
    end
  end
    
  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_user_requirement_item
      @user_requirement_item = UserRequirementItem.includes(:requirement_item)
                                                  .find(params[:id])
    end
  
    def user_requirement_item_params
      params.require(:user_requirement_item)
            .permit(:requirement_item_id, :name, :brand, :description, :quantity, :upc, :asin)
    end
end
