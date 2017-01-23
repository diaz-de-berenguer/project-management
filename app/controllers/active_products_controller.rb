class ActiveProductsController < ApplicationController
	before_action :authenticate_user!

	def show
		if params[:id] == 'all'
			redirect_to products_path
		else
			redirect_to product_path
		end
	end

	def create
		product = Product.find(params[:id])
		if current_user.active_membership.update(active_product: product)
			redirect_to product_path(product)
		else
			flash[:notice] = "Something went wrong!"
			redirect_to :back
		end
	end

	def destroy
		if current_user.active_membership.update(active_product_id: nil)
			redirect_to root_path
		else
			flash[:notice] = "Something went wrong!"
			redirect_to :back
		end
	end
end
