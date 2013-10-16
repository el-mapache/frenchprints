class CreateRepresentations < ActiveRecord::Migration
  def change
    create_table :representations do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :current
      t.integer :person_id
      t.integer :represented_id

      t.timestamps
    end
  end
end
