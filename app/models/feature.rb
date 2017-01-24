class Feature < ActiveRecord::Base
  belongs_to :product
  acts_as_list scope: :product

  validates_presence_of :name, :product_id

  before_save :update_completed_date

  private

  	def update_completed_date
  		self.completed_date = Time.now if self.completed
  	end
end
