class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :team_memberships, dependent: :destroy
	has_many :teams, through: :team_memberships

	belongs_to :team # Sets the 'active' team for the user
end
