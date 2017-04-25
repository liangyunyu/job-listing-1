class AddDetailsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :name, :string
    add_column :jobs, :content, :string
    add_column :jobs, :category, :string
    add_column :jobs, :location, :string
    add_column :jobs, :contact, :string
  end
end
