class AddTaskIdToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :task_id, :integer
  end
end
