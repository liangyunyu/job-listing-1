class AddIsHiddenToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :is_hidden, :boolean
  end
end
