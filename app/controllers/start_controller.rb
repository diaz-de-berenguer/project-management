class StartController < ApplicationController
	before_action :authenticate_user!

  def home
  	if current_user.team.nil?
  		redirect_to new_team_path
  	end
  end
end
