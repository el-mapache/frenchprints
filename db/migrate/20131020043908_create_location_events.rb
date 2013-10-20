class CreateLocationEvents < ActiveRecord::Migration
  def change
    create_table :location_events do |t|
      t.string :name
      t.integer :location_id
      t.references :locateable, polymorphic: true
      t.timestamps
    end
  end
end
