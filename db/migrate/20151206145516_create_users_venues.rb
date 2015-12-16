class CreateUsersVenues < ActiveRecord::Migration
  def change
    create_table :users_venues, :id => false  do |t|
      t.references :venue
      t.references :user
    end
    add_index :users_venues, [:user_id, :venue_id]
    add_index :users_venues, :user_id
  end

  def self.down
    drop_table :users_venues
  end
end
