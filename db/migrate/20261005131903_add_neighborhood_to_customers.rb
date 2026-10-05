class AddNeighborhoodToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :neighborhood, :string
  end
end
