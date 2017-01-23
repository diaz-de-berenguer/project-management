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
end
