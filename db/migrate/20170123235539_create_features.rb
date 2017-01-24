class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
    	t.integer :position # use to organize and order
      t.string  :name
      t.text    :description
      t.boolean :scheduled, default: false
      t.boolean :completed, default: false
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
