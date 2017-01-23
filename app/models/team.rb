class Team < ActiveRecord::Base
	validates_presence_of :name

	has_many :team_memberships #, dependent: :destroy
	has_many :users, through: :team_memberships
	has_many :projects

	before_destroy :remove_user_team

	def remove_user_team
		# set user.team to either nil or some other team_membership
		User.where(team_id: self.id).each do |user|
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
		end
	end

	def memberships
		team_memberships
	end
end
