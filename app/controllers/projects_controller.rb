class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /project
  # GET /project.json
  def index
    @project = Project.all
  end

  # GET /project/1
  # GET /project/1.json
  def show
    @completed_features = @project.completed_features
    @active_features    = @project.active_features
  end

  # GET /project/new
  def new
    @product = Product.find params[:product_id]
    @project = @product.projects.build
  end

  # GET /project/1/edit
  def edit
  end

  # POST /project
  # POST /project.json
  def create
    @product = Product.find params[:product_id]
    @project = @product.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project/1
  # PATCH/PUT /project/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project/1
  # DELETE /project/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to products_url(@project.product), notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
