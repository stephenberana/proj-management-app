class AddKeyToRelatedFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :related_files, :key, :string
  end
end
