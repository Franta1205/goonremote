class AddRejectedAtToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :rejected_at, :datetime
  end
end
