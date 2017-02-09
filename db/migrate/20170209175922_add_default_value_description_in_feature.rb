class AddDefaultValueDescriptionInFeature < ActiveRecord::Migration
  def change
  	change_column_default :features, :description, ""
  end
end
