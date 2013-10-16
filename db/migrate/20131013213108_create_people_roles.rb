class CreatePeopleRoles < ActiveRecord::Migration
  def change
    create_table :people_roles do |t|
      t.belongs_to :person, null: false
      t.belongs_to :role, null: false
      
    end
    add_index :people_roles, [ :person_id, :role_id ], :unique => true, :name => 'by_person_and_role'
  end
end
