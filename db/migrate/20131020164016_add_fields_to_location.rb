class AddFieldsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :state, :string
    add_column :locations, :province, :string
  end
end
