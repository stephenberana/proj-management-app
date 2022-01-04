class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :starting_date
      t.string :completion_date
      t.string :priority
      t.string :status
      t.belongs_to :artifact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
