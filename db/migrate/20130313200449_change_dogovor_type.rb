class ChangeDogovorType < ActiveRecord::Migration
  def up
    change_column :documents_beznal_schets, :dogovor_num, :string
    change_column :documents_beznal_rashods, :dogovor_num, :string
  end

  def down
    change_column :documents_beznal_schets, :dogovor_num, :integer
    change_column :documents_beznal_rashods, :dogovor_num, :integer
  end
end
