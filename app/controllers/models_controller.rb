class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  # GET /models
  # GET /models.json
  def index
    if request.format == :json
      @models = Model.all
    else
      @models = Model.paginate(page: params[:page])
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @models }
    end
  end
  
  def index_for_make
    @models = Model.where(make_id: params[:make_id]).order('name ASC')
    respond_to do |format|
      format.json { render json: @models }
    end
  end

  # GET /models/1
  # GET /models/1.json
  def show
    set_model
    @model_years = @model.model_years.paginate(page: params[:page])
  end

  # GET /models/new
  def new
    @model = Model.new
  end

  # GET /models/1/edit
  def edit
  end

  # POST /models
  # POST /models.json
  def create
    @model = Model.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render action: 'show', status: :created, location: @model }
      else
        format.html { render action: 'new' }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1
  # PATCH/PUT /models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    @model.destroy
    respond_to do |format|
      format.html { redirect_to models_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      params.require(:model).permit(:name, :model_id, :make_id)
    end
end
