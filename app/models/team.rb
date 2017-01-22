class Team < ActiveRecord::Base
	validates_presence_of :name

	has_many :team_memberships, dependent: :destroy
	has_many :users, through: :team_memberships
end
