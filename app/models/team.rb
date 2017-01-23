class Team < ActiveRecord::Base
	validates_presence_of :name

	has_many :team_memberships #, dependent: :destroy
	has_many :users, through: :team_memberships
	has_many :projects

	after_destroy :remove_user_team

	def remove_user_team
		# set user.team to either nil or some other team_membership
	end

	def memberships
		team_memberships
	end
end
