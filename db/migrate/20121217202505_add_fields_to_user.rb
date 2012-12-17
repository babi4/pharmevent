class AddFieldsToUser < ActiveRecord::Migration
  def up
    remove_column :users, :name

    %w(first_name last_name middle_name).each do |field|
      add_column :users, field, :string
    end
    add_column :users, :salary, :integer
    add_column :users, :percent, :integer, :limit => 1
  end

  def down
    %w(first_name last_name middle_name salary percent).each do |field|
      remove_column :users, field
    end
    add_column :users, :name, :string
  end
end
