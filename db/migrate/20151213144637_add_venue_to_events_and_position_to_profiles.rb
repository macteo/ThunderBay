class AddVenueToEventsAndPositionToProfiles < ActiveRecord::Migration
  def change
    add_column :events, :venue_id, :integer
    add_column :events, :region_id, :integer
    add_column :profiles, :inside, :boolean
  end
end
