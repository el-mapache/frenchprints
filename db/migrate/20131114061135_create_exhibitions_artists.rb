class CreateExhibitionsArtists < ActiveRecord::Migration
  def change
    create_table :exhibitions_artists do |t|
      t.integer :exhibition_id
      t.integer :person_id

      t.timestamps
    end
  end
end
