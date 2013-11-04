class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title,         null: false
      t.date :date_published,  null: false
      t.string :pages,         null: false
      t.integer :journal_id,   null: false

      t.timestamps
    end
  end
end
