class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :starting_date
      t.string :completion_date
      t.string :status
      t.string :priority
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :artifact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
