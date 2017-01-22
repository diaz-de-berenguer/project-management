class TeamsController < ApplicationController
	before_action :authenticate_user!

  def new
  	@team = Team.new
  end

  def create
  	@team = Team.new(team_params)
  	if @team.save
  		membership = @team.team_memberships.build(user: current_user)
  		if membership.save
	  		flash[:notice] = "Team created succesfully"
	  		redirect_to root_path
	  	else
	  		@team.destroy
	  		flash[:notice] = "Unable to create team. #{error_messages membership}"
	  		render :new
	  	end
  	else
  		flash[:notice] = "Unable to create team. #{error_messages @team}"
  		render :new
  	end
  end

  def team_params
  	params.require(:team).permit(:name)
  end
end
