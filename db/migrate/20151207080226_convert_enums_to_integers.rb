class ConvertEnumsToIntegers < ActiveRecord::Migration
  def change
    remove_column :regions, :behavior
    add_column :regions, :behavior, :integer
    add_column :regions, :type, :integer

    remove_column :triggers, :type
    add_column :triggers, :type, :integer
  end
end
