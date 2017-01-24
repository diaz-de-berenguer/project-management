class FeaturesController < ApplicationController
  before_action :set_feature, only: [:show, :edit, :update, :destroy]

  # # GET /features
  # # GET /features.json
  # def index
  #   @features = Feature.all
  # end

  # GET /features/1
  # GET /features/1.json
  def show
    respond_to :js
  end

  # GET /features/new
  def new
    @feature = Feature.new
    respond_to :js
  end

  # GET /features/1/edit
  def edit
    respond_to :js
  end

  # POST /features
  # POST /features.json
  def create
    @product = Product.find params[:product_id]
    @feature = @product.features.build(feature_params)

    respond_to do |format|
      if @feature.save
        format.html { redirect_to product_path(@feature.product), notice: 'Feature was successfully created.' }
        format.json { render :show, status: :created, location: @feature }
      else
        format.html { render :new }
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /features/1
  # PATCH/PUT /features/1.json
  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.html { redirect_to product_path(@feature.product) }
        # format.json { render :show, status: :ok, location: @feature }
        format.js
      else
        format.html { redirect_to :back, notice: (error_message_for @feature) }
        # format.json { render json: @feature.errors, status: :unprocessable_entity }
        format.js   { @errors = error_message_for @feature }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.json
  def destroy
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to features_url, notice: 'Feature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_params
      params.require(:feature).permit(:name, :description, :scheduled, :completed)
    end
end
