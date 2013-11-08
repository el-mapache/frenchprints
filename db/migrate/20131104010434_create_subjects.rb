class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :article_id, null: false
      t.references :subjectable, polymorphic: true
      t.timestamps
    end
  end
end
