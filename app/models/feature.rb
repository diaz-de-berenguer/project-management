class Feature < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project

  validates_presence_of :name, :project_id

  before_save :update_completed_date

  private

  	def update_completed_date
  		self.completed_date = Time.now if self.completed
  	end
end
