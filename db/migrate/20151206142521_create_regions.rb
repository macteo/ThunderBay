class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :uuid
      t.integer :major
      t.integer :minor
      t.float :lat
      t.float :lon
      t.float :radius
      t.integer :venue_id
      t.string :name
      t.text :note
      t.string :identifier
      t.string :behavior
      t.integer :enter_trigger_id
      t.integer :exit_trigger_id
      t.integer :range_trigger_id

      t.timestamps null: false
    end
  end
end
