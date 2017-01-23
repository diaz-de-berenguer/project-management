class Product < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :name, :project_id

  def self.sorted
  	all.sort_by{ |p| p.name.downcase }
  end
end
