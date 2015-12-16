class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :venue_id
      t.integer :role
      t.text :note

      t.timestamps null: false
    end
  end
end
