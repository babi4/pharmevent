class ChangeNdsType < ActiveRecord::Migration
  def up
    change_column :documents_beznal_schets, :nds, :decimal, :precision => 12, :scale => 2
    change_column :documents_beznal_rashods, :nds, :decimal, :precision => 12, :scale => 2
  end

  def down
    change_column :documents_beznal_schets, :nds, :decimal, :precision => 8, :scale => 2
    change_column :documents_beznal_rashods, :nds, :integer
  end
end
