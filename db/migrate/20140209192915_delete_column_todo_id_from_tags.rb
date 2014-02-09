class DeleteColumnTodoIdFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :todo_id, :integer
  end
end
