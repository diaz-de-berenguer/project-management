class AddActiveProjectToTeamMembership < ActiveRecord::Migration
  def change
    add_reference   :team_memberships, :active_project, index: true
    add_foreign_key :team_memberships, :projects, column: :active_project_id
  end
end
