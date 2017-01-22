class TeamMembership < ActiveRecord::Base
	validates_presence_of :user, :team
  belongs_to :user
  belongs_to :team
end
