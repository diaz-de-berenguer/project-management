class AddActiveProductToMembership < ActiveRecord::Migration
  def change
    add_reference   :team_memberships, :active_product, index: true
    add_foreign_key :team_memberships, :products, column: :active_product_id
  end
end
