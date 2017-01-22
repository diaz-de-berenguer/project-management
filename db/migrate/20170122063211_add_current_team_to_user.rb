class AddCurrentTeamToUser < ActiveRecord::Migration
  def change
    add_reference :users, :team, index: true, foreign_key: { on_delete: :cascade }
  end
end
