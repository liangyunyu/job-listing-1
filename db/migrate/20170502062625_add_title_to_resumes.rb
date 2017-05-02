class AddTitleToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :title, :string
  end
end
