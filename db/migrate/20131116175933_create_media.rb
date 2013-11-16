class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :image
      t.references :imagable, polymorphic: true
      t.timestamps
    end
  end
end
