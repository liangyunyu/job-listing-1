class AddWageToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :wage, :integer
  end
end
