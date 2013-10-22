class AddFieldToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :event_name, :string
  end
end
