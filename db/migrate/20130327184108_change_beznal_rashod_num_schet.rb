class ChangeBeznalRashodNumSchet < ActiveRecord::Migration
  def up
    change_column :documents_beznal_rashods, :num_schet, :string
  end

  def down
    change_column :documents_beznal_rashods, :num_schet, :integer
  end
end
