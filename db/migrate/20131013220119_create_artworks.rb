class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :medium
      t.string :dimensions
      t.date :release_date
      t.integer :artist_id

      t.timestamps
    end
  end
end
