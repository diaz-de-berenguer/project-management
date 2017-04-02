class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if current_user.team.nil?
      redirect_to new_team_path
    elsif current_user.active_product.nil?
      @products = current_user.team.products
    else
      redirect_to product_path(current_user.active_product)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if current_user.team.nil?
      redirect_to new_team_path
    elsif current_user.active_product.nil?
      redirect_to products_path
    elsif current_user.active_project
      redirect_to project_path(current_user.active_project)
    else
      set_product
      @projects = @product.projects.sorted
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.team = current_user.team

    respond_to do |format|
      if @product.save
        membership = current_user.active_membership
        if membership.update active_product: @product
          format.html { redirect_to @product }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, notice: "Something went wrong. #{error_message_for membership}" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, notice: "Something went wrong. #{error_message_for @product}" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description)
    end
end
