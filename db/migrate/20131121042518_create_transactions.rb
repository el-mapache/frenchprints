class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.text :description
      t.integer :artwork_id
      t.integer :buyer_id
      t.integer :seller_id
      t.date :sold_on

      t.timestamps
    end
  end
end
