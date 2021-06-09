class AddOrderToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :order, :integer
  end
end
