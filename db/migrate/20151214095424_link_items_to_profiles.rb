class LinkItemsToProfiles < ActiveRecord::Migration
  def change
    create_table :items_profiles, id: false do |t|
      t.integer :item_id
      t.integer :profile_id
    end
  end
end
