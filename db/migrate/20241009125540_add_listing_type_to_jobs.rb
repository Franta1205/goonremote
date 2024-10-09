class AddListingTypeToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :featured, :boolean, default: false
  end
end
