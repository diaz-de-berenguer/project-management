class TeamsController < ApplicationController
	before_action :authenticate_user!

	def switch
		team = Team.find(params[:id])
		current_user.update team: team
		redirect_to root_path
	end

  def new
  	@team = Team.new
  end

  def create
  	@team = Team.new(team_params)
  	# 1) Save the Team in DB
  	if @team.save
  		membership = @team.team_memberships.build(user: current_user)
  		# 2) Save a membership to connect user and team
  		if membership.save
  			# 3) Set the team as the active team for the user
  			current_user.update team: @team
	  		flash[:notice] = "Team created succesfully"
	  		redirect_to root_path
	  	else
	  		@team.destroy
	  		flash[:notice] = "Unable to create team. #{error_message_for membership}"
	  		render :new
	  	end
  	else
  		flash[:notice] = "Unable to create team. #{error_message_for @team}"
  		render :new
  	end
  end

  def team_params
  	params.require(:team).permit(:name)
  end
end
