class AddPlanToOrganizations < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :plan, :string
  end
end
