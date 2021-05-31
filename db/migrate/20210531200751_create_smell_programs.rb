class CreateSmellPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :smell_programs do |t|
      t.references :scent, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
