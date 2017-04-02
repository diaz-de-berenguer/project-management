class ProjectsController < ApplicationController
  before_action :set_tempproj, only: [:show, :edit, :update, :destroy]

  # GET /project
  # GET /project.json
  def index
    @project = Tempproj.all
  end

  # GET /project/1
  # GET /project/1.json
  def show
    @completed_features = @tempproj.completed_features
    @active_features    = @tempproj.active_features
  end

  # GET /project/new
  def new
    @product = Product.find params[:product_id]
    @tempproj = @product.project.build
  end

  # GET /project/1/edit
  def edit
  end

  # POST /project
  # POST /project.json
  def create
    @product = Product.find params[:product_id]
    @tempproj = @product.project.build(tempproj_params)

    respond_to do |format|
      if @tempproj.save
        format.html { redirect_to @tempproj, notice: 'tempproj was successfully created.' }
        format.json { render :show, status: :created, location: @tempproj }
      else
        format.html { render :new }
        format.json { render json: @tempproj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project/1
  # PATCH/PUT /project/1.json
  def update
    respond_to do |format|
      if @tempproj.update(tempproj_params)
        format.html { redirect_to @tempproj, notice: 'tempproj was successfully updated.' }
        format.json { render :show, status: :ok, location: @tempproj }
      else
        format.html { render :edit }
        format.json { render json: @tempproj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project/1
  # DELETE /project/1.json
  def destroy
    @tempproj.destroy
    respond_to do |format|
      format.html { redirect_to products_url(@tempproj.product), notice: 'tempproj was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tempproj
      @tempproj = Tempproj.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tempproj_params
      params.require(:tempproj).permit(:name, :description)
    end
end
