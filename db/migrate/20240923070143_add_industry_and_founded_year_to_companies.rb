class AddIndustryAndFoundedYearToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :linkedin, :string
    add_column :companies, :x, :string
    add_column :companies, :career_page, :string
    add_column :companies, :description, :string, null: false
  end
end
