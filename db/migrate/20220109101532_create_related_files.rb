class CreateRelatedFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :related_files do |t|
      t.string :name
      t.belongs_to :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
