class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :secondary_navbar

  def error_messages(model)
  	model.errors.full_messages.to_sentence
  end

  def secondary_navbar
  	if current_user.active_project
	  	@show_secondary_navigation_bar = true
	  end
  end
end
