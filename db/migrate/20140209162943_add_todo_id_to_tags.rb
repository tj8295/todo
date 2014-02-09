class AddTodoIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :todo_id, :integer
  end
end
