class CreateAuthorsArticles < ActiveRecord::Migration
  def change
    create_table :authors_articles do |t|
      t.integer :article_id, null: false
      t.integer :person_id,  null: false

      t.timestamps
    end
  end
end
