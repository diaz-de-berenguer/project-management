class AddEstimatedDaysToFeature < ActiveRecord::Migration
  def change
    add_column :features, :estimated_days, :integer
  end
end
