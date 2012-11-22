class RemoveStateFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :state
  end

  def down
    add_column :events, :state, :string
  end
end
