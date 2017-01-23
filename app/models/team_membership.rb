class TeamMembership < ActiveRecord::Base
	validates_presence_of :user, :team
  belongs_to :user
  belongs_to :team
  belongs_to :active_project, class_name: 'Project'
  belongs_to :active_product, class_name: 'Product'

  before_destroy :remove_active_team
  after_create   :add_active_team

  private

  	def remove_active_team
  		user = self.user
  		if user.team_memberships.count > 1 && user.team_id == self.team_id
  			# create an array with user memberships 'team_ids'
  			team_ids     = user.team_memberships.map &:team_id
  			# remove current team from array
  			team_ids.delete(self.team_id)
  			# set the team_id value
  			user.team_id = team_ids.last
  		else
  			user.team_id = nil
  		end
  		user.save!
  	end

  	def add_active_team
  		user = self.user
  		if user.team_id.nil?
  			user.team_id = self.team_id
  		end
  		user.save!
  	end
end
