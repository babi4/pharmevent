class ChengeUserSalary < ActiveRecord::Migration
  def up
    change_column :users, :salary, :integer, default: 0
    change_column :users, :percent, :integer, default: 0, :limit => 1
  end

  def down
    change_column :users, :salary, :integer
    change_column :users, :percent, :integer, :limit => 1
  end

end

