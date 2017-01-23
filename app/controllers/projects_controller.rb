class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if current_user.active_project.nil?
      @projects = current_user.team.projects
    else
      redirect_to project_path(current_user.active_project)
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if current_user.team.nil?
      redirect_to new_team_path
    elsif current_user.active_project.nil?
      redirect_to projects_path
    else
      set_project
      @products = @project.products.sorted
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.team = current_user.team

    respond_to do |format|
      if @project.save
        membership = current_user.active_membership
        if membership.update active_project: @project
          format.html { redirect_to @project }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new, notice: "Something went wrong. #{error_messages membership}" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, notice: "Something went wrong. #{error_messages @project}" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
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
