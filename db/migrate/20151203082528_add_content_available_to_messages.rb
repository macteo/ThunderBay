class AddContentAvailableToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :content_available, :integer
    add_column :messages, :payload, :jsonb
  end
end
