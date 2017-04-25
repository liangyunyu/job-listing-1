class AddDetailsToResumes < ActiveRecord::Migration[5.0]
  def change
    add_column :resumes, :name, :string
    add_column :resumes, :description, :string
    add_column :resumes, :category, :string
    add_column :resumes, :location, :string
    add_column :resumes, :contact, :string
  end
end
