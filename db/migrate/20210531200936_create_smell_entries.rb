class CreateSmellEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :smell_entries do |t|
      t.references :smell_program, null: false, foreign_key: true
      t.integer :strength_rating
      t.integer :accuracy_rating

      t.timestamps
    end
  end
end
