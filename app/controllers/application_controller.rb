class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def error_messages(model)
  	model.errors.full_messages.to_sentence
  end

  def secondary_navbar
  	@show_secondary_navigation_bar = true
  end
end
