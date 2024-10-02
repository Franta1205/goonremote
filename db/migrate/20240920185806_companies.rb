class Companies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :website_url
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
