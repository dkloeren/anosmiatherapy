class AddImageToSmellPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :smell_programs, :image, :string
  end
end
