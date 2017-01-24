class Feature < ActiveRecord::Base
  belongs_to :product
  has_many   :features, -> { order(position: :asc) }
  validates_presence_of :name, :product_id

  after_create :add_mvp_and_demo

  def add_mvp_and_demo
  	# Create two features?
  end
end
