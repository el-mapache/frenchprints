class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.string :name
      t.integer :gallery_id
      t.integer :person_id

      t.timestamps
    end
  end
end
