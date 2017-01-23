class MembershipsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_team


	def index
		@memberships = @team.memberships
	end

	def new
	end

	def create
		email = params.require(:membership).permit(:email)
		user  = User.find_by email: email
		if user.nil?
			flash.now[:notice] = "#{email} not found."
			render :new
		else
			membership = @team.memberships.build user: user
			if membership.save
				redirect_to :index
			else
				flash.now[:notice] = "Something went wrong. #{error_messages membership}"
				render :new
			end
		end
	end

	private

		def find_team
			@team = Team.find params[:team_id]
		end
end
