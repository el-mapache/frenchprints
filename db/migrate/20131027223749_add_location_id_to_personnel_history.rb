class AddLocationIdToPersonnelHistory < ActiveRecord::Migration
  def change
    add_column :personnel_histories, :location_id, :integer, null: false
  end
end
