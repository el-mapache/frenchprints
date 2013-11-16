class AddTitleToPersonnelHistories < ActiveRecord::Migration
  def change
    add_column :personnel_histories, :title, :string
  end
end
