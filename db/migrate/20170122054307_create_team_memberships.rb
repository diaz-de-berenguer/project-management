class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :team, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
