class AddSexToPerson < ActiveRecord::Migration
  def change
    add_column :people, :sex, :string, null: false, default: "U"
  end
end
