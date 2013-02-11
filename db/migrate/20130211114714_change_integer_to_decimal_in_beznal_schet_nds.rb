class ChangeIntegerToDecimalInBeznalSchetNds < ActiveRecord::Migration
  def up
    change_column :documents_beznal_schets, :nds, :decimal, :precision => 8, :scale => 2
  end

  def down
    change_column :documents_beznal_schets, :nds, :integer
  end
end
