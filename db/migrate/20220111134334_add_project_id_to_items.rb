class AddProjectIdToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :project_id, :integer
  end
end
