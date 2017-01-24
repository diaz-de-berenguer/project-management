class Product < ActiveRecord::Base
  belongs_to :project
  has_many   :features, -> { order(position: :asc) }

  validates_presence_of :name, :project_id

  before_destroy :set_active_products_to_nil

  def self.sorted
  	all.sort_by{ |p| p.name.downcase }
  end

  private

	  def set_active_products_to_nil
	  	# loop through the memberships that have this product ID as 'active_product' and
	  	# set value to nil.
	  	TeamMembership.where(active_product_id: self.id).map { |m| m.update(active_product_id: nil) }
	  end
end
