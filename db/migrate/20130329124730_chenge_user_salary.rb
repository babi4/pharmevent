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

User.all.each do |t|
  t.salary = 0 unless t.salary
  t.percent = 0 unless t.percent
  t.save
end
