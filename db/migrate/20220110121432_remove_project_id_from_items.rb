class RemoveProjectIdFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :project_id
    add_column :items, :task_id, :integer
  end
end
