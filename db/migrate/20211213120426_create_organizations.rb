class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain
      t.string :domain

      t.timestamps
    end
  end
end
