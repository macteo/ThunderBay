class AddMainToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :main, :boolean, :default => false
  end
end
