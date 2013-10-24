class CreatePersonnelLocations < ActiveRecord::Migration
  def change
    create_table :personnel_locations do |t|
      t.integer :location_id
      t.integer :person_id
      t.date :start_date
      t.date :end_date
      t.references :trackable, polymorphic: true
      t.timestamps
    end
  end
end
