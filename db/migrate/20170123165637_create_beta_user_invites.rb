class CreateBetaUserInvites < ActiveRecord::Migration
  def change
    create_table :beta_user_invites do |t|
      t.string     :email, index: true
      t.references :user,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
