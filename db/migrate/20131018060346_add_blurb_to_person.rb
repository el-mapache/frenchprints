class AddBlurbToPerson < ActiveRecord::Migration
  def change
    add_column :people, :blurb, :string
  end
end
