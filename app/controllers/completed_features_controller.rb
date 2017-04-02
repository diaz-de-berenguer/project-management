class CompletedFeaturesController < ApplicationController
	before_action :authenticate_user!

  def index
  	# @completed_features = current_user.team
  	# .features.select_by(&:completed).sort_by(&:completed_date)

  	# @completed_features = current_user.team.products.map{ |p| { product: p, features: p.features.select(&:completed).sort_by(&:completed_date).reverse! } }
  	@completed_features = current_user.active_product.features.select(&:completed).sort_by(&:completed_date).reverse!
  end
end
