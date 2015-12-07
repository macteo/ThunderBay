class ChangeAppIdToIdentifierForEvents < ActiveRecord::Migration
  def change
    remove_column :events, :app_id
    add_column :events, :app_id, :string
  end
end
