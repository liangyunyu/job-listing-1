class AddWageUnitToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :wage_unit, :string
  end
end
