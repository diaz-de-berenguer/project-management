class InvertProductAndProjectTables < ActiveRecord::Migration
  def change
  	# Associations
  	rename_column :features,         :product_id,        :project_id
  	rename_column :team_memberships, :active_product_id, :temp_project_id
  	rename_column :team_memberships, :active_project_id, :active_product_id
  	rename_column :team_memberships, :temp_project_id,   :active_project_id
  	rename_column :products,         :project_id,        :product_id



  	# Rename the Products table first, to some name that does not exist
  	rename_table :products, :temp_projects
  	# Rename the Projects table -> to Products
  	rename_table :projects, :products
  	# Rename original products -> to Projects
  	rename_table :temp_projects, :projects
  end
end
