class AddWageToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :wage, :integer
  end
end
