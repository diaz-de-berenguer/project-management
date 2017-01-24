class Feature < ActiveRecord::Base
  belongs_to :product
  acts_as_list scope: :product

  validates_presence_of :name, :product_id
end
