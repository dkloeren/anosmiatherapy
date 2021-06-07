class AddCommentToSmellEntry < ActiveRecord::Migration[6.1]
  def change
    add_column :smell_entries, :comment, :text
  end
end
