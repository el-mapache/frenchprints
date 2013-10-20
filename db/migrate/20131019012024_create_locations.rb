class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.date :start_date
      t.date :end_date
      t.string :city
      t.string :country
      t.string :country_code
      t.string :street_address
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
