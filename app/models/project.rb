class Project < ActiveRecord::Base
  belongs_to :team

  before_destroy :set_active_projects_to_nil

  def set_active_projects_to_nil
  	# loop through the memberships that have this project ID as 'active_project' and
  	# set value to nil.
  	TeamMembership.where(active_project_id: self.id).map { |m| m.update(active_project_id: nil) }
  end
end
