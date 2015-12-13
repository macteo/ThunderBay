class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :content
      t.string :image
      t.jsonb :payload
      t.integer :venue_id

      t.timestamps null: false
    end
  end
end
