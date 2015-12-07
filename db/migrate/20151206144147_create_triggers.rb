class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :type
      t.string :url
      t.string :name
      t.jsonb :payload

      t.timestamps null: false
    end
  end
end
