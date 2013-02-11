class RenameTypeInDocumentsBeznalRashods < ActiveRecord::Migration
  def up
    rename_column :documents_beznal_rashods, :type, :type_rashod
  end

  def down
    rename_column :documents_beznal_rashods, :type_rashod, :type
  end
end
