class ActiveProjectsController < ApplicationController
	before_action :authenticate_user!

	def show
		redirect_to project_path
	end

	def create
		project = Project.find(params[:id])
		if current_user.active_membership.update(active_project: project)
			redirect_to project_path(project)
		else
			flash[:notice] = "Something went wrong!"
			redirect_to :back
		end
	end

	def destroy
		if current_user.active_membership.update(active_project_id: nil)
			redirect_to root_path
		else
			flash[:notice] = "Something went wrong!"
			redirect_to :back
		end
	end
end
