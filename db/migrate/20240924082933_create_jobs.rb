class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :location, null: false, default: "anywhere"
      t.string :apply_link, null: false
      t.string :currency, null: false, default: "$"
      t.integer :salary_min
      t.integer :salary_max
      t.string :salary_period, default: "Yearly"
      t.string :employment_type, default: "full_time"
      t.string :experience
      t.references :company, foreign_key: true, null: false
      t.timestamps
    end
  end
end
