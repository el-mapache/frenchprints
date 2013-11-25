class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :artwork_id
      t.integer :person_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
