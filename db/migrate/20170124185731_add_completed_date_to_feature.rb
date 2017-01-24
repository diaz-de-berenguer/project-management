class AddCompletedDateToFeature < ActiveRecord::Migration
  def change
    add_column :features, :completed_date, :datetime
  end
end
