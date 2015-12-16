class RemoveUsersVenuesHabtm < ActiveRecord::Migration
  def change
    drop_table :users_venues
  end
end
