class AddPublishedAtToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :published_at, :datetime
  end
end
