class Product < ActiveRecord::Base
  belongs_to :project
  has_many   :features, -> { order(position: :asc) }

  validates_presence_of :name, :project_id

  before_destroy :set_active_products_to_nil

  after_create :add_mvp_and_demo

  def self.sorted
  	all.sort_by{ |p| p.name.downcase }
  end

  def completed_features
    self.features.where(completed: true)
  end

  def active_features
    self.features.where(completed: false)
  end

  private

	  def set_active_products_to_nil
	  	# loop through the memberships that have this product ID as 'active_product' and
	  	# set value to nil.
	  	TeamMembership.where(active_product_id: self.id).map { |m| m.update(active_product_id: nil) }
	  end

    def add_mvp_and_demo
      # Create two features?
      self.features.build(name: "Example Feature", description: "Something more insightful here...").save
    end
end
