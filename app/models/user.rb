class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :team_memberships #, dependent: :destroy
	has_many :teams, through: :team_memberships
	has_many :beta_user_invites # Shold have ~5 user invites

	belongs_to :team # Sets the 'active' team for the user

	before_create :check_against_beta_invites

	validate :team_id_must_have_memberhsip

	def active_product
		self.active_membership ? self.active_membership.active_product : nil
	end

	def active_project
		self.active_membership ? self.active_membership.active_project : nil
	end

	def active_membership
		self.team_memberships.find_by team_id: self.team_id
	end

	private

		def check_against_beta_invites
			invite = BetaUserInvite.find_by email: self.email
			if invite.nil?
				errors.add(:email, "has not been invited.")
				return false
			else
				invite.update(redeemed: true)
			end
		end

		def team_id_must_have_memberhsip
			unless self.team_memberships.map(&:team_id).include? self.team_id
				self.errors.add :team, "must have a membership"
			end
		end
end
