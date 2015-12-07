class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :subtype
      t.jsonb :payload
      t.datetime :timestamp
      t.string :uuid
      t.integer :user_id
      t.integer :app_id
      t.string :attachment

      t.timestamps null: false
    end
  end
end
