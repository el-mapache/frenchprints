class AddReferencesToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :locatable_id, :integer, null: false
    add_column :locations, :locatable_type, :string, null: false
  end
end
