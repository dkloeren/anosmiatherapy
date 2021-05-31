class CreateScents < ActiveRecord::Migration[6.1]
  def change
    create_table :scents do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
