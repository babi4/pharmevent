class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index :roles, [:name], :name => "index_roles_names", :unique => true
    add_index(:users_roles, [ :user_id, :role_id ], :unique => true)
  end
end
