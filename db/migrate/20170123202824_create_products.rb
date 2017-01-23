class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end