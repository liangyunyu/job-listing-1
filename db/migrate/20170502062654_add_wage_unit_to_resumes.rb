class AddWageUnitToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :wage_unit, :string
  end
end
