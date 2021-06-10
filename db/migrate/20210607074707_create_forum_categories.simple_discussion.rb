# This migration comes from simple_discussion (originally 20170417012930)
class CreateForumCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :forum_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :color, default: "000000"

      t.timestamps
    end

    ForumCategory.reset_column_information

    ForumCategory.create(
      name: "General",
      color: "#94A2B3
"
    )

    ForumCategory.create(
      name: "Feedback",
      color: "#94B3A2
"
    )
  end
end
